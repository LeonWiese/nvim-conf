FROM alpine:latest

# Install system dependencies
RUN apk update && apk add --no-cache \
    neovim \
    git \
    curl \
    wget \
    unzip \
    cmake \
    gcompat \
    build-base \
    libstdc++ \
    nodejs \
    npm \
    python3 \
    py3-pip \
    ripgrep \
    fzf \
    bash \
    openjdk11 \
    lua \
    luarocks

RUN curl https://sh.rustup.rs -sSf | bash -s -- -y

# Add a non-root user for safety
RUN adduser -D dev
USER dev
WORKDIR /home/dev

RUN echo 'source $HOME/.cargo/env' >> $HOME/.bashrc

# Create nvim config dir
RUN mkdir -p ~/work
RUN mkdir -p ~/.config
ENV XDG_CONFIG_HOME=/home/dev/.config

RUN git config --global --add safe.directory '*'

# Copy your Neovim config into the container
COPY --chown=dev:dev . /home/dev/.config/nvim

# Install plugins
RUN nvim --headless "+Lazy! sync" +qa

# Run Mason's auto-installer (assuming you use mason-tool-installer or similar)
#RUN nvim --headless \
#  "+MasonInstall csharpier netcoredbg rust-analyzer html cssls ts_ls angularls eslint lua_ls omnisharp" \
#  +qa

WORKDIR /home/dev/work
# Default to nvim
CMD ["nvim"]
