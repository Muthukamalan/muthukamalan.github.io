---
title: "Ascii Packages"
published: true
toc: true
toc_sticky: true
categories:  projects
author_profile: true
layout: single
classes:
- landing_page
categories:  projects
date: 2022-04-31
related: false
header:
    teaser: "/../assets/project-media-2-ascii/default-thumbnail.png"
excerpt: "Turning Images and Video into Terminal ASCII Art"
---

![Ascii image](/../assets/project-media-2-ascii/media2ascii.png)


<!-- *A look at [media2ascii](https://github.com/Muthukamalan/media2ascii) — a Python package (with a Rust core underneath) that converts images and video into ASCII art, right in your terminal.*

## What it does

`media2ascii` takes a photo, a GIF, or a video file and renders it as ASCII art — either streamed straight to your terminal or written out to a text file. The idea is simple: every pixel's brightness maps to a character of varying visual density, so darker regions get denser characters and brighter regions get simpler ones (or the reverse, if you flip it with `--invert`).

It ships as an installable CLI tool as well as a small Python API, so you can either run it directly from the shell or drop it into a script.

## Image conversion

The image side of things is built on Pillow for decoding (JPEG, PNG, BMP, GIF, WEBP, and friends) and gives you a few practical knobs:

- **Two palettes** — a 70-character grayscale ramp for fine detail, or a lighter 10-character palette for quick, punchy output
- **Configurable width** via `--size`, since terminal ASCII art lives and dies by how many columns you're working with
- **Brightness inversion** with `--invert`, useful depending on whether your terminal theme is light or dark
- **Save-to-file** support via `--output_path`, so the art doesn't just flash by in your terminal
- **Rich** for terminal rendering and **loguru** for structured logging when you need `-v` verbosity

CLI usage looks like this:

```bash
img2ascii --imagepath photo.jpg
img2ascii --imagepath photo.jpg --size 80
img2ascii --imagepath photo.jpg --size 60 --output_path output.txt
img2ascii --imagepath photo.jpg --palette 10 --invert
```

And the same thing works as a Python API:

```python
from img2ascii import ImageToAscii

converter = ImageToAscii(width=80, palette='10', invert=False)
ascii_art = converter.convert('photo.jpg')

print(ascii_art)
converter.save(ascii_art, 'output.txt')
```

## Video: where the Rust core comes in

Since the package is named `media2ascii` rather than just `img2ascii`, the more interesting half of the project is video. Decoding and re-rendering every frame of a video as ASCII in real time is a much heavier workload than a single image conversion, so the frame-processing path is implemented as a Rust library, exposed to Python through **PyO3** bindings and built with **maturin**.

The pipeline works roughly like this:

1. Video frames are streamed in via a subprocess call to **ffmpeg**, rather than loading the entire file into memory at once.
2. Each frame is handed off to the Rust core, which does the brightness-to-character mapping — the same core logic as the image converter, just running fast enough to keep up with frame rate.
3. Frames get rendered back to the terminal in sequence, giving a live ASCII "playback" of the video.

Pushing the per-pixel character-mapping loop into Rust is what makes this workable — a pure-Python implementation processing every pixel of every frame would fall behind quickly on anything longer than a few seconds of video.

## Packaging and tooling

The project uses `uv` for dependency management and has a `.devcontainer` set up for a consistent dev environment. A `.pre-commit-config.yaml` keeps formatting and linting in check, and there's a GitHub Actions workflow under `.github/workflows` for CI. Because of the Rust extension, packaging includes Alpine Linux compatibility work — musl-based builds need a bit more care than glibc-based ones when you're linking a compiled Rust extension into a Python wheel.

Installing it is the usual two paths:

```bash
# for development
git clone https://github.com/Muthukamalan/media2ascii
cd media2ascii
uv sync --all-groups

# as a user
pip install -e .
pip install img2ascii
```

## Why build this

There's something satisfying about a tool that takes something as "high-fidelity" as a video and forces it through the narrowest possible visual bottleneck — a handful of monospace characters — and still manages to look recognizable. It's also a good excuse to work across the Python/Rust boundary properly: FFI via PyO3, streaming data instead of buffering it all in memory, and packaging a compiled extension for a musl-based target like Alpine, which is its own small adventure.

---

*Repo: [github.com/Muthukamalan/media2ascii](https://github.com/Muthukamalan/media2ascii)* -->


Project Home: [Media2Ascii](https://github.com/Muthukamalan/media2ascii)


# img2ascii: Turning Pixels into Ascii 🖼 → 🔤
 
There's something satisfying about watching a photo dissolve into a wall of `@`, `#`, and `.` characters in your terminal. It's a small trick, but it sits at a fun intersection of image processing, character density mapping, and good old-fashioned CLI design. That's exactly the itch [`media2ascii`](https://github.com/Muthukamalan/media2ascii) scratches — a Python package (packaged and used as `img2ascii`) that converts images into ASCII art, right from the command line or as a library import.
 
## What it does
 
At its core, the idea is simple: every pixel has a brightness value, and every brightness value can be mapped to a character whose visual "density" approximates it. Bright pixels become sparse characters like spaces or dots; dark pixels become dense characters like `@` or `#`. Stack enough of these characters in a grid and you get a recognizable image made entirely of text.
 
The project builds on **Pillow** for image loading, so it handles the usual suspects — JPEG, PNG, BMP, GIF, WEBP — out of the box. From there it offers a few thoughtful knobs:
 
- **Two grayscale palettes** — a detailed 70-character set for high-fidelity output, or a simple 10-character set when you want something cleaner and faster to render
- **Configurable width** via `--size`, so the output fits whatever terminal (or file) you're targeting
- **Brightness inversion** (`-inv`) for images that read better with the mapping flipped — handy for dark-mode terminals or inverted source images
- **Save-to-file support** (`--save`) if you want to keep the ASCII art around instead of just printing it
- **Structured logging with loguru** and **rich terminal output**, which is a nice touch — a lot of CLI-art tools skip polish like this, but it makes debugging and everyday use noticeably more pleasant
## Using it
 
The CLI is where most people will start:
 
```bash
img2ascii --imagepath photo.jpg
img2ascii --imagepath photo.jpg --size 80
img2ascii --imagepath photo.jpg --size 60 --output_path output.txt
img2ascii --imagepath photo.jpg --invert
img2ascii --imagepath photo.jpg --palette 10
```
 
But it's just as usable as a library, which is arguably the more interesting design choice — it means the conversion logic isn't locked behind a CLI wrapper:
 
```python
from img2ascii import ImageToAscii
 
converter = ImageToAscii(width=80, palette='10', invert=False)
ascii_art = converter.convert('photo.jpg')
print(ascii_art)
converter.save(ascii_art, 'output.txt')
```
 
That `ImageToAscii` class is a clean seam — you could drop it into a larger pipeline, a Discord bot, a build step for READMEs, or a terminal-based image previewer without touching any argument-parsing code.
 
## The project setup
 
A few details in the repo are worth calling out for anyone browsing the source rather than just installing the package. It's structured as a proper installable package with a `pyproject.toml`, uses `uv` for dependency management (`uv sync --all-groups`), and ships a `Makefile` with development tasks — a good sign for anyone who wants to contribute or extend it. There's also a `.devcontainer` setup and GitHub Actions workflows, suggesting the project is set up for a reproducible dev environment and at least some CI automation, not just a one-off script someone uploaded.
 
## Why this kind of project is worth building
 
Image-to-ASCII converters are a classic "learn by building" project, but they're deceptively rich for their size. Getting good results forces you to think about:
 
- **Perceptual brightness** vs. raw RGB averages — naive luminance mapping can produce muddy results
- **Aspect ratio correction** — terminal characters are taller than they are wide, so a naive pixel-to-character mapping distorts the image unless you compensate
- **Palette design** — the order and density of characters in your ramp directly determines how much visual detail survives the conversion
Whether or not `media2ascii` tackles all of these under the hood, the fact that it exposes a `palette` option and a `width` option shows the author was thinking about the actual visual quality of the output, not just "does it run."
 
If you want to poke around the code, try it on your own images, or contribute, the repo. 