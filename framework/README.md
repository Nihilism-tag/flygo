# framework/ —— 外部框架工作区

外部框架以**独立克隆**放在本目录，保留各自的 git 历史、与上游保持同步；**内容不入本仓库**（见 `../.gitignore`）。

```bash
git clone https://github.com/Nihilism-tag/web-katrain.git framework/web-katrain
cd framework/web-katrain
npm install && npm run dev     # 需要 Node.js 24+
```

- 主框架：**web-katrain**（浏览器内 KataGo 引擎）。模型格式约束与详细说明见 [`../docs/resources.md`](../docs/resources.md) §2。
- 复现实验时，请记录所用框架的 commit 哈希。
