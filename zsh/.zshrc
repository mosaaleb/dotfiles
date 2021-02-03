export ZSH="/home/muhammad/.oh-my-zsh"

ZSH_THEME="miloshadzic"
CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="false"
export UPDATE_ZSH_DAYS=30
ENABLE_CORRECTION="false"
COMPLETION_WAITING_DOTS="true"

# Standard plugins in: $ZSH/plugins/ Custom Plugins in: $ZSH_CUSTOM/plugins/
plugins=(git z zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi
# aliases
################################################################################
# config files
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias tmuxconfig="nvim ~/.tmux.conf"
alias nvimconfig="nvim ~/.config/nvim/init.vim"
alias alacrittyconfig="nvim ~/.config/alacritty/alacritty.yml"

# places
alias gorails="cd ~/Desktop/rails"
alias goself="cd ~/Desktop/rails/self"
alias goreview="cd /home/muhammad/reviews"
alias godesign="cd ~/Desktop/ruby/OOP\ Design/"
alias gomicroverse="cd ~/Desktop/rails/microverse"
alias gowork='cd /home/muhammad/Desktop/rails/work'
alias gogems='cd /home/muhammad/Desktop/rails/self/ruby'
alias goscreens="cd /home/muhammad/Desktop/rails/screencasts"
alias goengines='cd /home/muhammad/Desktop/rails/self/ruby/engines'

# commands
# alias python="/usr/bin/python3.7"
alias fcopy="xclip -selection clipboard"
alias fpaste="xclip -selection clipboard -o"
alias elastic="/tmp/elasticsearch-7.5.2/bin/elasticsearch"
alias review="bundle && yarn install --check-files && rails db:migrate:reset"

# tizonia music
alias tz-80s="tizonia --youtube-audio-search '80s synthwave'"
alias tz-bonga="tizonia --youtube-audio-playlist 'RDgL5d_xvdlPo'"
alias tz-innerbloom="tizonia --youtube-audio-playlist 'RDTx9zMFodNtA'"
alias tz-classical="tizonia --youtube-audio-stream 'youtube.com/watch?v=uMCSdgkdOJc'"
alias tz-chillwave="tizonia --youtube-audio-playlist 'PLGh8nnGk_kLjVq2wiefjT_Z2lkCHPQbIo'"
alias tz-chill="tizonia --youtube-audio-playlist 'RDCLAK5uy_mPolD_J22gS1SKxufARWcTZd1UrAH_0ZI'"

# reload kernel modules
alias x="sudo rmmod btusb"
alias y="sudo modprobe btusb"

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
