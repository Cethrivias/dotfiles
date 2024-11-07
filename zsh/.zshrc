# Initializing Oh-My-Posh. (Skipping for default mac terminal app)
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/base.toml)"
fi

# Plugins
# zinit - package manager for zsh
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# zinit snippet OMZP::command-not-found

# Load completions (zsh-completions stuff)
autoload -U compinit && compinit
zinit cdreplay -q

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory # shares history between shells. Dont know about that
# setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|?=**'
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z} l:|=* r:|=*'
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -a --color $realpath'
setopt GLOB_DOTS # needed to autocomplete hidden directories

eval "$(fzf --zsh)"
eval $(thefuck --alias)

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Keybindings
bindkey -M emacs "^[[3~" delete-char
bindkey -M viins "^[[3~" delete-char
bindkey -M vicmd "^[[3~" delete-char

bindkey -M emacs "^[3;5~" delete-char
bindkey -M viins "^[3;5~" delete-char
bindkey -M vicmd "^[3;5~" delete-char


# Aliases
alias nv=nvim
alias lg=lazygit
alias ll="ls -alh --color"
alias ls="ls --color"
alias ..="cd .."
alias ...="cd ../.."
alias dt='dotnet test --logger "console;verbosity=normal"'
alias dtf='dotnet test --logger "console;verbosity=normal" --filter'
alias dwatch='dotnet watch build --project'
alias javals="/usr/libexec/java_home -V"
alias dockertop="docker ps --format '{{ .Names }}' | docker stats"

# Functions
lfcd(){
  # `command` is needed in case `lfcd` is aliased to `lf`
  cd "$(command lf -last-dir-path="$@")"
}
cdfzf() {
  cd "$(find "$HOME/Projects" -type d ! -path '*/node_modules/*' ! -path '*/src/*' ! -path '*/tests/*' ! -path '*/.*/*' ! -path '*/bin/*' ! -path '*/obj/*' -print | fzf)"
}
javaset(){
  echo `/usr/libexec/java_home -v $1`
  export JAVA_HOME=`/usr/libexec/java_home -v $1`
}
dotnetsecrets(){
  dir=`basename "$(pwd)"`
  file="$dir.csproj"
  if [ ! -f $file ]
  then
    echo "File \"$file\" does not exists. Is this a project folder?"
    return
  fi
  uuid=`xpath -e "Project/PropertyGroup/UserSecretsId" -q $file | cut -c16-51`
  if [ -z "$uuid" ]
  then
    echo "Could not find UserSecretsId. Probably secrets were not initialized. Try \"dotnet user-secrets init\""
    return
  fi
  mkdir -p ~/.microsoft/usersecrets/$uuid
  secrets="~/.microsoft/usersecrets/$uuid/secrets.json"
  echo "Opening $secrets"
  nvim ~/.microsoft/usersecrets/$uuid/secrets.json
}

# Extra env
export TERM="xterm-256color"
export PATH="$PATH:$HOME/go/bin:/opt/homebrew/opt/libpq/bin"

# Keybindings
bindkey -e # emacs style

# EXPERIMENTAL
function newworktree() {
    task=$1
    dir=`basename $(pwd)`
    worktree_path="$HOME/Projects/tasks/$task/$dir"
    if [ -d "$worktree_path" ]; then
        echo "Changing directory to: $worktree_path"
        cd $worktree_path
        return
    fi

    echo "Creating new worktree at: $worktree_path"
    if [ -n "$(git branch --list $task)" ]; then
        echo "Branch exists"
        git worktree add $worktree_path $task
    else
        echo "Branch does not exist"
        git worktree add $worktree_path -b $task
    fi

    echo "Changing directory to: $worktree_path"
    cd $worktree_path
}

# Sourcing private scripts
local private_scripts_dir="$HOME/.config/zsh/private"
local private_scripts=( "$(find $private_scripts_dir -type f -name '*.zsh' -print)" )
for f in "${private_scripts[@]}"; do
   [[ -f $f ]] && source $f || echo "$f not found"
done 
