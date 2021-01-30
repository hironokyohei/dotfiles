# 環境変数
export LANG=ja_JP.UTF-8
export KCODE=u           # KCODEにUTF-8を設定

## 色を使用出来るようにする
autoload -Uz colors
colors

## 補完機能を有効にする
autoload -Uz compinit
compinit

## タブ補完時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

## 日本語ファイル名を表示可能にする
setopt print_eight_bit

## ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

## PROMPT
# vcs_infoロード    
autoload -Uz vcs_info    

# PROMPT変数内で変数参照する    
setopt prompt_subst    

# vcsの表示    
zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr "+"
zstyle ':vcs_info:*' unstagedstr "*"
zstyle ':vcs_info:*' formats '(%b%c%u)'    
zstyle ':vcs_info:*' actionformats '(%b(%a)%c%u)'    

# プロンプト表示直前にvcs_info呼び出し    
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}    
#add-zsh-hook precmd _update_vcs_info_msg
#PROMPT="%{${fg[green]}%}%n%{${reset_color}%}@%F{blue}localhost%f:%1(v|%F{red}%1v%f|) $ "
PROMPT="%{${fg[green]}%}%n%{${reset_color}%}:%1(v|%F{red}%1v%f|) $ "
RPROMPT='[%F{green}%d%f]'

## Aliasの設定
# core
alias ll='ls -l'
alias ls='ls -G'
alias history='history -E 1'

## nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

## $GOPATH
export GOPATH=$HOME/Project/go

function onelogin-aws-assume-role-interface(){
  java -jar /Users/hironokyohei/Onelogin/onelogin-aws-cli.jar \
    -a 901159 \
    -u hironokyohei@team-lab.com \
    -d team-lab \
    --region ap-northeast-1 \
    --aws-account-id $1 \
    --aws-role-name $2
}

# usage: onelogin moridev
function onelogin(){
  case $1 in
    "moridev" )
      onelogin-aws-assume-role-interface \
        168682541898 \
        tlab-admin
      ;;
    "moriprod" )
      onelogin-aws-assume-role-interface \
        680507576474 \
        tlab-admin
      ;;
    * ) echo "invalid account name"
      ;;
  esac
}
