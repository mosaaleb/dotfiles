export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/bin:$PATH"
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/12/bin

ZSH_THEME="miloshadzic"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="false"
export UPDATE_ZSH_DAYS=30
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"

# Standard plugins in: $ZSH/plugins/ Custom Plugins in: $ZSH_CUSTOM/plugins/
plugins=(z zsh-syntax-highlighting zsh-autosuggestions asdf jira)

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
alias seeing_is_believing="andyw8_seeing_is_believing"

# pennylane
alias penny="cd ~/code/pennylane/jeancaisse"
alias prodcon="heroku run rails console --app jeancaisse-prod"
alias stagcon="heroku run rails console --app"

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
export PATH="/opt/homebrew/opt/icu4c/bin:$PATH"
export PATH="/opt/homebrew/opt/icu4c/sbin:$PATH"

function hiicu63() {
  local last_dir=$(pwd)

  cd $(brew --prefix)/Library/Taps/homebrew/homebrew-core/Formula
  git checkout icu4c-69
  brew reinstall ./icu4c.rb
  git checkout master

  cd $last_dir
}
export PATH="/opt/homebrew/opt/postgresql@12/bin:$PATH"
