# data/ —— 数据工作区

原始与中间数据体积大、来源多，**内容不入 git**（本目录仅保留本说明）。建议布局：

```
data/
├── raw/        # 原始下载（FlyWire 导出、论文补充材料、SGF 等）
├── interim/    # 中间产物（图结构、张量、划分）
└── processed/  # 训练可直接消费的数据
```

获取入口与引用要求见 [`../docs/resources.md`](../docs/resources.md)。

本组已有整理版本：FlyWire v783 有向图与神经元注释表（来源与校验记录见本组 Redundome 工作区，当前为私有）。
