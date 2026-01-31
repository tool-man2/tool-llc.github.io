#!/bin/bash

clear
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🚀 Antigravity軽量化 - 完全自動実行"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "このスクリプトは以下を自動実行します："
echo "  Step 1: メモリ使用量確認"
echo "  Step 2: 全MLXサーバー停止"
echo "  Step 3: Qwen 32B-8bit 最小起動"
echo "  Step 4: Continue.dev設定最小化"
echo "  Step 5-6: 最終確認"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

read -p "実行しますか？ (y/N): " confirm
if [[ ! $confirm =~ ^[Yy]$ ]]; then
    echo "❌ キャンセルしました"
    exit 0
fi

# スクリプトのディレクトリを取得
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Step 1
bash "$SCRIPT_DIR/step1-check-memory.sh"
if [ $? -ne 0 ]; then
    echo "❌ Step 1 でエラーが発生しました"
    exit 1
fi

echo ""
read -p "続行しますか？ (y/N): " continue1
if [[ ! $continue1 =~ ^[Yy]$ ]]; then
    echo "❌ 中断しました"
    exit 0
fi

# Step 2
echo ""
bash "$SCRIPT_DIR/step2-stop-all-mlx.sh"
if [ $? -ne 0 ]; then
    echo "❌ Step 2 でエラーが発生しました"
    exit 1
fi

# Step 3
echo ""
bash "$SCRIPT_DIR/step3-start-qwen32b-minimal.sh"
if [ $? -ne 0 ]; then
    echo "❌ Step 3 でエラーが発生しました"
    exit 1
fi

# Step 4
echo ""
bash "$SCRIPT_DIR/step4-update-continue-config.sh"
if [ $? -ne 0 ]; then
    echo "❌ Step 4 でエラーが発生しました"
    exit 1
fi

# Step 5-6
echo ""
bash "$SCRIPT_DIR/step5-6-final-check.sh"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 全ステップ完了！"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📌 最終ステップ（手動）："
echo "   1. Cursor Proを完全再起動（Cmd + Q）"
echo "   2. Talk Switch AIでテスト送信"
echo "   3. レスポンス速度を確認"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
