# MLX-LM Scripts

このディレクトリには、MLX-LMモデルを管理するためのスクリプトが含まれています。

## start-mlx-cluster.sh

3つのMLX-LMモデルをローカルで起動するスクリプトです。

### セットアップ

```bash
# ホームディレクトリにコピー
cp scripts/start-mlx-cluster.sh ~/start-mlx-cluster.sh
chmod +x ~/start-mlx-cluster.sh
```

### 使い方

```bash
# スクリプトを実行
~/start-mlx-cluster.sh
```

### 起動されるモデル

1. **Qwen2.5-32B-Instruct-4bit** (Port 8080)
   - メインの高性能モデル
   - 複雑なタスクに最適

2. **Codestral-22B-v0.1-4bit** (Port 8081)
   - コーディング特化モデル
   - プログラミング支援に最適

3. **Qwen2.5-7B-Instruct-4bit** (Port 8082)
   - 軽量高速モデル
   - シンプルなタスクに最適

### メモリ監視

モデル起動後、メモリ使用状況を監視できます：

```bash
# シンプルな監視
watch -n 2 'ps aux | grep "[m]lx_lm.server"'

# 詳細な監視（CPU、メモリ％表示）
watch -n 2 'ps aux | grep "[m]lx_lm.server" | awk '"'"'{print $2, $3, $4, $11}'"'"''
```

### トラブルシューティング

```bash
# プロセス確認
ps aux | grep mlx_lm.server

# ログ確認
tail -f ~/mlx-qwen32b.log
tail -f ~/mlx-codestral22b.log
tail -f ~/mlx-qwen7b.log

# 全プロセスを停止
pkill -f mlx_lm.server
```
