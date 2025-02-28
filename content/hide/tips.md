---
date: 2025-02-28T22:23:15+08:00
lastmod: 2025-02-28
title: ""
showTableOfContents: true
type: "page"
---

# Tips

## 文件复制到U盘

文件复制到U盘显示`对于目标文件系统，文件XXX过大。`

这一般是因为U盘的文件系统不支持单个文件超过某个大小限制

如果U盘是 FAT32 文件系统，单个文件的最大大小限制是 **4GB**

通过**格式化**来修改U盘的文件系统为`exFAT`或`NTFS`即可解决