# Markdown Editor

軽量・インストール不要・ローカル専用の Markdown エディタ。
ブラウザUIのない独立ウィンドウで起動し、ライブプレビューを見ながら `.md` ファイルを直接編集・保存できます。

## 特徴

- **インストール不要** — 単一HTMLを Edge / Chrome の `--app` モードで起動
- **オフライン動作** — 外部ネットワーク通信なし（CDN 非依存）
- **ライブプレビュー** — 入力と同時に右ペインへ HTML レンダリング
- **ローカルファイル直編集** — File System Access API で `.md` を直接開いて上書き保存
- **ドラッグ&ドロップ対応** — エクスプローラからファイルを落として開ける
- **編集 / 閲覧モード切替** — プレビューのみの全幅表示にも切替可能
- **書式ショートカット** — 太字・斜体・リスト・テーブル等の Markdown 書式を素早く挿入
- **フォルダツリー** — サイドバーでフォルダを開き、ツリーからファイルをクリックで切替
- **Mermaid ダイアグラム対応** — ` ```mermaid ``` ` コードブロックをフロー図・シーケンス図等へ自動レンダリング
- **XSS / 通信防御** — Content Security Policy と DOMPurify により、信頼できない `.md` を開いても外部送信・スクリプト実行は発生しません

## 動作環境

- Windows 10 / 11
- Microsoft Edge または Google Chrome (Chromium 系)
  - File System Access API は Chromium 系ブラウザのみサポート

## セットアップ

1. このリポジトリを clone もしくは ZIP でダウンロードし、任意のフォルダに展開
2. `start.cmd` をダブルクリック

以上です。インストール処理は発生しません。

他OS (macOS / Linux) で使う場合は、Chrome/Edge で以下のように起動してください:

```sh
# macOS
open -a "Google Chrome" --args --app="file:///path/to/index.html"

# Linux
google-chrome --app="file:///path/to/index.html"
```

## 使い方

- 左ペインに Markdown を入力 → 右ペインにプレビューが即時反映
- ツールバー:
  - **Open** — ローカルの `.md` ファイルを開く
  - **Save / Save As** — 上書き保存 / 名前を付けて保存
  - **View / Edit** — エディタを隠してプレビュー全幅表示
  - **?** — ショートカット一覧を表示
- `.md` ファイルをウィンドウへ **ドラッグ&ドロップ** しても開けます

## キーボードショートカット

### ファイル / モード

| キー | 動作 |
|---|---|
| `Ctrl+O` | ファイルを開く |
| `Ctrl+S` | 上書き保存 |
| `Ctrl+Shift+S` | 名前を付けて保存 |
| `Ctrl+E` | 編集 / 閲覧モード切替 |
| `F1` / `?` | ヘルプ表示 |

### 書式 (エディタフォーカス時)

| キー | 動作 |
|---|---|
| `Ctrl+B` | 選択を `**太字**` に |
| `Ctrl+I` | 選択を `*斜体*` に |
| `Ctrl+K` | 選択を `[text](url)` に |
| `` Ctrl+` `` | 選択を `` `code` `` に |
| `Ctrl+Shift+K` | 選択を `~~取消線~~` に |
| `Ctrl+Shift+C` | コードブロックを挿入 |
| `Ctrl+Shift+Q` | 選択行頭に `> ` を付与（引用） |
| `Ctrl+Shift+L` | 選択行頭に `- ` を付与（リスト） |
| `Ctrl+Shift+T` | 空のテーブル雛形を挿入 |
| `Ctrl+Enter` | リスト / 引用の次行を自動生成 |

## ファイル構成

```
markdown-editor/
├── index.html        本体 (HTML / CSS / JS を 1 ファイルに内包)
├── start.cmd         Windows 用ランチャ (Edge → Chrome の順で探して --app 起動)
├── lib/
│   ├── marked.umd.js  Markdown パーサ (marked v18.0.0 / MIT)
│   ├── purify.min.js  HTML サニタイザ (DOMPurify v3.4.0 / Apache-2.0 or MPL-2.0)
│   └── mermaid.min.js ダイアグラムレンダラ (mermaid v11.14.0 / MIT)
└── README.md
```

## セキュリティ

本アプリはローカル動作を前提としており、以下の多層防御を実装しています。

- **Content Security Policy** (`<meta http-equiv>`) でブラウザレベルの通信を制限
  - `connect-src 'none'` : fetch / XHR / WebSocket 全面禁止
  - `img-src 'self' data:` : 外部画像の自動取得を禁止 (トラッキング画像対策)
  - `frame-src / object-src 'none'` : `<iframe>` / プラグインを禁止
  - `form-action 'none'` : フォーム送信による情報漏洩を禁止
- **DOMPurify** で `marked` の出力をサニタイズし、`<script>` や `onerror=` 等を除去
- アプリコード内に `fetch` / `XMLHttpRequest` / `WebSocket` / `sendBeacon` / `eval` / `new Function` の呼び出しは **一切ありません**
- 外部 CDN への依存なし（ライブラリは `lib/` に同梱）

**編集している `.md` の内容は一切外部に送信されません。**

## サードパーティライブラリ

本リポジトリには以下のライブラリが同梱されています。いずれもライセンスヘッダーをファイル先頭に保持しています。

| ライブラリ | バージョン | ライセンス | 出典 |
|---|---|---|---|
| [marked](https://github.com/markedjs/marked) | 18.0.0 | MIT | Copyright (c) MarkedJS / Christopher Jeffrey |
| [DOMPurify](https://github.com/cure53/DOMPurify) | 3.4.0 | Apache-2.0 OR MPL-2.0 | Copyright (c) Cure53 and contributors |
| [mermaid](https://github.com/mermaid-js/mermaid) | 11.14.0 | MIT | Copyright (c) Knut Sveidqvist and contributors |

## ライセンス

本アプリ自体のライセンスは未設定です。公開時にお好みの OSS ライセンス（MIT 等）を選び、`LICENSE` ファイルを追加してください。
