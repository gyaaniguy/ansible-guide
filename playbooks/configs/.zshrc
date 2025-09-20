export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(fzf-tab zsh-autosuggestions git dirhistory zsh-syntax-highlighting )

source $ZSH/oh-my-zsh.sh

# some modifications. can ignore maybe
autoload -U compinit && compinit
zstyle ':completion:*' menu select

# history sanity options.
setopt HIST\_FIND\_NO_DUPS
setopt HIST\_SAVE\_NO_DUPS

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(zoxide init zsh)"