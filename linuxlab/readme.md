# 搭建Linux内核调试环境

你可以使用该脚本可以快速搭建一个linux内核的调试环境。
其中包含 linux、busybox的源码、编译脚本、rootfs打包脚本、qemu运行脚本等。

测试版本：
Ubuntu 24.04， linux master、busybox 1.36.0

## 环境搭建

执行 ./install.sh ，获得一个工作目录树和源码。
默认会在home目录下创建一个 Develop/LinuxLab 目录，后续所有的工作都在该目录下执行。

类似这样： 

```
zs@zs-Alpha-17 ~/D/LinuxLab> tree -L 1
.
├── buildroot
├── build_syzkaller.sh
├── busybox
├── linux
├── mkroot.sh
├── qemu.run
├── qemu_syzkaller.run
├── rootfs_ext4.img
├── syzkaller
└── syzkaller_workspace

```

## 编译

### Linux 编译

进入 linux 目录，进行linux的配置和编译。

首先，我们需要配置Linux的编译选项。
请执行 ./build.sh config，并配置下列选项。
我们也可以直接将下列config配置文件的内容复制到 build 目录下的 .config 文件中。

```
# 关闭 “地址随机化”：
CONFIG_RANDOMIZE_BASE=n
# 开启代码覆盖率
CONFIG_KCOV=y
# 开启KASAN
CONFIG_KASAN=y
CONFIG_DEBUG_INFO=y
CONFIG_CMDLINE="console=ttyAMA0"
CONFIG_KCOV_INSTRUMENT_ALL=y
CONFIG_DEBUG_FS=y
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
CONFIG_CROSS_COMPILE="aarch64-linux-gnu-"
```

配置完成后，执行 ./build.sh build 进行编译。
开始会有一些提示，一路默认回车即可。

### QEMU构建

为了使用最新的硬件特性，我们需要重新编译qemu。按照如下方式编译即可。

```shell
git clone https://github.com/qemu/qemu.git
cd qemu
mkdir build
cd build
../configure --prefix=$(pwd) --target-list=aarch64-softmmu --enable-slirp
ninja -j16
ninja install
```

### rootfs 构建

#### buildroot 构建rootfs（Fuzz Test）

使用buildroot构建的rootfs，可以打包各种配置文件、sshd等程序，方便进行syzkaller。
请参考的下面配置进行编译。

```
Target options
    Target Architecture - Aarch64 (little endian)
Toolchain type
    External toolchain - Linaro AArch64
System Configuration
[*] Enable root login with password
        ( ) Root password = set your password using this option
[*] Run a getty (login prompt) after boot  --->
    TTY port - ttyAMA0
Target packages
    [*]   Show packages that are also provided by busybox
    Networking applications
        [*] dhcpcd
        [*] iproute2
        [*] openssh
Filesystem images
    [*] ext2/3/4 root filesystem
        ext2/3/4 variant - ext3
        exact size in blocks - 6000000
    [*] tar the root filesystem
    Target packages
	    Miscellaneous
	        [*] haveged
```

注意，这里的busybox也要静态编译。所以我们需要修改 package/busybox/busybox.config 中的 CONFIG_STATIC=y 选项。

然后 build.sh build 进行编译。



#### busybox 和 mkroot 脚本（Simple Test）

首先，我们使用 "build.sh config" 时调整下配置：

```
# 开启静态编译
Settings ---> 
    [*] Build BusyBox as a static binary (no shared libs)

# 关闭 CONFIG_TC
# 规避 Busybox fails to build with linux kernels >= 6.8
```

接下来，我们使用 build.sh build 完成编译。 build.sh install 完成安装。

然后，使用 mkroot.sh 构建rootfs。

最后，我们可以直接使用 ./qemu.run 运行kernel即可。