#!/bin/bash

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎯 Step 5-6: 最終確認"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

echo "【Step 5: Antigravity軽量化チェック】"
echo ""
echo "📋 手動確認項目："
echo "   1. Agent Managerを開く"
echo "   2. Inboxの起動中エージェント数を確認"
echo "   3. 不要なエージェントを右クリック → Stop/Delete"
echo ""
read -p "Agent Managerでエージェントを整理しましたか？ (y/N): " agent_cleaned

echo ""
echo "【Step 6: メモリ使用量確認】"
echo ""

# システムメモリ情報
echo "📊 現在のメモリ使用量："
vm_stat | perl -ne '/page size of (\d+)/ and $size=$1; /Pages\s+([^:]+)[^\d]+(\d+)/ and printf("%-30s % 16.2f MB\n", "$1:", $2 * $size / 1048576);'

echo ""
echo "📊 MLXプロセス："
ps aux | grep 'mlx_lm.server' | grep -v grep | awk '{printf "  PID: %-6s CPU: %5s%% MEM: %5s%% CMD: %s\n", $2, $3, $4, $11}'

if [ -z "$(ps aux | grep 'mlx_lm.server' | grep -v grep)" ]; then
    echo "  ⚠️  MLXサーバーが起動していません"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📱 Activity Monitorで最終確認："
echo ""
echo "   目標値："
echo "   • Unified Memory: 40GB以下"
echo "   • GPU Memory: 35GB前後"
echo ""
echo "   現在の値を確認してください"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

read -p "メモリ使用量が目標範囲内ですか？ (y/N): " memory_ok

echo ""
if [[ $memory_ok =~ ^[Yy]$ ]]; then
    echo "✅ メモリ最適化成功！"
    echo ""
    echo "🎉 軽量化完了チェックリスト："
    echo "   ✅ MLXサーバー: Qwen 32B単独稼働"
    echo "   ✅ Continue.dev: 最小設定適用"
    if [[ $agent_cleaned =~ ^[Yy]$ ]]; then
        echo "   ✅ Agent Manager: エージェント整理完了"
    else
        echo "   ⚠️  Agent Manager: 未整理（必要に応じて実施）"
    fi
    echo "   ✅ メモリ使用量: 目標範囲内"
    echo ""
    echo "🚀 Talk Switch AIでテストしてみてください："
    echo "   「こんにちは、軽くなった？」"
else
    echo "⚠️  メモリ使用量が多い可能性があります"
    echo ""
    echo "📋 追加対策："
    echo "   1. 他のアプリケーションを終了"
    echo "   2. Agent Managerで全エージェント停止"
    echo "   3. Macを再起動"
    echo ""
    echo "   それでも改善しない場合："
    echo "   tail -f ~/mlx-qwen32b-minimal.log"
    echo "   でMLXサーバーのログを確認してください"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
