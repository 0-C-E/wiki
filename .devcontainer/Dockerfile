FROM debian:bookworm

ARG DEBIAN_FRONTEND=noninteractive
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000
ARG PANDOC_VERSION=3.6.1
ARG TYPST_VERSION=0.13.1
ARG RUSTUP_VERSION=1.27.1
ARG TYPSTYLE_VERSION=0.14.4

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Base utilities and build/runtime dependencies.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        wget \
        git \
        build-essential \
        bash-completion \
        less \
        sudo \
        unzip \
        xz-utils \
        tar \
        jq \
        openssh-client \
        fontconfig \
        python3 \
        python3-pip \
        python3-venv \
        locales \
    && rm -rf /var/lib/apt/lists/*

# Configure UTF-8 locale.
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
ENV RUSTUP_HOME=/usr/local/rustup
ENV CARGO_HOME=/usr/local/cargo
ENV PATH=/usr/local/cargo/bin:${PATH}

# Create non-root user.
RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} -s /bin/bash \
    && echo "${USERNAME} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}

# Install Pandoc from official release tarball (portable and up-to-date).
RUN ARCH="$(dpkg --print-architecture)" \
    && case "${ARCH}" in \
        amd64) PANDOC_ARCH="amd64" ;; \
        arm64) PANDOC_ARCH="arm64" ;; \
        *) echo "Unsupported architecture for Pandoc: ${ARCH}" && exit 1 ;; \
       esac \
    && curl -fsSL "https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-linux-${PANDOC_ARCH}.tar.gz" -o /tmp/pandoc.tar.gz \
    && tar -xzf /tmp/pandoc.tar.gz -C /tmp \
    && install -m 0755 /tmp/pandoc-${PANDOC_VERSION}/bin/pandoc /usr/local/bin/pandoc \
    && install -m 0755 /tmp/pandoc-${PANDOC_VERSION}/bin/pandoc-lua /usr/local/bin/pandoc-lua \
    && rm -rf /tmp/pandoc.tar.gz /tmp/pandoc-${PANDOC_VERSION}

# Install Typst from official release tarball.
RUN ARCH="$(dpkg --print-architecture)" \
    && case "${ARCH}" in \
        amd64) TYPST_TARGET="x86_64-unknown-linux-musl" ;; \
        arm64) TYPST_TARGET="aarch64-unknown-linux-musl" ;; \
        *) echo "Unsupported architecture for Typst: ${ARCH}" && exit 1 ;; \
       esac \
    && curl -fsSL "https://github.com/typst/typst/releases/download/v${TYPST_VERSION}/typst-${TYPST_TARGET}.tar.xz" -o /tmp/typst.tar.xz \
    && tar -xJf /tmp/typst.tar.xz -C /tmp \
    && install -m 0755 /tmp/typst-${TYPST_TARGET}/typst /usr/local/bin/typst \
    && rm -rf /tmp/typst.tar.xz /tmp/typst-${TYPST_TARGET}

# Install Rust toolchain and prettypst formatter.
RUN ARCH="$(dpkg --print-architecture)" \
    && case "${ARCH}" in \
    amd64) TYPSTYLE_TARGET="x86_64-unknown-linux-gnu" ;; \
    arm64) TYPSTYLE_TARGET="aarch64-unknown-linux-gnu" ;; \
    *) echo "Unsupported architecture for typstyle: ${ARCH}" && exit 1 ;; \
    esac \
    && curl -fsSL "https://github.com/typstyle-rs/typstyle/releases/download/v${TYPSTYLE_VERSION}/typstyle-${TYPSTYLE_TARGET}" -o /tmp/typstyle \
    && install -m 0755 /tmp/typstyle /usr/local/bin/typstyle \
    && rm -f /tmp/typstyle

# Use non-root user by default.
USER ${USERNAME}
WORKDIR /workspaces
