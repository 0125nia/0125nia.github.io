---
date: 2025-05-31T20:28:40+08:00
showTableOfContents: true
tags: ["llm"]
title: "随记"
type: "post"
---

### MCP - Model Context Protocol

作用如同 USB-C 接口，标准化了应用程序应如何为大型语言模型提供上下文
MCP 为 AI 模型连接不同的数据源和工具提供了标准化方式

### RAG - Retrieval Augmented Generation

个人知识库架构

分块的方式压缩，取舍分类

RAG 是为了解决以下几个问题

- 准确性：当上下文太长的时候，大语言模型容易抓不住重点，开始胡说八道（ai 幻觉）
- 知识时效性：
- 领域适配性：包括各行业领域专业的知识，企业内部的数据

基本思路是先把文章拆成很多小段，然后对每一段做 embedding

embedding 的作用是把一整段话输出为固定的数组长度

然后再把所有的 embedding 存进一个向量数据库

在用户提问时，再从数据库中找出与问题语义接近的片段一起发送给大模型
