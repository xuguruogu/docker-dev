#!/bin/bash
set -ex

TZ=Asia/Shanghai
ln -sf /usr/share/zoneinfo/$TZ /etc/localtime
echo "$TZ" > /etc/timezone

debian_packages=(
    build-essential
    libgmp-dev libmpfr-dev libmpc-dev
    g++-multilib
    libc6-dev
    linux-libc-dev
    ninja-build
    vim
    lsof
    telnet
    sudo
    man
    iotop
    dstat
    cmake
    ascii
    git
    git-lfs
    subversion
    ccache
    make
    gdb
    openjdk-8-jdk
    xz-utils
    unzip
    zip
    autoconf
    automake
    python3
    python3-pip
    python3-lxml
    python3-requests
    python3-setuptools
    python3-wheel
    libtool
    diffutils
    libperl-dev
    openssl
    pkg-config
    wget
    curl
    net-tools
    iproute2
    doxygen
    openssh-server
    redis
)

redhat_packages=(
    gcc gcc-c++
    isl gmp-devel mpfr-devel libmpc-devel
    libstdc++-devel
    glibc-headers.i686
    glibc-headers.x86_64
    glibc-devel.x86_64
    glibc-devel.i686
    vim-enhanced
    ninja-build
    lsof
    telnet
    git
    git-lfs
    psmisc
    subversion
    man
    net-tools
    iotop
    dstat
    which
    ascii
    sudo
    zip
    unzip
    xz
    gettext
    redhat-lsb-core
    ccache
    tzdata
    autoconf
    automake
    gdb
    pkgconfig
    make
    python3
    python3-pip
    python3-lxml
    python3-requests
    python3-setuptools
    python3-wheel
    libtool
    diffutils
    perl-devel
    openssl
    iproute
    wget
    curl
    doxygen
    java-1.8.0-openjdk-devel
    openssh-server
    redis
)

fedora_packages=(
    "${redhat_packages[@]}"
    cmake
)

centos7_packages=(
    "${redhat_packages[@]}"
    cmake3
)

centos8_packages=(
    "${redhat_packages[@]}"
    cmake
)

# os-release may be missing in container environment by default.
if [ -f "/etc/os-release" ]; then
    . /etc/os-release
elif [ -f "/etc/arch-release" ]; then
    export ID=arch
else
    echo "/etc/os-release missing."
    exit 1
fi
case "$ID" in
    ubuntu|debian|pop)
        apt install -y "${debian_packages[@]}"
    ;;
    fedora)
        dnf install -y "${fedora_packages[@]}"
    ;;
    rhel|centos)
        if [ "$VERSION_ID" = "7" ]; then
            yum install -y epel-release centos-release-scl scl-utils
            yum install -y "${centos7_packages[@]}"
            ln -sf /usr/bin/cmake3 /usr/bin/cmake
            ln -sf /usr/bin/ctest3 /usr/bin/ctest
        elif [ "${VERSION_ID%%.*}" = "8" ]; then
            dnf install -y epel-release
            dnf install -y "${centos8_packages[@]}"
        fi
    ;;
    tlinux)
        if [ "${VERSION_ID%%.*}" = "2" ]; then
            yum install -y epel-release centos-release-scl scl-utils
            yum install -y "${centos7_packages[@]}"
            ln -sf /usr/bin/cmake3 /usr/bin/cmake
            ln -sf /usr/bin/ctest3 /usr/bin/ctest
        elif [ "${VERSION_ID%%.*}" = "3" ]; then
            dnf install -y epel-release
            dnf install -y "${centos8_packages[@]}"
        fi
    ;;
    *)
        echo "Your system ($ID) is not supported by this script. Please install dependencies manually."
        exit 1
    ;;
esac

# supervisor
pip3 install supervisor behave six
