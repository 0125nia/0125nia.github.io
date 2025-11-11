---
date: 2025-07-16T01:36:51+08:00
showTableOfContents: true
tags: ["hotkey"]
title: "AutoHotkey绑定按键模拟键鼠操作"
type: "post"
---

工作中快速简易的鼠标点击脚本

下载 [autohotkey](www.autohotkey.com)
版本为 2.0.19

新建文件 `xxx.ahk`

{{< inline-images src="/img/post/autohotkey_site.png" href="https://wyagd001.github.io/v2/docs/Tutorial.htm" text="查看文档" >}}

简单语法

`! 对应 alt`

`^ 对应 ctrl`

`# 对应 win`

`+ 对应 shift`

```
{热键}::
{
    Click("Left",{x 参数},{y 参数},1) ; Left 即鼠标左键，最后的 1 代表点击次数
    return
}
```

坐标定位 spy

![spy](/img/post/autohotkey_spy.png)

![position](/img/post/autohotkey_client_position.png)

替换下方参数

```
^Enter::
{
    Click("Left",2320,1247,1)
    return
}

!q::
{
    Click("Left",1788,1242,1)
    return
}

!e::
{
    Click("Left",1285,1502,1)
    return
}

Space::
{
    Click("Left",1189,632,1)
    return
}
```

双击执行 ahk 脚本，右下角显示图标即可使用

在一个快捷键中定义多个操作，实现一键执行一系列键鼠操作
示例：

```
!7:: {
    Click("Left", 2167, 1237, 2)

    Sleep(100)

    Click("Left", 2215, 1488, 1)

    Send(7)

    Sleep(100)

    Click("Left", 2320, 1247, 1)

    return
}
```

每个操作之间可添加 Sleep 停顿一下

快捷键中执行快捷键操作未调试好，暂时用 click 代替，预期效果一致的

注意：

- 用 alt+其他键可一定程度上避免快捷键冲突
- 使用 window spy 时，注意要聚焦到对应的窗口后再记录坐标信息
- 由于采用的是绝对窗口定位，故需注意每次都应按照设置时的缩放大小及窗口位置，（正在探索更好的定位实现或其他方式
