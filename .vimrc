" escキーの遅延対策
set ttimeoutlen=10

" カーソルの形状
if has('vim_starting')
    " 挿入モード時に点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[5 q"
    " ノーマルモード時に点滅のブロックタイプのカーソル
    let &t_EI .= "\e[1 q"
    " 置換モード時に点滅の下線タイプのカーソル
    let &t_SR .= "\e[3 q"
endif
autocmd VimEnter * silent exec "! echo -ne '\e[1 q'"
autocmd VimLeave * silent exec "! echo -ne '\e[5 q'"

""""""""""""""""""""""""""""""
" vim-plug
""""""""""""""""""""""""""""""
call plug#begin()
Plug 'lifepillar/vim-solarized8' " カラースキーム
Plug 'tomtom/tcomment_vim'              " コメント切り替え
Plug 'terryma/vim-multiple-cursors'     " 複数カーソル
Plug 'tpope/vim-fugitive'               " VimからGitを使用する
call plug#end()

""""""""""""""""""""""""""""""
"" カラースキーム
""""""""""""""""""""""""""""""
syntax enable
set background=dark
let g:solarized_termtrans=1
let g:solarized_use16=1
colorscheme solarized8

""""""""""""""""""""""""""""""
"" general
""""""""""""""""""""""""""""""
set encoding=utf-8
scriptencoding utf-8
set nrformats-=octal      " 0始まりの数字の増減操作の時8進数として操作しない
set nohidden              " hiddenバッファを積極的には使わない
set whichwrap=b,s,[,],<,> " 行頭、行末で左右に移動した時の動き
set wildmenu              " wildmenuを利用する。
set mouse=a               " すべてのモードでマウスを利用する
set conceallevel=0        " 一切concealしない。
set directory=~/.vim/tmp  " swp output directory
" ディレクトリがなければ作る
if !isdirectory($HOME.'/.vim/tmp')
    silent call mkdir ($HOME.'/.vim/tmp', 'p')
endif
fixdel                    " ターミナルオプション 't_kD' {訳注: デリートキー}
                          " の値を設定する。
set backspace=indent,eol,start
"" タブと空白
set expandtab             " Tab文字を挿入するとき、代わりに空白を使う。
set shiftwidth=4          " インデントの幅
set softtabstop=-1        " マイナスなら 'shiftwidth' の値が使われる。
set tabstop=4             " 画面上でTab文字が占める幅
set list                  " タブ文字、改行を表示する。
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
"" 表示設定
set number                " 行番号を表示
set synmaxcol=300         " 構文解析を行う桁数の最大値
set hls                   " 検索語をハイライト
set showmatch             " 括弧の対応を表示する
set matchtime=1           " showmatchのカーソル移動時間。単位は0.1秒。
set showcmd               " 入力中のコマンド・選択中の領域の大きさを表示する。
set cursorline            " カーソル行をハイライトする
set colorcolumn=80        " 80文字目をハイライトする
"" 特定のコマンドを実行する時に自動でquickfixウィンドウを開く
au QuickfixCmdPost make,grep,grepadd,vimgrep,helpg copen

""""""""""""""""""""""""""""""
"" key mapping
""""""""""""""""""""""""""""""
inoremap jj <esc>:noh<CR>:set nopaste<CR>:checktime<CR>:echo "ESC"<CR>
nnoremap <C-[> <esc>:noh<CR>:set nopaste<CR>:checktime<CR>:echo "ESC"<CR>

""""""""""""""""""""""""""""""
"" user defined command
""""""""""""""""""""""""""""""
" 行末のスペースを削除する。
if !exists(":TrimSpaces")
  command TrimSpaces %s/\s\+$//
endif
" 日付時刻を挿入する
if !exists(":InsertTime")
  command InsertTime put! =strftime(\"%Y-%m-%d %H:%M:%S\")
endif
" if !exists(":InsertTimeWithUnderbar")
"   command InsertTimeWithUnderbar put! =strftime(\"%Y_%m%d_%H%M_%S\")
" endif

