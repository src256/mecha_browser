# MechaBrowser

Mecha Browser is a Ruby gem that allows users to browse the web programmatically, automating interactions with web pages and extracting information in a mechanical fashion.

## インストール

Gemfileに以下の行を追加してください：

```ruby
gem 'mecha_browser'
```

そして以下を実行してください：

```bash
$ bundle install
```

またはgemコマンドでインストールできます：

```bash
$ gem install mecha_browser
```

## 使い方

### コマンドライン

```bash
$ mb [オプション] <URL>
```

### オプション

- `-v, --verbose`: 詳細なメッセージを表示
- `-n, --dry-run`: メッセージのみを表示（実際のアクセスなし）
- `-d, --config-dir`: 設定ディレクトリを指定
- `-t, --type`: ブラウザタイプを指定（ruby|selenium、デフォルト：ruby）
- `-h, --help`: ヘルプメッセージを表示

### 例

```bash
# 基本的な使用
$ mb https://example.com

# 詳細モードで実行
$ mb -v https://example.com

# ドライランモード
$ mb -n https://example.com
```

### 設定ファイル

デフォルトの設定ファイルは `~/.mechabrowser/config.yml` です。

設定例：

```yaml
browser:
  user_agent: "User Agent String"
```

## 開発

### 基本的な開発コマンド

```bash
# テストの実行
$ rake test

# 対話的なコンソールでのテスト
$ bin/console

# ローカルマシンにgemをインストール
$ bundle exec rake install

# リリース
$ bundle exec rake release
```

### アーキテクチャ

MechaBrowserはプラグイン型のアーキテクチャを採用しており、異なるブラウザバックエンドを選択できます。

#### 主要コンポーネント

1. **Command Layer** - コマンドライン引数の解析と設定管理
2. **Browser Layer** - ブラウザ実装の抽象化
   - `BaseBrowser` - すべてのブラウザ実装のベースクラス
   - `RubyBrowser` - web_loadergemを使用したRuby実装

#### 依存関係

- `web_loader` - RubyBrowserで使用するWebコンテンツ読み込み用gem
- `minitest` - テストフレームワーク

## ライセンス

MIT License

## 貢献

バグレポートやプルリクエストは歓迎します。このプロジェクトは、協力的で歓迎されるコミュニティを提供することを目的としています。
