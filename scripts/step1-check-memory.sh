#!/bin/bash

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔍 Step 1: メモリ使用量確認"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# システムメモリ情報
echo "【システムメモリ情報】"
vm_stat | perl -ne '/page size of (\d+)/ and $size=$1; /Pages\s+([^:]+)[^\d]+(\d+)/ and printf("%-30s % 16.2f MB\n", "$1:", $2 * $size / 1048576);'

echo ""
echo "【MLXプロセス確認】"
ps aux | grep -E 'mlx_lm.server|python' | grep -v grep | awk '{printf "%-15s %10s %10s %s\n", $1, $3"%", $4"%", $11}'

if [ -z "$(ps aux | grep 'mlx_lm.server' | grep -v grep)" ]; then
    echo "✅ MLXサーバーは起動していません"
else
    echo "⚠️  MLXサーバーが起動しています（次のステップで停止します）"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
read -p "Activity Monitorでメモリを確認しましたか？ (y/N): " confirm

if [[ ! $confirm =~ ^[Yy]$ ]]; then
    echo ""
    echo "📱 Activity Monitorを開いて確認してください："
    echo "   1. Spotlight（Cmd + Space）で「アクティビティモニター」"
    echo "   2. 「メモリ」タブを選択"
    echo "   3. 下部の「使用済みメモリ」と「GPU Memory」を確認"
    echo ""
    echo "確認したら、このスクリプトを再度実行してください"
    exit 0
fi
