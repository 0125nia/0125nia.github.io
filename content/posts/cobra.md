---
date: 2024-05-03T23:16:15+08:00
# description: ""
# image: ""
lastmod: 2024-05-03
showTableOfContents: true
tags: ["go","cmd"]
title: "快速入门Cobra - 强大的Go语言命令行构建框架"
type: "post"
---

### Cobra 介绍

Cobra 是一个 Go 语言开发的命令行（CLI）框架，提供了简单的接口来构建命令行界面，Cobra 允许轻松地定义命令和子命令结构。被用在很多 Go 语言的项目中，比如我们熟知的 K8s、Docker 等等

Cobra 在我的项目中作为命令行解析层，接触到这个命令行框架，了解到 Cobra 的强大功能，故在此进行记录

附上 Cobra 的[项目地址](https://github.com/spf13/cobra)以及[开发网站](https://cobra.dev)

### Cobra 概念

Cobra 是基于命令 `commands` 、参数 `arguments` 、选项 `flags` 三个部分构建的

要遵循的模式是 `APPNAME VERB NOUN --ADJECTIVE.` 或 `APPNAME COMMAND ARG --FLAG`

（_应用名称 动词 名词 --形容词_ 或 _应用名称 命令 参数 --标志_）

##### appname

应用程序的名称，标识要运行的程序或工具。例如，`git`、`curl`、`docker`等

##### commands

描述了要执行的操作类型。它通常代表了一个功能或者动作，在某些 CLI 设计中，这部分可能直接就是一个具体操作的名称，如`pull`、`push`。

##### arguments

名词或参数，提供了动词作用的对象或者是更具体的上下文信息。例如：`go build main.go`,
这个命令的`go`是应用程序名称（appname），`build`是操作类型（commands），而`main.go`就是`build`作用的对象

##### flags

命令行标志或选项，用来修改命令的行为或提供额外的配置信息。通常以两个连字符`--`开头，后面跟着标志名称。在某些情况下，如短选项，也可能只有一个连字符和一个字母

**示例：**

- `git commit -m "Initial commit"`：这里`git`是应用程序名称，`commit`是命令，`-m`是一个标志，后面跟着的 `"Initial commit"` 是该标志的值，作为提交信息。

- `hugo server --port=1313`：`hugo`为应用程序名称，`server`是命令，`port`是标志

### 入门

首先安装 Cobra

`go get -u github.com/spf13/cobra/cobra`

接着我们需要建立一个目录结构：

```
▾ app
    ▾ cmd
       root.go
       client.go
    main.go
```

Cobra 不需要任何特殊的构造函数。只需创建您的命令即可。

---

`root.go`文件

- 创建`rootCmd`结构体
- 编写`Execute`方法

![rootCmd](/img/post/cobra_rootCmd.png)


`main.go`文件非常裸露。它有一个目的：初始化眼镜蛇

![alt text](/img/post/cobra_main.png)

此时我们可以先运行一下查看效果

编译 `go build -o app`

执行命令 `./app`

此时我们发现，执行了 Run 函数中的`fmt.Println("app hugo...")`

除此之外我们并没有添加任何的命令，故接下来我们开始添加子命令

---

编写 `client.go` 注意这个文件也是在`cmd`文件夹下的

![clientCmd](/img/post/cobra_clientCmd.png)

编译 `go build -o app`

执行命令 `./app client`

执行了 Run 函数中的代码

---

另外，也可以在`root.go`文件中写入`init`函数


![init](/img/post/cobra_init.png)
`cobra.OnInitialize(initConfig)`：这是 Cobra 提供的一个功能，用于注册一个或多个函数，在 Cobra 初始化完成后（即解析完命令行参数之后）立即执行。initConfig 函数在这里被注册，意味着每次应用程序启动且 Cobra 初始化完毕后，都会调用 initConfig 函数执行配置初始化逻辑。

`initConfig()`：这可能包括从文件（如 YAML、JSON、环境变量或命令行标志）中读取配置信息，设置日志级别，初始化数据库连接或其他任何应用程序启动时需要准备的设置。
