# 资源清单

本文件汇总 flygo 依赖的全部公开资源：数据、框架、工具与文献。使用前请核对各来源的许可与引用要求。

## 1. 数据 —— 果蝇全脑连接组

### 1.1 FlyWire（主数据源）

| 入口 | 链接 |
|---|---|
| 门户 | https://flywire.ai |
| Codex（可视化/查询） | https://codex.flywire.ai |
| neuPrint（Janelia 查询/导出） | https://neuprint.janelia.org |
| CAVE Python 客户端 | https://github.com/CAVEconnectome/CAVEclient |

**必引文献**

1. Lin et al., *Network statistics of the whole-brain connectome of Drosophila*, Nature (2024-10-03). DOI: [10.1038/s41586-024-07968-y](https://doi.org/10.1038/s41586-024-07968-y) — 全脑网络统计（139,255 神经元；约 5,450 万突触）。
2. Schlegel et al., *Whole-brain annotation and multi-connectome cell typing of Drosophila*, Nature (2024-10-03). DOI: [10.1038/s41586-024-07686-5](https://doi.org/10.1038/s41586-024-07686-5) — 全脑注释与细胞分型；逐神经元注释表在其补充材料中。

**本组已整理（FlyWire 版本 v783）**

- 有向图：**139,255** 神经元 · **15,091,983** 条去重连接 · **54,492,922** 突触 · **8,840** 细胞类型
- 注释表：`annotations_783.parquet`（清洗自 Schlegel et al. 补充材料）
- 校验与处理脚本：见 [Redundome](https://github.com/Nihilism-tag/redundome) 的 `data-prep/`、`scripts/`（含打包格式读写与独立校验）
- **坐标注意事项**：体素各向异性（x/y 步长 4 nm，z 步长 40 nm）——先转 µm（×0.004 / ×0.004 / ×0.04）再使用；`pos_*` 是主干锚点而非胞体坐标（约 85% 神经元有胞体标注）。

### 1.2 测试用合成数据（可选）

- 上游 `tangchen341/nero111` 的 `main` 分支 Release `data-v1`（打包格式；20,831,149 边 / 78,500 神经元）。
- ⚠ 内容经核验为**生成的随机图**（区间密度恒定、权重近似 Exp(1)），**仅用于代码管线测试**，不得用于任何科学结论。

### 1.3 关联项目

- [Redundome](https://github.com/Nihilism-tag/redundome) —— 连接组冗余/去冗余与最简结构研究（与 flygo 共享数据与工具）。

## 2. 围棋框架 —— web-katrain

| 层级 | 链接 |
|---|---|
| 本项目主用（fork） | https://github.com/Nihilism-tag/web-katrain |
| 父级 fork | https://github.com/ykrsama/web-katrain |
| 原始上游 | https://github.com/Sir-Teo/web-katrain |
| 在线版 | https://sir-teo.github.io/web-katrain/ |

**要点**

- 浏览器内运行 KataGo 风格推理（TensorFlow.js；WebGPU → WASM → CPU 回退；Web Worker；可安装为离线 PWA），无需任何分析服务器。
- **模型加载 = 本项目最关键接口**：KataGo `.bin.gz`，版本 **8–16**，≤ **128 MB**。解析器参考实现 `src/engine/katago/loadModelV8.ts`，模型图构建 `modelV8.ts`（详见其仓库 `docs/engine.md`）。
- 内置小模型（约 3.6 MB 测试网络，冒烟用）＋可选 b18（约 96 MB，认真分析用）。
- 本地开发：**Node.js 24+**；`npm install && npm run dev`；`npm run verify` 为提交前全检。
- 姊妹应用（同构架构）：web-chess、web-xiangqi（Sir-Teo）。

## 3. 训练与评测工具

| 工具 | 用途 | 链接 |
|---|---|---|
| KataGo | 引擎；自对弈与训练代码 | https://github.com/lightvector/KataGo |
| KataGo 分布式训练 | 社区自对弈数据与网络权重 | https://katagotraining.org |
| KaTrain | 桌面分析 GUI（web-katrain 的行为参照） | https://github.com/sanderland/katrain |
| Sabaki | SGF 编辑器 + GTP 引擎挂载 | https://sabaki.yichuanshen.de |
| Go4Go | 职业棋谱库（SGF） | https://www.go4go.net |

棋谱与对局数据还可来自 OGS / KGS / Fox / Tygem 等公开档案；使用时遵守各自条款。

## 4. 网络与获取提示

- 部分站点（数据门户、模型下载）在特定网络环境下可能需要代理；本组在集群侧网络可达上述数据源。
- 原始数据体积大（十万级神经元、千万级连接），**不入 git**；放置约定见 [`../data/README.md`](../data/README.md)。
