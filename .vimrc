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

