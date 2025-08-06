---
date: 2025-07-28T20:34:01+08:00
# description: ""
# image: ""
# lastmod: 2024-07-03
showTableOfContents: true
tags: ["mac"]
title: "微信 Mac 版数据迁移到移动硬盘中"
type: "post"
---

登录微信，右键点击任意聊天记录中的文件，在访达中打开

访达中点击该文件夹的目录结构，找到 `2.0b4.0.9` 这个文件夹

点击进入后，先退出微信，把原本的 `2.0b4.0.9` 文件夹移动到别的地方

在移动硬盘中选择存放微信聊天记录的文件夹位置，新建文件夹名为 `2.0b4.0.9`

使用软链接，打开终端执行以下命令

`ln -s [移动硬盘位置] [原文件位置]`
示例：`ln -s /Volumes/xxx/2.0b4.0.9 /Users/xxx/com.tencent.xinWeChat`

接着执行
`sudo codesign --sign - --force --deep /Applications/WeChat.app`

输入密码后

显示以下提示后打开微信
`/Applications/WeChat.app: replacing existing signature`

一路允许/修复数据库即可

再次进入后微信聊天记录即被迁移到移动硬盘中以上是支持 3.x.x 版本的，4.x.x 版本后 mac 版微信目录更改了

新版微信的步骤与上述方法差不多，只要注意目录不同即可同样利用文件找到微信存储的位置，往上找到微信图标文件夹的字文件夹，此处只有一个`Data`文件夹

`Data`文件夹等价于上面的 `2.0b4.0.9` 文件夹

再执行一样的操作即可
