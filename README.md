# dotfiles

設定ファイル

## install

```
zsh install.zsh
```

## System Preferences

- 一般
    - 外観モード: ダーク
    - アクセントカラー: グレー
    - 強調表示色: グラファイト
    - サイドバーのアイコンサイズ: 小
- Dock
    - サイズ調整
- インターネットアカウント
    - 各アカウントを有効化
- アクセシビリティ
    - ポインタコントロール
        - トラックパッドオプション
            - ドラッグを有効にする: 3本指のドラッグ
- トラックパッド
    - タップでクリック
    - 軌跡の速さ: 最大
- 共有
    - コンピュータ名: psfldr-mba

## note

### configure script macOS setting

`defaults` コマンドによる設定は難解なので断念

### zsh compaudit: insecure directory

[zsh completion - zsh compinit: insecure directories - Stack Overflow](
https://stackoverflow.com/questions/13762280/zsh-compinit-insecure-directories
)

```
zsh compinit: insecure directories, run compaudit for list.
Ignore insecure directories and continue [y] or abort compinit [n]? y%                                                                                                      psfldr@psfldr-mba ~ %
~ % compaudit
There are insecure directories:
/usr/local/share/zsh/site-functions
/usr/local/share/zsh
~ % ls -l /usr/local/share/zsh/
total 0
drwxrwxr-x 5 psfldr admin 160  8 16 15:25 site-functions
~ % ls -l /usr/local/share/ | grep zsh
drwxrwxr-x  3 psfldr admin   96  8 11 23:44 zsh
~ % compaudit | xargs chmod go-w
There are insecure directories:
~ % ls -l /usr/local/share/ | grep zsh
drwxr-xr-x  3 psfldr admin   96  8 11 23:44 zsh
~ % ls -l /usr/local/share/zsh/
total 0
drwxr-xr-x 5 psfldr admin 160  8 16 15:25 site-functions
~ % compaudit
~ %
```

### vscode extention

```
psfldr@psfldr-mba dotfiles % date; code --list-extensions
2020年 8月30日 日曜日 19時43分00秒 JST
AndrsDC.base16-themes
GitHub.github-vscode-theme
tusaeff.vscode-iterm2-theme-sync
vscodevim.vim
```

## TODO

- neofetch
- vscode extention installation script

