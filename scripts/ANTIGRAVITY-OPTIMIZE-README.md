# Antigravity軽量化ツール

M1 Max 64GB環境で重たくなったAntigravityを軽量化するツール集

## 🚀 クイックスタート（1コマンドで全実行）

```bash
cd ~/Desktop/TalkSwitch-Cursor/TalkSwitch-AI
bash scripts/antigravity-optimize-all.sh
```

これだけで：
- ✅ メモリ使用量確認
- ✅ 全MLXサーバー停止
- ✅ Qwen 32B-8bit単独起動
- ✅ Continue.dev設定最小化
- ✅ 最終確認

全て自動で実行されます。

---

## 📋 ステップごとに実行する場合

### Step 1: メモリ使用量確認

```bash
bash scripts/step1-check-memory.sh
```

- システムメモリ情報を表示
- MLXプロセスを確認
- Activity Monitorでの確認を促す

### Step 2: 全MLXサーバー停止

```bash
bash scripts/step2-stop-all-mlx.sh
```

- 安全にSIGINTで停止
- 停止しない場合は自動で強制終了
- プロセス確認

### Step 3: Qwen 32B-8bit 最小起動

```bash
bash scripts/step3-start-qwen32b-minimal.sh
```

- メモリ最適化オプション付きで起動（max-kv-size=8192）
- ポート8080で起動
- 起動確認を自動実行

### Step 4: Continue.dev設定最小化

```bash
bash scripts/step4-update-continue-config.sh
```

- 既存設定を自動バックアップ
- 最小化設定を適用
- Qwen 32B単独構成

### Step 5-6: 最終確認

```bash
bash scripts/step5-6-final-check.sh
```

- Agent Manager整理の確認
- メモリ使用量の最終チェック
- 目標値との比較

---

## 🎯 目標メモリ使用量

- **Unified Memory**: 40GB以下
- **GPU Memory**: 35GB前後

---

## 📝 手動確認が必要な項目

以下は自動化できないため、手動で確認してください：

1. **Activity Monitorでのメモリ確認**
   - Spotlight（Cmd + Space）→「アクティビティモニター」
   - 「メモリ」タブを選択
   - 下部の使用済みメモリとGPU Memoryを確認

2. **Agent Managerでのエージェント整理**
   - Agent Managerを開く
   - Inboxの起動中エージェントを確認
   - 不要なエージェントを右クリック → Stop/Delete

3. **Cursor Pro再起動**
   - Cmd + Q → Cursor Proを再起動
   - Continueパネルでモデル選択

4. **動作テスト**
   - Talk Switch AIでメッセージ送信
   - レスポンス速度を確認

---

## 🔧 トラブルシューティング

### MLXサーバーが起動しない

```bash
# ログを確認
tail -f ~/mlx-qwen32b-minimal.log

# プロセス確認
ps aux | grep mlx_lm.server
```

### メモリ使用量が減らない

1. 他のアプリケーションを終了
2. Agent Managerで全エージェント停止
3. Macを再起動

### 設定を元に戻したい

```bash
# Continue.dev設定を復元
cp ~/.continue/config.json.backup.* ~/.continue/config.json

# MLXサーバーを停止
bash scripts/step2-stop-all-mlx.sh
```

---

## 📂 ファイル構成

```
scripts/
├── antigravity-optimize-all.sh      # 全ステップ自動実行
├── step1-check-memory.sh            # メモリ確認
├── step2-stop-all-mlx.sh            # サーバー停止
├── step3-start-qwen32b-minimal.sh   # Qwen 32B起動
├── step4-update-continue-config.sh  # 設定更新
├── step5-6-final-check.sh           # 最終確認
└── ANTIGRAVITY-OPTIMIZE-README.md   # このファイル

config-samples/
└── continue-config-minimal.json     # 最小化設定
```

---

## ⚠️ 注意事項

- **バックアップ**: Continue.dev設定は自動でバックアップされます
- **安全性**: MLXサーバーは安全に停止（SIGINT→強制終了）
- **確認**: 各ステップで確認プロンプトが表示されます

---

## 💡 ヒント

- 定期的にメモリ使用量を確認：`bash scripts/step1-check-memory.sh`
- 使わないエージェントは即座にStop
- モデル切り替えは `~/switch-mlx.sh` を使用
