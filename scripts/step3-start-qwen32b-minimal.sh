#!/bin/bash

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔧 Step 3: Qwen 32B-8bit 最小起動"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# 既に起動している場合は警告
if [ -n "$(ps aux | grep 'mlx_lm.server' | grep -v grep)" ]; then
    echo "⚠️  MLXサーバーが既に起動しています"
    echo "   先にstep2-stop-all-mlx.shを実行してください"
    exit 1
fi

echo "🚀 Qwen 32B-8bitを起動します..."
echo "   ポート: 8080"
echo "   メモリ最適化: max-kv-size=8192"
echo ""

# バックグラウンドで起動
uvx --from mlx-lm mlx_lm.server \
  --model mlx-community/Qwen2.5-Coder-32B-Instruct-8bit \
  --port 8080 \
  --host 127.0.0.1 \
  --max-kv-size 8192 \
  > ~/mlx-qwen32b-minimal.log 2>&1 &

PID=$!
echo "📝 プロセスID: $PID"
echo "📝 ログファイル: ~/mlx-qwen32b-minimal.log"

echo ""
echo "⏳ モデル読み込み中（30秒待機）..."
for i in {30..1}; do
    echo -ne "\r   残り $i 秒... "
    sleep 1
done
echo ""

# 起動確認
echo ""
echo "🔍 起動確認中..."
if curl -s http://127.0.0.1:8080/v1/models > /dev/null 2>&1; then
    echo "✅ Qwen 32B-8bit起動成功！"
    echo ""
    echo "📊 モデル情報："
    curl -s http://127.0.0.1:8080/v1/models | python3 -m json.tool 2>/dev/null || echo "  (JSONパース失敗)"
else
    echo "⚠️  サーバーがまだ起動していません"
    echo "   ログを確認してください："
    echo "   tail -f ~/mlx-qwen32b-minimal.log"
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Step 3 完了"
echo ""
echo "🌐 エンドポイント: http://127.0.0.1:8080/v1"
echo "📝 ログ監視: tail -f ~/mlx-qwen32b-minimal.log"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
