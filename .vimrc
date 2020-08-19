" escキーの遅延対策
set ttimeoutlen=10

" カーソルの形状
if has('vim_starting')
    " 挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    " ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .= "\e[2 q"
    " 置換モード時に非点滅の下線タイプのカーソル
    let &t_SR .= "\e[4 q"
endif
autocmd VimEnter * silent exec "! echo -ne '\e[2 q'"
autocmd VimLeave * silent exec "! echo -ne '\e[6 q'" 

