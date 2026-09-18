#!/usr/bin/env bash
# flygo 环境搭建：拉取围棋框架（web-katrain）；数据获取见 docs/resources.md
set -euo pipefail
cd "$(dirname "$0")/.."

echo "== flygo setup =="

if [ -d framework/web-katrain/.git ]; then
  echo "[web-katrain] 已存在，跳过克隆（如需更新：git -C framework/web-katrain pull）"
else
  echo "[web-katrain] 克隆到 framework/web-katrain ..."
  git clone https://github.com/Nihilism-tag/web-katrain.git framework/web-katrain
fi

cat <<'EOF'

下一步
  1) 运行框架（需要 Node.js 24+）：
       cd framework/web-katrain && npm install && npm run dev
  2) 数据获取（见 docs/resources.md）：
       - FlyWire: https://codex.flywire.ai （或 https://neuprint.janelia.org）
       - 注释表: Schlegel et al. 2024 补充材料（DOI 10.1038/s41586-024-07686-5）
EOF
