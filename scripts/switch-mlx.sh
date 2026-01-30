#!/bin/bash

MODEL=$1

if [ -z "$MODEL" ]; then
  clear
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "🚀 MLXモデル切り替えツール"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
  echo "使用法:"
  echo "  ~/switch-mlx.sh qwen32b   # Qwen 32B起動"
  echo "  ~/switch-mlx.sh vision    # Llama Vision起動"
  echo "  ~/switch-mlx.sh stop      # 全て停止"
  echo ""
  exit 1
fi

echo "🧹 既存サーバーを停止中..."
pkill -f mlx_lm.server
sleep 3

case $MODEL in
  qwen32b)
    echo ""
    echo "🔧 Qwen 32B-8bit 起動中..."
    echo "   ポート: 8080"
    echo "   用途: コード生成・開発・テキスト処理"
    echo ""

    uvx --from mlx-lm mlx_lm.server \
      --model mlx-community/Qwen2.5-Coder-32B-Instruct-8bit \
      --port 8080 --host 127.0.0.1 \
      > ~/mlx-current.log 2>&1 &

    sleep 3
    echo "✅ Qwen 32B起動完了！"
    echo "📝 ログ: tail -f ~/mlx-current.log"
    echo "🌐 エンドポイント: http://127.0.0.1:8080/v1"
    ;;

  vision)
    echo ""
    echo "📸 Llama Vision 11B-8bit 起動中..."
    echo "   ポート: 8080"
    echo "   用途: 画像解析・スクリーンショット・UI解析"
    echo ""

    uvx --from mlx-lm mlx_lm.server \
      --model mlx-community/Llama-3.2-11B-Vision-Instruct-8bit \
      --port 8080 --host 127.0.0.1 \
      > ~/mlx-current.log 2>&1 &

    sleep 3
    echo "✅ Llama Vision起動完了！"
    echo "📝 ログ: tail -f ~/mlx-current.log"
    echo "🌐 エンドポイント: http://127.0.0.1:8080/v1"
    ;;

  stop)
    echo "🛑 全てのMLXサーバーを停止しました"
    exit 0
    ;;

  *)
    echo "❌ 無効なモデル: $MODEL"
    echo ""
    echo "使用可能なモデル:"
    echo "  qwen32b, vision, stop"
    exit 1
    ;;
esac

echo ""
