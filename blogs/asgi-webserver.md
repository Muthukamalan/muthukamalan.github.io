# ASGI
> WSGI:: Web Server Gateway Interface

ASGI is a standard interface positioned as a spiritual successor to WSGI and it all started with **async/await**.  

### History
- Earlier, execute thing in concurrently in python could only be achieved using *multithread, multiprocessing*
- then added *asyncio* to the standard library, adding support for cooperative multitasking on top of generators and the yield from syntax.
- **async/await** syntax was added in Python 3.5, now we had **native coroutines independent of the underlying implementation**

### Overview
ASGI can be thought of as the glue that allows Python asynchronous servers and applications to communicate with each other.

Mental Model looks like: 

![ASGI communication Interface](./images/asgi-intro-highlevel.png)

ASGI consists of two different components:
- A **protocol server**, which terminates sockets and translates them into connections and per-connection event messages
- An **application**, which lives inside a protocol server, is instanciated once per connection, and handles event messages as they happen.


As per spec, ASGI specifies, _message format_ and _how those msg should be exchanged the application an protocol server_ that runs it

But in Actual Overview in detail:

![ASGI](./images/asgi-intro-full.png)

#### Basics
ASGI relies on the following mental model:  when the client conncts to server it instanciate an app.


```python
from collections.abc import Callable, Awaitable
AsyncFunc = Callable[Awaitable]


# https://asgi.readthedocs.io/en/latest/specs/main.html#applications
async def app(scope:dict, receive:AsyncFunc, send:AsyncFunc):
    """
    scope: is a dictionary that contains information about the incoming request. Its contents vary between HTTP and WebSocket connections.
    receive: is an asynchronous function used to receive ASGI event messages.
    send: is an asynchronous function used to send ASGI event messages.
    """
    ...
```

- `app` is callable
- we feed incoming bytes to app ($III^{ly}$  like an app)  and send back whatever bytes comes out


```python
# main.py
async def app(scope,receive,send):
    scope = {
            "type": "http",  # The type of connection ("http", "websocket")
            "http_version": "1.1",  # HTTP version
            "method": "GET",  # HTTP method, like GET, POST
            "path": "/",  # URL path requested by the client
            # "query_string": b"name=John",  # Query string in the request
            # "headers": [  # HTTP/Websocket headers
            #     (b"host", b"example.com"),
            #     (b"user-agent", b"Mozilla/5.0"),
            #     (b"accept", b"text/html"),
            # ],
            # "client": ("127.0.0.1", 12345),  # Client IP address and port
            # "server": ("127.0.0.1", 8000),  # Server IP address and port
        }
    assert scope['type']=="http" 
    await send({
        "type":"http.response.start",
        "status":200,
        "headers": [[b"content-type",b"text/plain"]]
    })
    await send({
        "type":"http.response.body",
        "body":b"Hello, world!"
    })
```
you simply start app as `uvicorn main:app --reload` and do `curl -v localhost:8000` to see the results. 

```python
# app.py
import time

class TimingMiddleware:
    def __init__(self, app):
        self.app = app

    async def __call__(self, scope, receive, send):
        start_time = time.time()
        await self.app(scope, receive, send)
        end_time = time.time()
        print(f"Took {end_time - start_time:.2f} seconds")

app = TimingMiddleware(app)
```
you simply start app as `uvicorn main:app --reload` and do `curl -v localhost:8000` to see the results with added functionality of Timing Middleware

# FastAPI Deconstructed


In the FastAPI all we do is the APP
```py3
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
async def hello():
    return {"message": "Hello, World!"}
```
With a simple setup like this, FastAPI takes care of:
- Defining an asynchronous route.
- Parsing and validating requests.
- Serializing JSON responses.
- Generating automatic API docs with OpenAPI specification 


## Building Blocks
- ASGI:: The asynchronous protocol layer that handles communication between the server and the application
    - uvicorn
    - hypercorn
    - granian
- Pydantic: A library for data validation and parsing, used in FastAPI to ensure data consistency and reliability.
- Dependency Injection: A built-in dependency injection system that makes it easy to inject dependencies like database connections, services, or configuration etc.

#### Uvicorn
Uvicorn is built on top of uvloop, a high-performance implementation of the asyncio event loop, which enhances its ability to handle I/O-bound tasks efficiently.

Request Lifecycle in Uvicorn:
- Accept Connection: Uvicorn accepts a connection and creates an ASGI scope for the incoming HTTP request, including metadata like headers and method.
- Dispatch Request: The scope is dispatched to the FastAPI application. Uvicorn uses uvloop to asynchronously manage the flow.
- Receive Data: Uvicorn processes incoming request data through ASGI receive events.
- Send Response: FastAPI responds with an ASGI send event. Uvicorn packages the response (status code, headers, body) and returns it to the client.

![Journey](./images/ASGI%20Journey.png)


#### Pydantic
Pydantic - Data Validation and Serialization
FastAPI’s data validation relies on Pydantic, a library that simplifies the handling of complex data types and validation. Pydantic enables FastAPI to enforce strict data validation rules on incoming request data and outgoing response data.

```python
from fastapi import FastAPI
from pydantic import BaseModel

# Initialize FastAPI app (this is like initializing Starlette)
app = FastAPI()

# Pydantic model for request data validation
class Item(BaseModel):
    name: str
    price: float
    is_offer: bool = None

# Route with path parameters and Pydantic request body validation
@app.post("/items/")
async def create_item(item: Item):
    return {"item": item}


#!curl -X POST "<http://127.0.0.1:8000/items/>" -H "Content-Type: application/json" -d '{"name": "Table", "price": 150.0}'
```

#### Dependency Injection in FastAPI
FastAPI’s dependency injection system allows modular, reusable code by injecting resources like database connections, authentication layers, or shared configurations directly into route functions.

```python
from fastapi import Depends

def get_db():
    db = DatabaseConnection()
    try:
        yield db
    finally:
        db.close()

@app.get("/items/")
async def read_items(db=Depends(get_db)):
    return db.fetch_all_items()
```
With `Depends`, FastAPI manages dependencies automatically, enabling clean, modular, and testable code. Dependency injection is especially useful for managing external services, as it allows centralized control of resource lifecycles.



# The Journey of an HTTP Request in Python
This diagram shows the complete path, but it barely scratches the surface. Let’s explore each layer in detail.

![Journey](./images/BigPicture.png)

## 1. The Kernel Receives Data
### Network Interface and Interrupts
When data arrives at your server, the first component to know about it isn’t your Python application or even the operating system’s high-level network code. It’s the Network Interface Card (NIC) hardware itself.

Here’s what happens:
- Packet Arrival: The NIC receives electrical signals (or light pulses for fiber) representing your HTTP request
- DMA Transfer: The NIC uses Direct Memory Access to write the packet data directly into a pre-allocated kernel memory buffer
- Hardware Interrupt: The NIC triggers a hardware interrupt to notify the CPU that data has arrived
- Interrupt Handler: The kernel’s interrupt handler is invoked, which schedules the network stack to process this data

This all happens in microseconds, and it’s happening for potentially thousands of packets per second on a busy server

![Stack](./images/NIC_toNetworkStack.png)

### TCP/IP Stack Processing
Once the interrupt handler schedules packet processing, the kernel’s network stack processes the packet through multiple protocol layers. This happens entirely in kernel space.

- Ethernet Layer: Strips off the Ethernet frame, validates the destination MAC address
- IP Layer: Validates IP header, checks destination IP, handles fragmentation if needed
- TCP Layer: This is where the real work happens. The kernel:
    - Validates checksum: Ensures data integrity
    - Looks up connection: Uses (src_ip, src_port, dst_ip, dst_port) to find the socket
    - Checks sequence numbers: Handles out-of-order packets and duplicates
    - Updates state machine: Manages TCP states (ESTABLISHED, FIN_WAIT, etc.)
    - Performs flow control: Adjusts receive window based on buffer availability
    - Sends ACK: Acknowledges received data automatically
- Delivering to the socket: Once the kernel identifies the destination socket, it:
    - Copies payload data into the socket’s receive buffer
    - Updates buffer pointers and available byte count
    - Wakes any process/coroutine waiting on this socket (via the wait queue)

Let’s visualize the journey:

![Image](./images/NIC_toBuffer.png)

The entire journey from NIC interrupt to socket buffer typically takes 10-100 microseconds on modern hardware. This processing happens for every single packet, which is why kernel optimization is crucial for high-performance networking.

### Socket Buffers: The Kernel-Userspace Bridge
Once the kernel identifies which socket the packet belongs to using the connection’s four-tuple source IP:port, dest IP:port, it writes the data into that socket’s receive buffer, a ring buffer allocated in kernel memory. This buffer is the critical interface between kernel space and user space.

Each socket maintains two buffers:
```c
// Kernel maintains these internally (simplified representation)
struct socket_buffers {
    char recv_buffer[SO_RCVBUF];  // Default: 208KB on Linux
    char send_buffer[SO_SNDBUF];  // Default: 208KB on Linux
    size_t recv_bytes_available;
    size_t send_bytes_used;
    wait_queue_head_t wait_queue; // Processes waiting on this socket
};
```
When TCP segments arrive, the kernel:
1. Validates sequence numbers and checksums
1. Reassembles out-of-order segments using sequence numbers
1. Writes data to the receive buffer
1. Sends ACK back to sender (automatic)
1. Wakes any process/coroutine blocked on this socket
1. The receive buffer size determines TCP’s receive window—how much unacknowledged data the sender can transmit. If your application doesn’t read fast enough and the buffer fills, the kernel advertises a zero window, throttling the sender.

For sending, when you call send(), data is copied from user space to the kernel’s send buffer. The kernel then:

1. Segments data into TCP packets (Maximum Segment Size typically 1460 bytes)
1. Transmits segments with sequence numbers
1. Retains copies until ACKed (for potential retransmission)
1. Removes acknowledged data from buffer

You can inspect and tune buffer sizes:
```python
import socket

sock = socket.socket()
# Check current sizes
recv_buf = sock.getsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF)
send_buf = sock.getsockopt(socket.SOL_SOCKET, socket.SO_SNDBUF)

# Increase for high-bandwidth connections
sock.setsockopt(socket.SOL_SOCKET, socket.SO_RCVBUF, 1048576)  # 1MB
sock.setsockopt(socket.SOL_SOCKET, socket.SO_SNDBUF, 1048576)
```


These buffers decouple application read/write speed from network speed, enabling efficient pipelining and flow-control essential for TCP’s reliability guarantees. Let’s take a look at the full picture:

![network_to_app](./images/Network_toApp.png)

##  2. System Calls and File Descriptors
### The Socket File Descriptor
In Unix-like systems, the philosophy is “everything is a file”, including network sockets. When your application creates a socket, the kernel returns a file descriptor: a small non-negative integer that serves as an index into the process’s file descriptor table.
```py
import socket

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
fd = sock.fileno()  # Returns an integer like 3, 4, 5, etc.
print(f"Socket file descriptor: {fd}")
```

What the file descriptor represents:

- The kernel maintains a per-process table mapping file descriptors to kernel data structures. For sockets, this points to a struct socket containing:
- Socket buffers (send/receive)
- Connection state (ESTABLISHED, CLOSE_WAIT, etc.)
- Peer address (IP:port )
- Protocol-specific data (TCP sequence numbers, window size)
- File operations table (read, write, close functions)

Why file descriptors matter:

Every socket operation requires passing this file descriptor to the kernel:
```py
import os

# All these operations use the file descriptor internally
data = sock.recv(4096)        # → recv(fd, buffer, 4096)
sock.send(b"data")            # → send(fd, "data", 4)
sock.close()                  # → close(fd)

# You can even use low-level os functions
os.read(fd, 4096)             # Works! Treats socket like a file
os.write(fd, b"data")         # Also works!
```

File descriptor limits:

Each process has limits on open file descriptors (typically 1024 by default, configurable up to system limits). This matters for servers handling thousands of connections:
```sh
ulimit -n  # Soft limit: 1024
ulimit -n 65536
```
When you run out of file descriptors, accept() fails with “Too many open files”, a common production issue. ASGI servers handle this by configuring appropriate limits and connection pooling.

### System Calls: Crossing the Boundary
System calls are the mechanism for transitioning from user space (where your Python code runs) to kernel space (where the OS manages hardware and resources). This transition is expensive compared to normal function calls. It involves context switching, privilege level changes, and potentially copying data.

What happens during a system call:
```python
import socket

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
```

This innocent-looking Python call triggers:

- Python → C library wrapper
- C library → software interrupt (syscall instruction)
- CPU switches to kernel mode
- Kernel validates parameters, performs operation
- CPU switches back to user mode
- Return value propagated back to Python

Here are the key system calls involved in our HTTP request journey:
```python
import socket

# socket() - Create socket structure in kernel
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# bind() - Associate socket with address
sock.bind(('0.0.0.0', 8000))

# listen() - Mark socket as passive, create accept queue
sock.listen(128)

# accept() - Retrieve connection from queue (blocks if empty)
client, addr = sock.accept()

# recv() - Copy data from kernel buffer to user space
data = client.recv(4096)

# send() - Copy data from user space to kernel buffer
client.send(b"HTTP/1.1 200 OK\r\n\r\n")

# close() - Release socket resources
client.close()
```


![Appto_Socket](./images/App_to_socket.png)


### Blocking vs Non-Blocking Sockets
Traditional socket programming is blocking. When you call recv() and there’s no data available, your process goes to sleep until data arrives. This is fine for simple applications, but it’s disastrous for servers that need to handle thousands of concurrent connections.
```py
import socket

# Blocking socket (default)
sock = socket.socket()
sock.connect(('example.com', 80))
data = sock.recv(4096)  # This BLOCKS until data arrives
print(data)
```

To handle multiple connections, you have three main options:

- **Multi-threading**: One thread per connection (expensive, doesn’t scale to thousands)
- **Multi-processing**: One process per connection (even more expensive)
- **Non-blocking I/O with event loops**: Handle many connections in one thread (efficient, scalable)

**ASGI** is built on non-blocking sockets and uses an event loop to efficiently multiplex between many connections

```python
import socket
import select

# Non-blocking socket
sock = socket.socket()
sock.setblocking(False)  # This is the key!

try:
    sock.connect(('example.com', 80))
except BlockingIOError:
    pass  # Connect is in progress

# Use select/epoll to wait for socket to be ready
select.select([sock], [sock], [], 5.0)
# Now socket is ready for I/O
```

From the moment network packets arrive at your NIC, through hardware interrupts and DMA transfers, to TCP/IP processing and socket buffers, every step is orchestrated by the kernel with microsecond precision.

The key insights from this exploration:

- Hardware and kernel handle the heavy lifting: Your application never sees individual packets, TCP handshakes, or retransmissions, the kernel manages all of this automatically
- Socket buffers are the critical interface: These kernel-space ring buffers decouple network speed from application speed, enabling efficient flow control
- System calls are expensive: Every transition between user and kernel space involves context switches, which is why minimizing these calls matters for performance

At this point in our journey, data sits ready in socket receive buffers, waiting for your application to read it. The kernel has done its job ensuring reliable, ordered delivery of bytes


The data is sitting in kernel memory and your Python application still hasn’t touched it.

We’ll explore how Python’s asyncio event loop efficiently monitors thousands of sockets using epoll, how ASGI servers like Uvicorn translate raw bytes into structured messages, and how your FastAPI application processes requests without blocking.

This is where the elegance of ASGI shines.

Let’s cross the system call boundary and enter the world of async Python.



## 3. The Event Loop and I/O Multiplexing
### The Problem with Blocking I/O
Imagine a web server handling 10,000 concurrent connections. With blocking I/O, you’d need 10,000 threads or processes. Each thread consumes memory (typically 1-8 MB of stack space), and context switching between thousands of threads destroys CPU cache efficiency.

The solution is I/O multiplexing: using a single thread to monitor many file descriptors and only processing them when they’re ready

### Enter epoll/kqueue/select
Operating systems provide system calls for efficient I/O multiplexing:

- select: The oldest, works on all platforms, limited to ~1024 file descriptors
- poll: Similar to select but no hard limit on file descriptors
- epoll (Linux): Highly efficient (uses a red–black tree), O(1) performance for ready events
- kqueue (BSD/macOS): Similar to epoll

Python’s asyncio uses the most efficient mechanism available on your platform. On Linux, that’s epoll.

```py
import select
import socket

# Create a listening socket
server = socket.socket()
server.setblocking(False)
server.bind(('0.0.0.0', 8000))
server.listen(128)

# Create epoll object
epoll = select.poll()
epoll.register(server.fileno(), select.POLLIN)

# Event loop
connections = {}
while True:
    # Wait for events (this is a blocking syscall, but efficient!)
    events = epoll.poll()

    for fd, event in events:
        if fd == server.fileno():
            # New connection
            client, addr = server.accept()
            client.setblocking(False)
            epoll.register(client.fileno(), select.POLLIN)
            connections[client.fileno()] = client
        else:
            # Data on existing connection
            client = connections[fd]
            data = client.recv(4096)
            print(data.decode())
            client.send(b"HTTP/1.1 200 OK\r\n\r\nHello")
            epoll.unregister(fd)
            client.close()
            del connections[fd]
```

This pattern register file descriptors with epoll, wait for events, handle ready sockets is the foundation of all async Python frameworks.

### Python’s asyncio Event Loop

![epoll](./images/epoll_coroutine.png)

```py
import asyncio

async def handle_client(reader, writer):
    """Handle a single client connection"""
    # reader.read() doesn't block the thread!
    # It yields control back to the event loop
    data = await reader.read(4096)

    # Process request
    response = b"HTTP/1.1 200 OK\r\n\r\nHello World"

    # writer.write() is synchronous, but drain() waits for the write to complete
    writer.write(response)
    await writer.drain()

    writer.close()
    await writer.wait_closed()

async def main():
    # Start server
    server = await asyncio.start_server(
        handle_client,
        '0.0.0.0',
        8000
    )

    async with server:
        await server.serve_forever()

# Run the event loop
asyncio.run(main())
```
When await reader.read(4096) is called:

1. The asyncio event loop checks if data is available in the kernel socket buffer (epoll_ctl)
1. If not available, it registers interest in this socket with epoll (epoll_wait)
1. The coroutine is suspended, event loop continues with other tasks
1. When data arrives, kernel notifies epoll, event loop resumes the coroutine (performs recv())
1. Data is read from kernel buffer to user space (via recv()) and returned

When writer.write(response) is called:

1. The asyncio event loop checks if the socket is writable (if the kernel send buffer has space)
1. If the send buffer is full, the event loop registers interest in writable events using epoll_wait.
1. The coroutine is suspended, and the event loop continues running other tasks
1. When kernel buffer becomes available, kernel notifies epoll and event loop resumes the suspended coroutine (performs send())
1. Data is copied from user space into the kernel buffer (via send()) and returns once the write is accepted

## 4. ASGI Protocol
how data gets from the network card to the Python event loop. But there’s still a gap: how does the event loop pass HTTP requests to your web application? This is where ASGI comes in. ASGI is a specification, an agreed-upon interface between web servers (like Uvicorn) and web applications (like FastAPI)

Before ASGI, we had WSGI (Web Server Gateway Interface), which worked perfectly for synchronous Python. But WSGI has a fundamental limitation: it’s synchronous and blocking. Every request blocks a worker thread. ASGI solves this by defining an async interface that allows servers and applications to communicate using coroutines.


### The ASGI Interface
At its core, ASGI defines two things:
- Application: A coroutine that receives events and can send events back
- Message format: Standardized dictionaries for communication

Here’s the signature of an ASGI application:

```py
async def application(scope, receive, send):
    """
    scope: dict - Information about the connection (HTTP or WebSocket)
    receive: coroutine - Receive messages from the server
    send: coroutine - Send messages to the server
    """
    pass
```
Let’s build a simple ASGI application to see how this works:
```py
async def hello_world_app(scope, receive, send):
    """Simplest possible ASGI application"""

    # scope contains connection metadata
    if scope['type'] == 'http':
        # Wait for the HTTP request body (even if empty)
        await receive()

        # Send response start (status and headers)
        await send({
            'type': 'http.response.start',
            'status': 200,
            'headers': [
                [b'content-type', b'text/plain'],
            ],
        })

        # Send response body
        await send({
            'type': 'http.response.body',
            'body': b'Hello, World!',
        })
```

This looks simple, but notice what’s happening:

- The application is completely async
- It communicates with the server through the receive and send coroutines
- Messages are just dictionaries with standardized keys

### ASGI Server: Bridging Sockets and Applications
An ASGI server like Uvicorn sits between the socket layer and your application. Its job is to:

1. Accept connections from clients
1. Parse HTTP requests from raw bytes
1. Convert them to ASGI messages
1. Call your application
1. Convert ASGI response messages back to HTTP bytes
1. Send them back through the socket

Here’s a simplified view of what Uvicorn does (this is a fully working code, you may run and test it yourself):
```py
import asyncio
import httptools


class ASGIServer:
    def __init__(self, app):
        self.app = app

    async def handle_connection(self, reader, writer):
        parser = httptools.HttpRequestParser(self)
        self.parser = parser  # attached for callbacks
        self.writer = writer
        self.reader = reader
        self.headers = []
        self.body = b""
        self.url = None
        self.method = None
        self.complete = False
        self.upgrade = False

        try:
            while not self.complete:
                data = await reader.read(65536)
                if not data:
                    return  # client disconnected
                parser.feed_data(data)  # may raise HttpParserError → caught below

            # After on_message_complete(), we have a full request → run ASGI app
            await self._run_app()

        except httptools.HttpParserError:
            self._write_response(b"HTTP/1.1 400 Bad Request\r\n\r\n")
        except Exception as e:
            print("Error:", e)
            self._write_response(b"HTTP/1.1 500 Internal Error\r\n\r\n")
        finally:
            writer.close()
            await writer.wait_closed()

    # ─────── httptools callbacks ───────
    def on_url(self, url: bytes):
        self.url = url
        parsed = httptools.parse_url(url)
        self.path = parsed.path.decode() if parsed.path else "/"
        self.query_string = parsed.query or b""

    def on_header(self, name: bytes, value: bytes):
        self.headers.append((name.lower(), value))

    def on_headers_complete(self):
        self.method = self.parser.get_method().decode()

    def on_body(self, body: bytes):
        self.body += body

    def on_message_complete(self):
        self.complete = True

    # ─────── Helper to send raw HTTP response (used only on errors) ───────
    def _write_response(self, data: bytes):
        try:
            self.writer.write(data)
            asyncio.create_task(self.writer.drain())
        except:
            pass

    # ─────── Run the actual ASGI application ───────
    async def _run_app(self):
        scope = {
            "type": "http",
            "asgi": {"version": "3.0", "spec_version": "2.3"},
            "http_version": "1.1",
            "method": self.method,
            "scheme": "http",
            "path": self.path,
            "raw_path": self.url,
            "query_string": self.query_string,
            "headers": self.headers,
            "server": ("127.0.0.1", 8000),
            "client": self.writer.get_extra_info("peername"),
        }

        # receive() – streams body if app asks for it
        async def receive():
            if self.body:
                body, self.body = self.body, b""
                return {"type": "http.request", "body": body, "more_body": False}
            return {"type": "http.request", "body": b"", "more_body": False}

        # send() – converts ASGI messages → raw HTTP via httptools
        async def send(message):
            if message["type"] == "http.response.start":
                status = message["status"]
                headers = message.get("headers", [])

                # Build response line + headers
                out = f"HTTP/1.1 {status} OK\r\n".encode()
                for name, value in headers:
                    out += name + b": " + value + b"\r\n"
                out += b"\r\n"

                self.writer.write(out)
                await self.writer.drain()

            elif message["type"] == "http.response.body":
                body = message.get("body", b"")
                if body:
                    self.writer.write(body)
                    await self.writer.drain()

        # Run the ASGI app
        await self.app(scope, receive, send)

    async def serve(self, host="127.0.0.1", port=8000):
        server = await asyncio.start_server(self.handle_connection, host, port)

        print(f"ASGI server running on http://{host}:{port}")
        async with server:
            await server.serve_forever()


# —————————— Simple application ——————————
async def app(scope, receive, send):

    await send(
        {
            "type": "http.response.start",
            "status": 200,
            "headers": [(b"content-type", b"text/plain")],
        }
    )
    await send({"type": "http.response.body", "body": b"Hello from ASGI server!\n"})


# —————————— Run the server ——————————
if __name__ == "__main__":
    server = ASGIServer(app)
    try:
        asyncio.run(server.serve("127.0.0.1", 8000))
    except KeyboardInterrupt:
        print("\nServer stopped")
```

## The Complete Flow

Let’s trace a complete HTTP request through all layers:

![journey](./images/full-journey.png)


#### What about TCP handshake? Well, let’s take a look at that briefly.

##### Three-Way Handshake
When a client connects, the kernel automatically completes a three-step handshake:

Client → Server (SYN): “I want to connect, my sequence number is x”
Server → Client (SYN-ACK): “Acknowledged, my sequence number is y”
Client → Server (ACK): “Acknowledged, connection established”

Your application doesn’t see these packets—the kernel handles everything. When you call accept(), you get a fully-established connection:
```py
client, addr = server.accept()  # Returns after handshake completes
```

##### Data Transfer
Now HTTP data flows bidirectionally. Each send() and recv() moves data between your application and the kernel’s socket buffers:

```py
request = client.recv(4096)      # Read HTTP request
client.send(b"HTTP/1.1 200 OK")  # Send HTTP response
```
The kernel handles TCP’s reliability—retransmitting lost packets, reordering segments, and managing flow control.

##### Four-Way Teardown
Closing requires four steps because TCP is full-duplex (two independent pipes):

Client sends FIN: “I’m done sending”
Server sends ACK: “Got it”
Server sends FIN: “I’m done too”
Client sends ACK: “Got it, goodbye”

```py
client.close()  # Initiates graceful shutdown
```
This graceful close ensures no data is lost. After closing, the port enters TIME_WAIT state (60-120 seconds) to handle any delayed packets.

The complete picture reveals why ASGI-based applications scale:

Efficient delegation: The event loop delegates socket monitoring to the kernel’s epoll, avoiding expensive polling
Non-blocking operations: Coroutines yield control instead of blocking threads, enabling massive concurrency
Minimal overhead: ASGI adds almost no latency, the expensive parts remain network transmission and system calls
Clean abstractions: Despite the complexity underneath, you write simple async def handlers


![done](./images/done-journey.png)