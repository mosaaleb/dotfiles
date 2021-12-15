export ZSH="/Users/mosaaleb/.oh-my-zsh"
export PATH="$HOME/bin:$PATH"

ZSH_THEME="miloshadzic"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="false"
export UPDATE_ZSH_DAYS=30
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"

# Standard plugins in: $ZSH/plugins/ Custom Plugins in: $ZSH_CUSTOM/plugins/
plugins=(z zsh-syntax-highlighting zsh-autosuggestions rvm jira)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Locale
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# aliases
################################################################################
# config files
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias tmuxconfig="nvim ~/.tmux.conf"
alias nvimconfig="nvim ~/.config/nvim/init.vim"
alias kittyconfig="nvim ~/.config/kitty/kitty.conf"
alias alacrittyconfig="nvim ~/.config/alacritty/alacritty.yml"

# places
alias bizimply="cd ~/code/work/bizimply"

# bindings
################################################################################
# source zsh key binding (ctrl r ctrl r)
function sourceZsh() {
  source ~/.zshrc;
  zle reset-prompt;
  zle redisplay;
  zle clear-screen;
}
zle -N sourceZsh
bindkey '^[r' sourceZsh

################################################################################
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/usr/local/opt/mysql@5.6/bin:$PATH"
