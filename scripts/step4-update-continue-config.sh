#!/bin/bash

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⚙️  Step 4: Continue.dev設定を最小化"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

CONFIG_PATH="$HOME/.continue/config.json"
BACKUP_PATH="$HOME/.continue/config.json.backup.$(date +%Y%m%d_%H%M%S)"

# 既存設定のバックアップ
if [ -f "$CONFIG_PATH" ]; then
    echo "💾 既存設定をバックアップ中..."
    cp "$CONFIG_PATH" "$BACKUP_PATH"
    echo "✅ バックアップ完了: $BACKUP_PATH"
else
    echo "ℹ️  既存の設定ファイルが見つかりません（新規作成します）"
    mkdir -p "$HOME/.continue"
fi

echo ""
echo "📝 最小化設定を適用中..."

# スクリプトのディレクトリを取得
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_SOURCE="$SCRIPT_DIR/../config-samples/continue-config-minimal.json"

if [ ! -f "$CONFIG_SOURCE" ]; then
    echo "❌ 設定ファイルが見つかりません: $CONFIG_SOURCE"
    echo "   リポジトリを正しくクローンしているか確認してください"
    exit 1
fi

cp "$CONFIG_SOURCE" "$CONFIG_PATH"
echo "✅ 設定ファイルを更新しました"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Step 4 完了"
echo ""
echo "📌 次のステップ："
echo "   1. Cursor Proを完全再起動"
echo "      Cmd + Q → Cursor Proを再起動"
echo ""
echo "   2. Continueチャットでモデル選択"
echo "      「Qwen2.5-Coder-32B-8bit (メイン)」を選択"
echo ""
echo "⚠️  元に戻したい場合："
echo "   cp $BACKUP_PATH $CONFIG_PATH"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
