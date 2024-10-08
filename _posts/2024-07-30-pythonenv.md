---
title: "Getting Started Py3 💻"
author: Muthu kamalan
date: 2023-07-30 00:00:00
categories: [python3,setup-blog]
tags: [python3,poetry,pyenv]
pin: false
---

As Python3 continues to gain popularity, we are witnessing an exponential increase in the number of available packages. Managing these packages can become increasingly complex and cumbersome over time

![spiderman-handling](assets/img/python3env/meme-spiderman.png)
Having an efficient setup to handle the fast-paced ML Space and a reliable crawlers is crucial for smooth operations and productivity.

**Package Management Tools**

At point of time GitHub stars are,

- [pip](https://en.wikipedia.org/wiki/Pip_(package_manager)) - 9.4k ⭐ <!--2008 -->
- [conda](https://en.wikipedia.org/wiki/Conda_(package_manager)) - 6.3k ⭐ <!--2012-->
- [pipenv](https://pipenv.pypa.io/en/latest/) - 24.7k ⭐ <!--2018-->
- [pyenv](https://github.com/pyenv/pyenv) - 38.1k ⭐ <!--2017-->
- [poetry](https://python-poetry.org/) - 30.6k ⭐ <!--2018 -->

Googling led me to [PEP 518](https://peps.python.org/pep-0518/), which I found somewhat challenging. Fortunately, I came across a thread in Stack Overflow [🧵](https://stackoverflow.com/questions/62983756/what-is-pyproject-toml-file-for) that offered a more digestible explanation, making it easier to understand the purpose and usage of the pyproject.toml file


Before [PEP-621](https://peps.python.org/pep-0621/), there were a large number of config files that could wind up in a given Python project:
- requirements.txt
- setup.py and setup.cfg
- MANIFESTin
- tox.ini
- Pipfile and Pipfile.lock
- .pylintrc
- environment.yml
- .condarc


I'm exploring `pyproject.toml` as potential standard(Community) approach like in Rust🦀 uses `Cargo.toml` and JavaScript uses `package.json`

<h1 align='center'>Ubuntu Linux 🐧</h1>
<h2 align='center'>Local Env</h2>

## Setup python3 
```sh
# Install python3
sudo apt install python3

# Check the installed python version
python3 --version
```

## Setup pip3
```sh
# Install pip3, the python package manager
sudo apt install python3-pip

# Check the installed pip version
pip3 --version
pip3 install --upgrade pip #[optional]
```

## Setup pyenv (Python Management Tool)
pyenv lets you easily switch between multiple versions of Python by adjusting/shimming Python executables

`Note:` PATH is an environment variable that specifies an ordered list of folders where executables are saved.

It's handy while experimenting, not for production environment. Usally go with `Docker`+`requirements.txt`/`poetry.toml` to make Hassle-free

### Installation
```sh
# Install required Dependencies
sudo apt install -y git 
# [optional]
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev 

# Install pyenv
curl https://pyenv.run | bash
```
```bash 
$ nano ~/.bashrc

# Append at end PYENV Config
export PYENV_ROOT="$HOME/.pyenv"                                    # define PATH Variable
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"     # Test if dir present add PATH Variable
eval "$(pyenv init -)"

$ source ~/.bashrc
$ exec "$SHELL"    # Restart Shell
```

### Advantage
The greates advantage of pyenv as we can download 👇 python executables, either globally 🌍 or locally 🏡
```sh
pyenv --version
pyenv global

pyenv install --list | wc -l  # 825 🤯
```

pyenv doesn’t share library versions across different Python versions. 
<table>
  <tr>
    <th>Setup py-3.8.10</th>
    <th>Setup py-3.12.4</th>
  </tr>
  <tr>
    <td>
      <pre><code class="language-shell">
mkdir AZCrawl
cd AZCrawl
pyenv install 3.8.10
pyenv versions
pyenv local 3.8.10
python -V
      </code></pre>
    </td>
    <td>
      <pre><code class="language-shell">
mkdir ProductClassifier
cd ProductClassifier
pyenv install 3.12.4
pyenv local 3.12.4
python -V
      </code></pre>
    </td>
  </tr>
</table>


### More about:
- pyenv works by inserting a directory of shims at the front of your PATH [Understanding Shims](https://github.com/pyenv/pyenv#understanding-shims), the process is called **rehashing**
- By default, it comes with virtual environment compatabilty, Our Goal here is managing different python version 
- [how-pyenv-works-shims](https://mungingdata.com/python/how-pyenv-works-shims/)
- it comes with virtualenv but won't resolve dependency between package




## Setup poetry (Package Management Tool)
Poetry help you with managing and freezing the dependencies, installing the project, adding metadata and many more.
*mostly i leverage poetry to manage dependencies not for packaging and publish (not in near future)*


In PEP 621, consolidate everything into a `pyproject.toml` file. It can manage Virtual Env which can exists within or outside of your project. Generated `poetry.lock` are multi-platform lock files ( extremely large ).

The dependency resolver in `poetry` is actually still written in Python as a `depth-first search algorithm`

### Installation

```sh
curl -sSL https://install.python-poetry.org | python3 -
export PATH="/root/.local/bin:$PATH"
poetry --version
```

### Preferred Configuration 😉

```sh
# mentioning poetry to use preferable python as we modified using pyenv [🧵](https://github.com/python-poetry/poetry/issues/5252)
poetry config virtualenvs.prefer-active-python true

# create Virtual Environment Within Project DIR
poetry config virtualenvs.in-project true 

# configs
poetry config  --list
```


### Usage
- go to your working Dir and init poetry >> `pyproject.toml` File

```sh
poetry init  # pass `-qn` flag  --quit --non-interactive
```

- poetry comes with default packaging mode 

```sh
$ nano pyproject.toml 

[tool.poetry]
package-mode = false # Disable package mode
```

- installed python with virtual env 💥

```bash
poetry install  # pass --no-dev on production
poetry env info # info
```

<table>
    <tr>
        <th>AZCrawler/pyproject.toml</th>
        <th>ProductClassifier/pyproject.toml</th>
    </tr>
    <tr>
        <td>
            <pre><code class="language-toml">
[tool.poetry]
name = "name"
version = "0.1.0"
description = ""
authors = ["Your Name <you@example.com>"]
readme = "README.md"

[tool.poetry.dependencies]
python = <span style="color: red;"> <b>"^3.8"</b></span>

[build-system]
requires = ["poetry-core"]
build-backend = "poetry.core.masonry.api"
            </code></pre>
        </td>
        <td>
            <pre><code class="language-toml">
[tool.poetry]
name = "name"
version = "0.1.0"
description = ""
authors = ["Your Name <you@example.com>"]
readme = "README.md"

[tool.poetry.dependencies]
python = <span style="color: red;"> <b>"^3.12.4"</b></span>

[build-system]
requires = ["poetry-core"]
build-backend = "poetry.core.masonry.api"
            </code></pre>
        </td>
    </tr>
</table>



-- install dependencies
<table>
    <tr>
        <th>AZCrawler/</th>
        <th>ProductClassifier/</th>
    </tr>
    <tr>
        <td>
            <pre><code class="language-shell">
<span style="color: orange;">poetry</span> add selenium==4.23.1
<span style="color: orange;">poetry</span> add numpy==1.21.0
<span style="color: orange;">poetry</span> add pandas==1.3.0
<span style="color: orange;">poetry</span> add scipy==1.50
<span style="color: orange;">poetry</span> add jupyter --group dev
<span style="color: orange;">poetry</span> add black --group dev
            </code></pre>
        </td>
        <td>
            <pre><code class="language-shell">
<span style="color: orange;">poetry</span> add xgboost
<span style="color: orange;">poetry</span> add numpy
<span style="color: orange;">poetry</span> add pandas
<span style="color: orange;">poetry</span> add scipy
<span style="color: orange;">poetry</span> add jupyter --group dev
<span style="color: orange;">poetry</span> add black --group dev
            </code></pre>
        </td>
    </tr>
</table>



- add package from requirement.txt [🧵](https://stackoverflow.com/questions/62764148/how-to-import-an-existing-requirements-txt-into-a-poetry-project)  and git

```bash
poetry add $(cat requirements.txt)
poetry add git+https://github.com/developer/project.git#branchname
```


- versioning

```sh
poetry show 
poetry export -f  requirements.txt -o requirements.txt
```

- peak into virtual env

```sh
source .venv/bin/activate
pip freeze
```

- remove env

```sh
poetry env remove --all
```

### Advantage
- It uses the now standardized pyproject.toml
- Poetry also helps you build your project and publish it on PyPI or a private repository.

### More about:
- [Version Constraints](https://iscinumpy.dev/post/bound-version-constraints/)
- There are Other tools yet to explore `hatch`, `pdm`
- [storing project metadata in pyproject.toml](https://peps.python.org/pep-0621/)


<h2 align='center'>on Docker 🐋</h2>

`Note`: It's playground image for pyenv+poetry preinstalled.

`Build Image:` 

```sh
docker build -t img .
```

`Run Image:`   

```sh
docker run -it img
```

```Dockerfile
# Base Image
FROM debian:buster-slim

# Necessary Packages
RUN apt-get update
RUN apt-get install -y --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

ENV HOME="/root"
WORKDIR ${HOME}


# pyenv Installation
RUN apt-get install -y git
RUN git clone --depth=1 https://github.com/pyenv/pyenv.git .pyenv
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc && \
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(pyenv init --path)"' >> ~/.bash_profile && \
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc
ENV PYENV_ROOT="${HOME}/.pyenv"
ENV PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"
ENV PYTHON_VERSION=3.8.6

RUN pyenv install ${PYTHON_VERSION}
RUN pyenv global ${PYTHON_VERSION}


# Poetry Installation
RUN curl -sSL https://install.python-poetry.org | python -
ENV PATH="$PATH:/root/.local/bin"

# # Configure Poetry to use the active Python interpreter
RUN /bin/bash -c "source ~/.bashrc && poetry config virtualenvs.prefer-active-python true"

# 
ENTRYPOINT [ "/bin/bash"]
```