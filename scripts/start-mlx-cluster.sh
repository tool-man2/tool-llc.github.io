#!/bin/bash

################################################################################
# MLX-LM Cluster Startup Script
#
# このスクリプトは3つのMLXモデルをローカルで起動します：
# - Qwen2.5-32B (Port 8080) - メインモデル
# - Codestral-22B (Port 8081) - コーディング特化
# - Qwen2.5-7B (Port 8082) - 軽量モデル
################################################################################

echo "=========================================="
echo "MLX-LM Cluster スタートアップ"
echo "=========================================="
echo ""

# Step 1: 既存のMLX-LMプロセスをクリーンアップ
echo "[1/5] 既存のmlx_lm.serverプロセスを停止中..."
pkill -f mlx_lm.server
sleep 2
echo "✓ クリーンアップ完了"
echo ""

# Step 2: Qwen2.5-32B (大規模モデル) を起動
echo "[2/5] Qwen2.5-32B-Instruct-4bit を起動中..."
echo "      ポート: 8080"
echo "      用途: メインの高性能モデル"
uvx --from mlx-lm mlx_lm.server \
  --model mlx-community/Qwen2.5-32B-Instruct-4bit \
  --port 8080 \
  > ~/mlx-qwen32b.log 2>&1 &
echo "✓ Qwen32B 起動完了 (PID: $!)"
echo ""

# Step 3: Codestral-22B (コーディング特化) を起動
echo "[3/5] Codestral-22B-v0.1-4bit を起動中..."
echo "      ポート: 8081"
echo "      用途: コーディング・プログラミング支援"
uvx --from mlx-lm mlx_lm.server \
  --model mlx-community/Codestral-22B-v0.1-4bit \
  --port 8081 \
  > ~/mlx-codestral22b.log 2>&1 &
echo "✓ Codestral22B 起動完了 (PID: $!)"
echo ""

# Step 4: Qwen2.5-7B (軽量モデル) を起動
echo "[4/5] Qwen2.5-7B-Instruct-4bit を起動中..."
echo "      ポート: 8082"
echo "      用途: 高速レスポンス用軽量モデル"
uvx --from mlx-lm mlx_lm.server \
  --model mlx-community/Qwen2.5-7B-Instruct-4bit \
  --port 8082 \
  > ~/mlx-qwen7b.log 2>&1 &
echo "✓ Qwen7B 起動完了 (PID: $!)"
echo ""

# Step 5: モデルの初期化を待つ
echo "[5/5] モデルの初期化を待機中..."
echo "      (モデルのダウンロードと読み込みに時間がかかります)"
for i in {10..1}; do
  echo -n "      $i秒... "
  sleep 1
done
echo ""
echo "✓ 初期化待機完了"
echo ""

# 完了メッセージ
echo "=========================================="
echo "MLX-LM Cluster 起動完了！"
echo "=========================================="
echo ""
echo "サーバー情報:"
echo "  • Qwen32B:      http://localhost:8080"
echo "  • Codestral22B: http://localhost:8081"
echo "  • Qwen7B:       http://localhost:8082"
echo ""
echo "ログファイル:"
echo "  • ~/mlx-qwen32b.log"
echo "  • ~/mlx-codestral22b.log"
echo "  • ~/mlx-qwen7b.log"
echo ""
echo "次のステップ:"
echo "  1. プロセス確認: ps aux | grep mlx_lm.server"
echo "  2. ログ確認: tail -f ~/mlx-qwen32b.log"
echo "  3. 接続テスト: curl http://localhost:8080/health"
echo ""

# メモリ監視モードの提案
echo "=========================================="
echo "メモリ使用状況を監視しますか？"
echo "=========================================="
echo ""
echo "リアルタイムでメモリ使用量を監視するには、"
echo "以下のコマンドを実行してください："
echo ""
echo "  watch -n 2 'ps aux | grep mlx_lm.server | grep -v grep'"
echo ""
echo "または、よりシンプルに："
echo ""
echo "  watch -n 2 'ps aux | grep \"[m]lx_lm.server\" | awk '\"'\"'{print \$2, \$3, \$4, \$11}'\"'\"''"
echo ""
echo "Ctrl+C で監視を終了できます。"
echo ""
