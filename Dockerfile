# the docker image with Emacs 27 installed on Ubuntu 18.04
FROM silex/emacs:27.0

# install build tools and so on
RUN apt update && apt install -y \
    build-essential \
    git \
    gdb \
    curl \
    wget \
    gnupg \
    libtool-bin \
    libtinfo-dev \
    python3 \
    python3-pip \
    npm \
    tmux \
    xclip && \
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb && \
    dpkg -i ripgrep_12.1.1_amd64.deb && rm ripgrep_12.1.1_amd64.deb && \
    curl https://bazel.build/bazel-release.pub.gpg | apt-key add - && \
    echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list && \
    apt update && apt install -y \
    bazel && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN cd /tmp && \
    git clone -b release --depth=1 https://github.com/Kitware/CMake.git && \
    cd CMake && ./bootstrap && make -j4 && make install && \
    cd /tmp && rm -rf CMake

# LSP server for C/C++/Object-C (ccls)
RUN cd /usr/src && \
    git clone --depth=1 --recursive https://github.com/MaskRay/ccls && \
    cd ccls && \
    wget -c http://releases.llvm.org/8.0.0/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz && \
    tar xf clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz && \
    rm clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz && \
    cmake -H. \
    -BRelease \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_PREFIX_PATH=$PWD/clang+llvm-8.0.0-x86_64-linux-gnu-ubuntu-18.04 && \
    cmake --build Release --target install

# LSP server for Python (pyls)
RUN python3 -m pip install 'python-language-server[all]'

# LSP server for Bash/Dockerfile/HTML/CSS/JavaScript/TypeScript
RUN npm i -g \
    bash-language-server \
    dockerfile-language-server-nodejs \
    vscode-html-languageserver-bin \
    vscode-css-languageserver-bin \
    typescript-language-server \
    typescript

# install Starship
RUN cd /tmp && \
    wget https://starship.rs/install.sh && \
    bash install.sh --yes && \
    rm install.sh
