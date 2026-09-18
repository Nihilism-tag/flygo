# flygo —— 果蝇大脑 × 围棋

用 **FlyWire 果蝇全脑连接组**训练围棋模型：资源汇总与分阶段计划。

*Training Go models with the Drosophila whole-brain connectome — resources and plan.*

状态：**P0（资源整合）** — 本仓库为初始版本。

**Abstract (EN).** FlyWire's adult fruit-fly whole-brain connectome is the most complete "minimal intelligence" instance we have (139,255 neurons, ~54.5M synapses). This project asks how far that scale goes on Go: a policy/value baseline trained at a "fly-brain budget" (9×9 first), a connectome-topology sparse network compared against equal-parameter dense baselines, and composition/lesion experiments sharing data and tooling with the Redundome project. The Go framework is **web-katrain**, a browser KataGo-style app whose engine loads KataGo `.bin.gz` models (versions 8–16, ≤128 MB) — that fixes the export format and size budget for anything we train. All links: [`docs/resources.md`](docs/resources.md).

---

## 1. 动机

- **果蝇全脑是目前最完整的"最小智能"实例**：FlyWire（2024）重建了成蝇全脑 —— 139,255 个神经元、约 5,450 万个化学突触，却支撑觅食、导航、学习记忆、求偶等完整行为谱。
- **围棋是少有的可量化认知标尺**：规则简洁、难度连续可调（9×9 → 19×19）、且有超人类参照系（KataGo 可作任意强度的对手与裁判）。
- 两者叠加给出一个可操作的问题：**果蝇规模（~10⁵ 神经元 / ~10⁷ 突触量级）的系统能承载多强的围棋智能？连接组结构本身值多少"参数效率"？**

## 2. 研究问题（工作假说，可证伪）

- **H1｜规模刻度**：在"果蝇预算"（与果蝇神经元/突触数同量级的参数量）下，标准架构（CNN/GNN）能把 9×9 围棋练到什么水平？—— 给出"飞脑刻度"基线。
- **H2｜结构 vs 训练**：等参数量下，以连接组子回路（如蘑菇体、中央复合体）为拓扑的稀疏网络，与常规稠密网络的可比棋力是否有显著差异？—— 检验结构先验的价值。
- **H3｜组合与鲁棒性**：把"最小核心"作为组件复用/组合，能否比等参数无结构版本获得更好的棋力或可迁移性？—— 与 Redundome 共享数据与工具。

> 声明边界：本项目做**受连接组启发的工程对照实验**；不做果蝇全脑仿真，也不从结果推断生物学结论。

## 3. 资源

完整链接与获取说明见 **[`docs/resources.md`](docs/resources.md)**。概要：

| 类别 | 资源 | 状态 |
|---|---|---|
| 数据 | FlyWire 全脑（v783 整理：139,255 神经元 / 15,091,983 连接 / 54,492,922 突触） | 已整理（本组工作区） |
| 数据 | 神经元注释（8,840 细胞类型；Schlegel et al. 2024） | 已获取（parquet + 原始 TSV） |
| 数据 | 合成测试床（DCN1 格式；20,831,149 边） | 上游数据仓库（私有，`nero111`）`main`（**合成数据**，仅测试用） |
| 框架 | **web-katrain**：浏览器内 KataGo 引擎（TensorFlow.js） | [fork](https://github.com/Nihilism-tag/web-katrain) ・[上游](https://github.com/Sir-Teo/web-katrain) ・[在线版](https://sir-teo.github.io/web-katrain/) |
| 工具 | KataGo 训练/自对弈、katagotraining、KaTrain、Sabaki、Go4Go | 按需获取 |

**关键接口（决定训练端约束）**：web-katrain 的引擎是自研 TypeScript 重实现，直接加载 **KataGo `.bin.gz` 模型（版本 8–16，≤ 128 MB）**。
→ 自训模型最终需要能导出为该格式、并在 web-katrain 中加载对局/分析。

## 4. 技术路线（候选，按阶段推进）

- **路线 A — 规模基线（"飞脑刻度"）**：在 ~10⁷ 参数预算内训练标准策略/价值网络（先 9×9），自对弈 + 棋谱监督混合；产出参数量–棋力曲线。
- **路线 B — 连接组骨架**：以 FlyWire 子回路（10³–10⁴ 神经元）为计算拓扑 —— 棋盘特征映射到输入神经元群、输出神经元群产生落子分布，边为可训练权重（可先用连接组掩码做稀疏训练）；与 A 的等参数稠密网络对照。
- **路线 C — 组合、损伤与去冗余**：把已训练核心搭成组件做复用/组合实验；按冗余度量做消融/损伤/恢复曲线，并与 Redundome 的指标对接（对照实验性质）。

## 5. 里程碑

| 阶段 | 内容 | 完成判据 |
|---|---|---|
| **P0 资源整合（当前）** | 本仓库；框架本地跑通；数据链路确认 | web-katrain 本地可加载小模型并完成一局 9×9 自对弈；FlyWire 图可加载 |
| **P1 基线** | 路线 A：9×9 策略/价值网络 + 自对弈循环 | 导出 KataGo v8 格式并在 web-katrain 成功加载；明显优于随机策略（阈值随基线校准） |
| **P2 连接组骨架** | 路线 B 原型 vs 等参数对照 | 对照实验报告（棋力 + 参数效率） |
| **P3 组合/损伤** | 路线 C；Redundome 指标对接 | 损伤–棋力曲线；可复现脚本 |
| **P4 规模上探** | 13×13 / 19×19；结论与论文 | 预印本 / 报告 |

## 6. 评估协议

- 棋盘：初期 9×9（便宜、可比），后期 13×13 / 19×19。
- 对手梯度：随机 → 内置小网（b6c96）→ b18 → KataGo 多档访问数；web-katrain 自带 rank 校准可给出人类可读刻度。
- 主指标：对固定对手的胜率 / Elo 估计；辅助：策略交叉熵、价值校准（对照 KataGo 评估）。
- 复现要求：固定种子、完整记录超参、保留 checkpoint 与对局记录（SGF）。

## 7. 风险与开放问题

- **导出端**：KataGo v8+ 模型文件的"写"需要自研导出器或复用 KataGo 训练工具链（"读"的参考实现：web-katrain `src/engine/katago/loadModelV8.ts`）。
- **规模**：全量连接组（10⁵ 级神经元）无法直接在浏览器/单卡上训练，需先做子回路与稀疏化；"结构 vs 参数预算"的公平对照设计是核心方法论难点。
- **数据条款**：FlyWire 数据与注释的使用需遵守来源条款与引用规范（见 resources）。
- **算力上限**：自对弈与评测在消费级硬件上有明确成本，随 P1 给出预算与排期。

## 8. 仓库结构

```
flygo/
├── README.md          # 本文件：背景、假说、路线、里程碑
├── docs/
│   └── resources.md   # 资源清单：数据 / 框架 / 工具 / 文献（链接与获取说明）
├── data/              # 数据工作区（内容不入库，见 data/README.md）
├── framework/         # 外部框架克隆位置（内容不入库，见 framework/README.md）
└── scripts/
    └── setup.sh       # 环境搭建脚本
```

### 快速开始

```bash
./scripts/setup.sh                    # 拉取 web-katrain 到 framework/
cd framework/web-katrain              # Node.js 24+：
npm install && npm run dev            # 本地跑起浏览器围棋应用
```

## 9. 相关链接

- web-katrain（fork）：https://github.com/Nihilism-tag/web-katrain ・上游：https://github.com/Sir-Teo/web-katrain
- Redundome（连接组冗余/去冗余研究，共享数据与工具）—— **私有仓库，暂未公开**
- FlyWire：https://flywire.ai ・Codex：https://codex.flywire.ai ・neuPrint：https://neuprint.janelia.org
- KataGo：https://github.com/lightvector/KataGo ・分布式训练：https://katagotraining.org
