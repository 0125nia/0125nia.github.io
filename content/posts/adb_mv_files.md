---
date: 2025-08-08T23:13:12+08:00
showTableOfContents: true
tags: ["android", "adb", "file"]
title: "使用 adb 操作 Android 文件"
type: "post"
---

### 背景

我需要将一些大文件放到安卓手机中应用私有目录中，用于应用中的个性化操作

此前尝试以下方法，最后使用 `adb(Android-platform-tools)` 解决了问题

- 最开始是使用了`Android`默认的文件传输工具即`Android File Transfer`，只读，无法写入
- 之后又尝试了`OpenMTP`，也是同样无法写入的问题
- 此外还在安卓手机上安装 `X-plore` 也是同样
- 还有一个就是使用 MT 管理器，但需要 root，有点麻烦
- 最后返璞归真，使用 `adb` 解决

为何`adb`可以而`MTP`相关应用程序不行？
因为`adb`是`Android`的调试桥接工具，运行在`Android`的`system`用户上下文中，具有更高的系统访问权限，可以进入几乎所有的用户数据目录，App 沙箱也可操作
而`MTP`是一种通用媒体协议，只能访问标准的公开目录，即使`root`，使用第三方`MTP`工具也不行

**补充说明**：`Android 10`引入`Scoped Storage`沙箱机制，限制第三方或外部应用访问`/Android/data/`，仅该应用或具系统权限者（如 adb）可访问

```
/storage/emulated/0/Android/data/com.***/**
```

---

### adb 操作

1. 安装 ADB

```bash
brew install android-platform-tools
```

2. 开启 USB 调试（手机端）

路径如下：

```
设置 → 关于手机 → 连续点击“版本号”7次 → 返回设置 → 系统 → 开发者选项 → 开启“USB调试”
```

3. 手机和电脑设备连接 USB

在电脑终端输入以下命令检查是否连接成功

```bash
adb devices
```

---

完成以上操作后开始进行文件操作

进入 shell：

```bash
adb shell
```

此时是进入了 `Android` 的 shell 中，直接使用 linux 操作即可

执行移动命令（将路径替换为真实路径）：

```bash
mv /storage/emulated/0/*** /storage/emulated/0/Android/data/com.***.***/***
```

检查是否移动成功

```bash
ls -lh /storage/emulated/0/***
```

之后使用 `exit` 命令退出`Android`终端即可

---

由于我需要移动的文件大小比较大，如果使用以上方式其实并不会显示移动的进度，移动失败也难以发现

我需要移动的文件如下

```
-rw-rw---- 1 u0_a180 media_rw   72M a
-rw-rw---- 1 u0_a180 media_rw   11G b
-rw-rw---- 1 u0_a180 media_rw  3.5G c
```

- 本地路径：`~/Desktop/`
- 目标路径：`/storage/emulated/0/Android/data/com.aaa.bbb/files/`

故而我需要使用更加直观的方式来查看是否移动成功

这里演示显示移动进度的方式且此时是将电脑端的文件移动文件到手机上

在终端中使用以下命令

```bash
adb push ~/Desktop/a  /storage/emulated/0/Android/data/com.aaa.bbb/files/
```

用此方式可以显示移动的进度，更为直观

![adb push](/img/post/adb_loading.png)

同样的，使用以下命令检查是否移动成功

```bash
adb shell ls -lh /storage/emulated/0/Android/data/data/com.aaa.bbb/files/
```
