A python docker image with yt-dlp, deno, custom ffmpeg installed along with hardware acceleration support.

Docker image: [nandyalu/python-ffmpeg](https://hub.docker.com/r/nandyalu/python-ffmpeg)

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
- [gosu](https://github.com/tianon/gosu)
- [FFmpeg-Builds](https://github.com/yt-dlp/FFmpeg-Builds)

Please refer to their respective repositories for more information and licensing details.

# How to use

To use this Docker image, you can pull it from Docker Hub and use it as a base image in your Dockerfile like this:

```Dockerfile
FROM nandyalu/python-ffmpeg:latest

# python3.13, uv, gosu, yt-dlp, deno (for yt-dlp-ejs), ffmpeg with hw acceleration drivers are pre-installed


# Rest of your Dockerfile instructions
# Below is an example, uncomment and adjust as needed

# Example of installing additional Python packages
# WORKDIR /app
# COPY pyproject.toml .
# RUN uv pip install --no-cache --native-tls --system -r pyproject.toml


# Create a non-root user/group and switch to it
# Below command will create a user 'appuser' and group 'appuser'
# RUN groupadd -r appuser && useradd -r -g appuser appuser


# Run your application
# CMD ["gosu", "appuser", "python", "your_script.py"]
```
