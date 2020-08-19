# vimのEscの反映の遅延を防ぐ。(2020-08-19 不具合あればやめる。)
# https://qiita.com/k2nakamura/items/fa19806a041d0429fc9f
KEYTIMEOUT=1

# エイリアス
alias ls='gls --color=auto'

# 色設定
eval $(gdircolors $HOME/.dircolors/dircolors-solarized/dircolors.ansi-dark)
if [ -n "$TMUX" ]; then
  export TERM=screen-256color
fi
# lsコマンドの補完候補
zstyle ':completion:*' list-colors ${LS_COLORS}

# history設定
HISTFILE=$HOME/.zsh-history   # 履歴を保存するファイル
HISTSIZE=1000                 # メモリ上に保存する項目数
SAVEHIST=10000                # 履歴ファイルの項目数
setopt inc_append_history     # ファイルに追加
setopt share_history          # タブやウィンドウ間で履歴を共有
setopt hist_ignore_all_dups   # 重複するコマンドは古い方を削除

# ディレクトリ最後の/を残す。
setopt noautoremoveslash

# 履歴からコマンドを選択して実行
function fzf_history_selection() {
  history -n 1 \
    | tac \
    | fzf --tiebreak=index \
    | read -d '' BUFFER
  CURSOR=$#BUFFER
  zle reset-prompt
}
zle -N fzf_history_selection
bindkey '^R' fzf_history_selection

# 履歴からディレクトリを選択して移動
autoload -Uz is-at-least
if is-at-least 4.3.11; then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':chpwd:*'      recent-dirs-max 500
  zstyle ':chpwd:*'      recent-dirs-default yes
  zstyle ':completion:*' recent-dirs-insert both
fi
function fzf_cdr () {
  cdr -l \
    | sed 's/^[^ ][^ ]*  *//' \
    | fzf --tiebreak=index \
    | read -d '' target_dir
  target_dir=`echo ${target_dir/\~/$HOME}`
  if [ -n "$target_dir" ]; then
    BUFFER="cd ${target_dir}"
    zle accept-line
  fi
}
zle -N fzf_cdr
bindkey '^T' fzf_cdr

# Gitリポジトリへの移動
function fzf_ghq () {
  ghq list \
    | fzf --ansi --preview "
        echo '[Content]'
        gls -alp --color=auto --time-style=long-iso $(ghq root)/{} \
          | tail -n +4 \
          | tail \
          | awk '{print \"[\"\$6\" \"\$7\"] \"\$8}';
        echo -e '\n[Git Log]'
        git -C $(ghq root)/{} log --date=short \
          --pretty=format:'%Cgreen[%cd]%Creset %s' \
          | head
      "\
    | read -d '' target_dir
  if [ -n "$target_dir" ]; then
    BUFFER="cd $(ghq root)/${target_dir}"
    zle accept-line
  fi
}
zle -N fzf_ghq
bindkey '^G' fzf_ghq

