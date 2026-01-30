# MLXツール

M1 Max 64GB用のローカルMLXサーバー切り替えツール

## インストール（1コマンドだけ）

リポジトリをクローンして、インストールスクリプトを実行：

```bash
cd ~/Desktop/TalkSwitch-Cursor/TalkSwitch-AI
bash scripts/install-mlx-tools.sh
```

## 使い方

### モデル切り替え

```bash
# Qwen 32B起動（開発・コード生成用）
~/switch-mlx.sh qwen32b

# Llama Vision起動（画像解析用）
~/switch-mlx.sh vision

# 全て停止
~/switch-mlx.sh stop
```

### Continue.dev設定

1. Cursor Proを完全再起動（Cmd + Q）
2. Continueチャットでモデル選択
3. 「🚀 MLX Current」を選択

### カスタムコマンド

- `/switch-qwen32b` - Qwen 32Bへの切り替え方法を表示
- `/switch-vision` - Llama Visionへの切り替え方法を表示
- `/review` - コードレビュー
- `/optimize` - コード最適化
- `/explain` - コード解説
- `/test` - テストケース生成

## ファイル構成

```
scripts/
├── switch-mlx.sh           # MLXモデル切り替えスクリプト
├── install-mlx-tools.sh    # インストールスクリプト
└── README.md               # このファイル

config-samples/
└── continue-config.json    # Continue.dev設定ファイル
```

## トラブルシューティング

### モデルが起動しない

```bash
# ログを確認
tail -f ~/mlx-current.log

# プロセス確認
ps aux | grep mlx_lm.server
```

### Continue.devで接続できない

```bash
# サーバーが起動しているか確認
curl http://127.0.0.1:8080/v1/models

# Cursor完全再起動
# Cmd + Q → 再起動
```

### 設定を元に戻したい

```bash
# バックアップから復元
cp ~/.continue/config.json.backup.* ~/.continue/config.json
```
