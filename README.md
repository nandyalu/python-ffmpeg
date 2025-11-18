A python docker image with yt-dlp, deno, custom ffmpeg installed along with hardware acceleration support.

# Features

- Python 3.13-slim base image
- yt-dlp for downloading videos from various platforms with curl-cffi and yt-dlp-ejs support
- deno runtime for executing JavaScript and TypeScript code, required for yt-dlp
- Custom ffmpeg build with hardware acceleration support for various architectures
- Uses uv for managing Python dependencies
- Also includes `gosu` for running processes as a non-root user

# Attribution

This project uses the following open-source projects:

- [yt-dlp](https://github.com/yt-dlp/yt-dlp)
- [deno](https://github.com/denoland/deno)
- [uv](https://github.com/astral-sh/uv)
- [FFmpeg-Builds](https://github.com/yt-dlp/FFmpeg-Builds)

Please refer to their respective repositories for more information and licensing details.