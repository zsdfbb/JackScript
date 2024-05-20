# 搭建Linux内核调试环境

你可以使用该脚本可以快速搭建一个linux内核的调试环境。
其中包含 linux、busybox的源码、编译脚本、rootfs打包脚本、qemu运行脚本等。

测试版本：
Ubuntu 24.04， linux master、busybox 1.36.0

## 环境搭建

执行 ./install.sh ，获得一个工作目录树和源码。
默认会在home目录下创建一个 LinuxLab 目录，后续所有的工作都在该目录下执行。

类似这样： 

```
[~/Develop/LinuxLab]
-> % tree -L 2
.
├── busybox
│   ├── build
│   ├── build.sh
│   └── src
├── linux
│   ├── build
│   ├── build.sh
│   ├── install
│   └── src
├── mkrootfs.sh
├── qemu.run
```

## 编译

### Linux 编译

进入 linux 目录，进行linux的配置和编译。

首先，我们需要配置Linux的编译选项。
请执行 ./build.sh config，并配置下列选项。
如果中途需要调整，请进入 build目录执行 make menuconfig即可。

```
# 关闭 “地址随机化”：
CONFIG_RANDOMIZE_BASE

# 开启 “gdb 调试脚本”
CONFIG_GDB_SCRIPTS

# 开启KASAN
CONFIG_KASAN

# 开启代码覆盖率
CONFIG_KCOV


CONFIG_KCOV=y
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

### rootfs 构建

#### busybox 和 mkroot 脚本

首先，我们使用 "build.sh config" 时调整下配置：

```
# 开启静态编译
Settings ---> 
    [*] Build BusyBox as a static binary (no shared libs)

# 关闭 CONFIG_TC
# 规避 Busybox fails to build with linux kernels >= 6.8
```

接下来，我们使用 build.sh build 完成编译。

最后，使用 mkroot.sh 构建rootfs。

这种方式构建的镜像可以用来进行kernel的手动调试，方便我们分析代码。

#### buildroot 构建rootfs

使用buildroot构建的rootfs，可以打包各种配置文件、sshd等程序，方便进行syzkaller。
请参考 [1] 的内容进行编译。

## 参考

1. [Linux+arm64+qemu+syzkaller 部署](https://github.com/google/syzkaller/blob/master/docs/linux/setup_linux-host_qemu-vm_arm64-kernel.md)