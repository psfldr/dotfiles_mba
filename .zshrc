# ディレクトリ選択時、最後の/を残す。好み。
setopt noautoremoveslash

# lsコマンドの補完候補にも色付き表示
if [ -n "$LS_COLORS" ]; then
  zstyle ':completion:*:default' list-colors ${LS_COLORS}
fi

# history設定
HISTFILE=$HOME/.zsh-history   # 履歴を保存するファイル
HISTSIZE=1000                 # メモリ上に保存する項目数
SAVEHIST=10000                # 履歴ファイルの項目数
setopt inc_append_history     # ファイルに追加
setopt share_history          # タブやウィンドウ間で履歴を共有
setopt hist_ignore_all_dups   # 重複するコマンドは古い方を削除

# 履歴からコマンドを選択して実行
function fzf_history_selection() {
  history -n 1 \
    | tac \
    | fzf \
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
    | fzf \
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
    | fzf --preview "
        echo '[Content]'
        gls -alp --time-style=long-iso $(ghq root)/{} \
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

