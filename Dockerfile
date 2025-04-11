FROM alpine:latest

# Install system dependencies
RUN apk update && apk add --no-cache \
    neovim \
    git \
    curl \
    wget \
    unzip \
    cmake \
    build-base \
    libstdc++ \
    nodejs \
    npm \
    python3 \
    py3-pip \
    ripgrep \
    fzf \
    bash \
    lua \
    luarocks

# Add a non-root user for safety
RUN adduser -D dev
USER dev
WORKDIR /home/dev

# Create nvim config dir
RUN mkdir -p ~/.config/nvim

# Copy your Neovim config into the container
COPY --chown=dev:dev ./nvim ~/.config/nvim

# Install plugins
RUN nvim --headless "+Lazy! sync" +qa

# Run Mason''s auto-installer (assuming you use mason-tool-installer or similar)
RUN nvim --headless "+lua require('mason-tool-installer').run_on_start()" +qa

# Default to nvim
CMD ["nvim"]
