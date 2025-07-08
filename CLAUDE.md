# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

やりとりは日本語でお願いします。

## 開発コマンド

### 基本的な開発コマンド
- `rake test` - テストの実行
- `bin/console` - 対話的なコンソールでのテスト
- `bundle exec rake install` - ローカルマシンにgemをインストール
- `bundle exec rake release` - バージョンをリリース

### 実行ファイル
- `exe/mb` - メインの実行ファイル（MechaBrowser::Command.run(ARGV)を呼び出す）

## プロジェクト構造

### アーキテクチャ概要
MechaBrowserは、プログラムでWebブラウジングを行うためのRuby gemです。異なるブラウザバックエンドを選択できるプラグイン型のアーキテクチャを採用しています。

### 主要コンポーネント
1. **Command Layer** (`lib/mecha_browser/command.rb`)
   - コマンドライン引数の解析
   - 設定ファイルの読み込み（`~/.mechabrowser`）
   - ブラウザタイプの選択（ruby/selenium）
   - オプション：`-v`（verbose）、`-n`（dry-run）、`-c`（config）、`-t`（type）

2. **Browser Layer** (`lib/mecha_browser/browser/`)
   - `BaseBrowser` - すべてのブラウザ実装のベースクラス
   - `RubyBrowser` - web_loadergemを使用したRuby実装
   - User Agent、ログ、verboseモードの設定をサポート

3. **Configuration**
   - YAMLベースの設定ファイル
   - User Agentのカスタマイズ
   - デフォルト値の自動設定

### 重要な依存関係
- `web_loader` - RubyBrowserで使用するWebコンテンツ読み込み用gem
- `minitest` - テストフレームワーク

### 設定ファイル
- デフォルト設定ファイル：`~/.mechabrowser`
- YAML形式で`browser.user_agent`等の設定が可能
- 設定されていない場合は、デフォルトのUser Agentを使用

## 開発における重要なポイント

### ブラウザタイプの拡張
新しいブラウザタイプを追加する場合：
1. `lib/mecha_browser/browser/`に新しいクラスを作成
2. `BaseBrowser`を継承
3. `browse(url)`メソッドを実装
4. `command.rb`の`create_browser`メソッドにケースを追加

### テスト
- `rake test`でテストを実行
- テストファイルは`test/test_*.rb`の形式
- 現在のテストは未完成（`assert false`のままのテストあり）

# important-instruction-reminders
Do what has been asked; nothing more, nothing less.
NEVER create files unless they're absolutely necessary for achieving your goal.
ALWAYS prefer editing an existing file to creating a new one.
NEVER proactively create documentation files (*.md) or README files. Only create documentation files if explicitly requested by the User.