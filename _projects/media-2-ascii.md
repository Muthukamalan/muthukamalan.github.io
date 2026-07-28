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
---

# Turning Images and Video into Terminal ASCII Art


![Ascii image](/../assets/project-media-2-ascii/media2ascii.png)

*A look at [media2ascii](https://github.com/Muthukamalan/media2ascii) — a Python package (with a Rust core underneath) that converts images and video into ASCII art, right in your terminal.*

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

*Repo: [github.com/Muthukamalan/media2ascii](https://github.com/Muthukamalan/media2ascii)*