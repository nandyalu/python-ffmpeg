# --------------------------------------------------------------------------- #
#                          Stage 1 - Dependencies                             #
# --------------------------------------------------------------------------- #
FROM python:3.13-slim

# Install ca-certificates for SSL
RUN apt-get update && apt-get install -y ca-certificates curl && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

# Copy uv related files for dependency installation
COPY ./.python-version /app/.python-version
COPY ./pyproject.toml /app/pyproject.toml
COPY ./uv.lock /app/uv.lock

# Install Python dependencies using uv pip install
RUN uv pip install --no-cache --native-tls --system -r pyproject.toml

# Install ffmpeg using install_ffmpeg.sh script
COPY ./scripts/install_ffmpeg.sh /tmp/install_ffmpeg.sh
RUN chmod +x /tmp/install_ffmpeg.sh && /tmp/install_ffmpeg.sh

# Copy gosu from gosu image to allow running as non-root user
COPY --from=tianon/gosu:trixie /usr/local/bin/gosu /usr/local/bin/gosu
RUN chmod +x /usr/local/bin/gosu

# # Copy uv, ffmpeg and Python dependencies from python-deps stage to make it available in final image
# COPY --from=python-deps /usr/local/bin/ /usr/local/bin/
# COPY --from=python-deps /usr/local/lib/python3.13/site-packages/ /usr/local/lib/python3.13/site-packages/

# Install HW Acceleration drivers and libraries
COPY ./scripts/install_drivers.sh /tmp/install_drivers.sh
RUN chmod +x /tmp/install_drivers.sh && \
    /tmp/install_drivers.sh

# ARG APP_VERSION, will be set during build by github actions
ARG IMAGE_VERSION=250101

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    TZ="America/New_York" \
    IMAGE_VERSION=${IMAGE_VERSION} \
    NVIDIA_VISIBLE_DEVICES="all" \
    NVIDIA_DRIVER_CAPABILITIES="all"

# Install tzdata and pciutils, set timezone
RUN apt-get update && apt-get install -y \
    curl p7zip-full \
    tzdata \
    pciutils \
    udev \
    && \
    ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    rm -rf /var/lib/apt/lists/*

# Install Deno for use with yt-dlp - install globally for all users
RUN curl -fsSL https://deno.land/install.sh | DENO_INSTALL=/usr/local sh && \
    chmod +x /usr/local/bin/deno && \
    /usr/local/bin/deno --version

# Set the working directory
WORKDIR /app

# Copy the project folders and files
COPY . /app

# Run a command to keep the container running for testing purposes
CMD ["sleep", "infinity"]
