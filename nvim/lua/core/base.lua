-- 行番号を表示
vim.opt.number = true

-- エラーのある行に印を表示
vim.opt.signcolumn = 'auto'

-- タブ文字が対応するスペースの数
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- インデントの幅
vim.opt.shiftwidth = 4

-- 一行あたりの最大文字数
vim.opt.textwidth = 0

-- インデントにタブ文字を使う
vim.opt.expandtab = false

-- 開く時の文字コード
vim.opt.fileencodings = 'utf-8,ucs-bom,euc-jp,sjis,iso-2022-jp'

-- タブを使えるようにする
vim.opt.tabpagemax = 50
vim.opt.showtabline = 2

-- BSキーで消せる特殊文字
vim.opt.backspace = 'indent,eol,start'

-- タブ文字等を文字で表す
vim.opt.list = true

-- タブ文字や末尾のスペースを文字で表示
vim.opt.listchars = { tab = '|» ', trail = '~', extends = '»', precedes = '«' }

-- マウスを使えるようにする
vim.opt.mouse = 'a'

-- 高速ターミナル接続
vim.opt.ttyfast = true

-- 次のコマンドが入力されなかった時にタイムアウトする
vim.opt.timeout = true

-- コマンドの次の文字の入力待ち時間
vim.opt.timeoutlen = 1000

-- 端末のキーコードについてタイムアウトする
vim.opt.ttimeout = true

-- キーコード待ちの時間
vim.opt.ttimeoutlen = 75

-- 放棄されたバッファを隠れ状態にする
vim.opt.hidden = true

-- 括弧を入力した時に一瞬だけカーソルを対応する括弧に移動
vim.opt.showmatch = true

-- 検索結果を強調表示
vim.opt.hlsearch = true

-- コマンド履歴を保存する件数
vim.opt.history = 1000

-- カーソルの位置を表示
vim.opt.ruler = true

-- 入力したコマンドを右下に表示
vim.opt.showcmd = true

-- ステータスラインを常に表示
--vim.opt.laststatus = 2

-- ステータスラインに表示する内容
--vim.opt.statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l\,%c%V%8P

-- コマンドラインで補完を使う
vim.opt.wildmenu = true

-- コマンドラインで補完時に共通する部分まで自動入力
vim.opt.wildmode = 'longest,full'

-- 幅が決まっていない文字の幅を 1 文字分に設定
vim.opt.ambiwidth = 'single'

-- True Color 表示
vim.opt.termguicolors = true

-- 背景透過
vim.opt.winblend = 0

-- diff のアルゴリズムを変更
vim.opt.diffopt:append({
  "algorithm:histogram", -- ブロックを適切に扱える
  "indent-heuristic", -- インデントの違いを無視
})

-- signcolumn に重要な診断結果を優先的に表示
vim.diagnostic.config({
  severity_sort = true,
})
