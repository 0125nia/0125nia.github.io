---
date: 2025-06-07T16:56:15+08:00
# description: ""
# image: ""
# lastmod: 2024-07-03
showTableOfContents: true
tags: ["mac"]
title: "安卓平板作为Mac M4 mini 唯一显示屏"
type: "post"
---

在手头没有显示屏的情况下，需要如何使用手机或平板来当作 Mac M4 mini 的唯一显示屏？

在搜寻了各类资料后我总结出以下解决方法

所需设备如下：

Mac mini、安卓平板（三星）、hdmi 欺骗器（可用软件替代）、蓝牙键盘、蓝牙鼠标

首先新到的 Mac mini 是需要先激活的，不进行激活并进行相关配置是无法进行连接平板作为屏幕的，所以此时需要借用屏幕来进行一个激活的操作。

我是去了网吧和前台沟通，借用了显示屏。当时网吧的线都是使用的 dp 线，mini 上的接口是 hdmi 的，并且我没有转接头，故又去买了一条双头 hdmi 线来方便连接。

我在网吧连接上显示屏后立马进行键盘与鼠标的蓝牙连接，然后就开始激活操作，再之后就是进行相关的配置，在以下一并列出

整理一下前往网吧或短暂借用他人的显示屏来进行激活并配置的步骤清单：

1. 使用 hdmi 线连接显示屏
2. 连接显示屏后会提示连接键盘鼠标
3. 开始激活
4. 开启手机热点，电脑与平板都连接手机热点
5. 在 Mac mini 的 WiFi 界面，点击网络设置，查看并记下此时 Mac mini 的 ip（192.168.X.X）
6. 在平板安装 RVNC Viewer 软件或其他支持 VNC 连接的软件
7. 打开平板中的 RVNC Viewer，点击右下角 + 号，输入 Mac mini 的 ip 以及名称，点击连接，等待 Mac mini 响应
8. 此时在 Mac mini 上点击左上角控制中心的屏幕镜像或设置中搜索显示屏选择正在请求连接的显示屏
9. 发现平板已经通过 RVNC 连接上了 Mac mini
10. 开始编写自动化脚本，command+space 搜索 自动操作 - 创建文稿 - 选择应用程序 - 搜索 applescript - 粘贴以下代码 - 指定位置替换为平板作为显示屏时的名字 - 存储，起名 - 在设置中的辅助功能处开启此脚本及自动操作的权限 - 测试脚本
11. 为此脚本设置快捷键， 再次打开自动操作应用程序 - 选择快速操作 - 将“工作流程收到”设置为没有输入 - 找到左侧实用工具，选择“开启应用程序” - 选择其他，到自动操作中寻找刚刚创建的脚本 - 点击右上角执行按钮测试一下 - 左上角、文件、存储 - 到设置中搜索“键盘快捷键”，服务中通用 - 勾选脚本，设置快捷键，此时已完成所有步骤
12. 将 Mac mini 上连接显示屏的 hdmi 线拔掉，插入 hdmi 欺骗器，进行步骤 7，再点击刚刚设置的快捷键，验证是否成功连接
13. 此时多试验几次，重新开机后使用键盘盲输密码并回车，接着点击快捷键，可通过听提示音来辅助
14. 完成，离开网吧或归还显示屏

过程有些繁琐，或许还有其他更好的方式，等待探索

以下为 applescript 代码

```applescript
on findLastTargetIndex(targetItem, itemList)
	set lastIndex to 0
	repeat with i from (count of itemList) to 1 by -1
		if item i of itemList is targetItem then
			set lastIndex to i
			exit repeat
		end if
	end repeat
	return lastIndex
end findLastTargetIndex
beep 1
say "开始执行AirPlay连接"
beep 1

tell application "System Settings"
	activate
	delay 1
	tell application "System Events"
		tell process "System Settings"
			click menu item "显示器" of menu "显示" of menu bar item "显示" of menu bar 1
			delay 0.3
			tell group 1 of group 2 of splitter group 1 of group 1 of window "显示器"
				try
					-- 等待“添加”按钮出现
					set buttonFound to false
					set timeoutSeconds to 10 -- 设置超时时间（秒）
					set startTime to current date
					repeat
						try
							-- 尝试获取“添加”按钮
							set addButton to pop up button "添加"
							set buttonFound to true
							exit repeat
						on error
							-- 如果按钮未找到，检查是否超时
							if (current date) - startTime > timeoutSeconds then
								say "超时：未找到“添加”按钮"
								return
							end if
							delay 0.5 -- 等待 0.5 秒后重试
						end try
					end repeat

					-- 如果找到“添加”按钮，继续执行
					if buttonFound then
						click addButton
						-- 获取所有菜单项的名称
						set menuItems to name of menu items of menu "添加" of pop up button "添加"
						-- 通过名字查找要准确一些，这里去找最后一个名字的索引，因为如果符合通用控制的调节，就会出现两个名字，一个是通用控制，一个是随航
						set targetIndex to (my findLastTargetIndex("AS-SMX610[AirPlay]", menuItems))
						-- 点击目标菜单项
						delay 0.3
						click menu item targetIndex of menu "添加" of pop up button "添加"
						delay 2
						say "操作成功，AirPlay已连接或断开"
					end if
				on error
					delay 0.5
					say "未找到或发生错误: " & errorMessage
					exit repeat
				end try
			end tell
		end tell
	end tell
end tell
delay 1
beep 1
--完成后退出设置
tell application "System Settings" to quit
```
