#!/bin/bash

echo "🚀 MLXツールをインストール中..."
echo ""

# switch-mlx.shをホームディレクトリにコピー
echo "📦 [1/3] switch-mlx.shをコピー中..."
cp scripts/switch-mlx.sh ~/switch-mlx.sh
chmod +x ~/switch-mlx.sh
echo "✅ ~/switch-mlx.sh 作成完了"

# Continue.dev設定ディレクトリを作成
echo ""
echo "📦 [2/3] Continue.dev設定ディレクトリを作成中..."
mkdir -p ~/.continue

# config.jsonをコピー（既存のバックアップを作成）
echo ""
echo "📦 [3/3] Continue.dev config.jsonをコピー中..."
if [ -f ~/.continue/config.json ]; then
  echo "⚠️  既存のconfig.jsonをバックアップ中..."
  cp ~/.continue/config.json ~/.continue/config.json.backup.$(date +%Y%m%d_%H%M%S)
  echo "✅ バックアップ完了: ~/.continue/config.json.backup.*"
fi

cp config-samples/continue-config.json ~/.continue/config.json
echo "✅ ~/.continue/config.json 作成完了"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ インストール完了！"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📋 次のステップ:"
echo ""
echo "1. Cursor Proを完全再起動"
echo "   Cmd + Q → Cursor Proを再起動"
echo ""
echo "2. MLXモデルを起動"
echo "   ~/switch-mlx.sh qwen32b"
echo ""
echo "3. Continue.devで動作確認"
echo "   チャットでモデル選択 → 「🚀 MLX Current」を選択"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
