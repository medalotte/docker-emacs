# the docker image with Emacs 27 installed on Ubuntu 18.04
FROM silex/emacs:27.0

# install build tools and so on
RUN apt update && apt install -y \
    build-essential \
    cmake \
    git \
    gdb \
    curl \
    wget \
    gnupg \
    libtinfo-dev \
    xclip && \
    curl https://bazel.build/bazel-release.pub.gpg | apt-key add - && \
    echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list && \
    apt update && apt install -y \
    bazel && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# LSP server for C/C++/Object-C (ccls)
RUN cd /root && \
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
