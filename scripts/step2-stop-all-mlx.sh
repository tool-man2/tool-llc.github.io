#!/bin/bash

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🛑 Step 2: 全MLXサーバー停止"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 現在のプロセス確認
if [ -z "$(ps aux | grep 'mlx_lm.server' | grep -v grep)" ]; then
    echo "✅ MLXサーバーは既に停止しています"
    exit 0
fi

echo "📋 停止対象のプロセス："
ps aux | grep 'mlx_lm.server' | grep -v grep | awk '{printf "  PID: %-6s CPU: %5s%% MEM: %5s%%\n", $2, $3, $4}'

echo ""
read -p "これらのプロセスを停止しますか？ (y/N): " confirm

if [[ ! $confirm =~ ^[Yy]$ ]]; then
    echo "❌ キャンセルしました"
    exit 0
fi

echo ""
echo "🧹 安全に停止中（SIGINT）..."
pkill -SIGINT -f "mlx_lm.server"

# 5秒待機
for i in {5..1}; do
    echo -ne "\r⏳ 待機中... $i秒 "
    sleep 1
done
echo ""

# 確認
if [ -z "$(ps aux | grep 'mlx_lm.server' | grep -v grep)" ]; then
    echo "✅ 全てのMLXサーバーが停止しました"
else
    echo "⚠️  一部プロセスが残っています。強制終了します..."
    pkill -9 -f "mlx_lm.server"
    sleep 2

    if [ -z "$(ps aux | grep 'mlx_lm.server' | grep -v grep)" ]; then
        echo "✅ 強制終了完了"
    else
        echo "❌ 停止に失敗しました。手動で確認してください："
        echo "   ps aux | grep mlx_lm.server"
        exit 1
    fi
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Step 2 完了"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
