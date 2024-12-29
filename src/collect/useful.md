# The Useful site

### Ai

- [chatgpt](https://chatgpt.com/)

- [kimi](https://kimi.moonshot.cn)

- [智谱清言](https://chatglm.cn)

- [讯飞星火](https://xinghuo.xfyun.cn)

- [通义千问](https://tongyi.aliyun.com/)

- [文心一言](https://yiyan.baidu.com/)

- [marscode](https://www.marscode.cn)

- [poe](https://poe.com/)

### Translate

- [deepl](https://www.deepl.com/zh/translator)

- [网易有道词典](https://fanyi.youdao.com/)

### efficiency

- [PowerToys](https://github.com/microsoft/PowerToys)

- [LocalSend](https://localsend.org/)

- [listary](https://www.listary.com/)

- [utools](https://www.u.tools/)

### pdf

- [pdfarranger](https://github.com/pdfarranger/pdfarranger)
  使用交互式直观的图形界面合并或拆分 PDF 文档并旋转、裁剪和重新排列页面

- [mdbook-pdf](https://github.com/HollowMan6/mdbook-pdf)
  将 mdbook 转为 pdf (我似乎没有找到添加封面的功能)
  需要 rust 环境以及安装 mdbook

  ```shell
    cargo install mdbook-pdf
  ```

  在`book.toml`中添加一下内容，运行`mdbook build`即可生成 pdf，详情查看官方文档

  ```toml
    [output.html]

    [output.pdf]
  ```

  添加目录的话可以通过`pip install mdbook-pdf-outline`安装并在`book.toml`中添加以下内容：

  ```toml
    [output.pdf-outline]
    like-wkhtmltopdf = true
  ```
