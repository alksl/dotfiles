autoload -U zargs # Load zargs function (xargs replacement)
autoload -U add-zsh-hook # Add ZSH hook plugin

# Enable command line edting
autoload -z edit-command-line
zle -N edit-command-line

# Load completion system
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit
zstyle ':completion:*' menu select
zstyle ':completion:*' menu select=20
setopt menu_complete

# Load VCS info variables
autoload -U vcs_info
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*:*' check-for-changes true # Can be slow on big repos.
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'
zstyle ':vcs_info:*:*' actionformats "%S" "%b%m%u%c (%a)"
zstyle ':vcs_info:*:*' formats "%S" "%b%m%u%c "
zstyle ':vcs_info:*:*' nvcsformats "%~" ""

# Configure PATH
export ZSH="$HOME/.zsh"
export EDITOR=nvim

# Use home local bin if it exists
if [[ -d "$HOME/.local/bin" ]]
then
  PATH=$HOME/.local/bin:$PATH
fi

export PATH

# Watch all user except me
watch=notme
LOGCHECK=0

# Configure ZSH function path
fpath=(~/.zsh/functions $fpath)
source ~/.zsh/functions/p

# Use vi mode but restore some sane emacs commands.
bindkey -v
bindkey -M viins '^a' beginning-of-line
bindkey -M viins '^e' end-of-line
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

# Configure PROMT
setopt promptsubst
typeset -Ag FX FG BG
FX=(
    reset     "[00m"
    bold      "[01m" no-bold      "[22m"
    italic    "[03m" no-italic    "[23m"
    underline "[04m" no-underline "[24m"
    blink     "[05m" no-blink     "[25m"
    reverse   "[07m" no-reverse   "[27m"
)

for color in {000..255}; do
    FG[$color]="[38;5;${color}m"
    BG[$color]="[48;5;${color}m"
done

# Customizable parameters.
PROMPT_PATH_MAX_LENGTH=30
PROMPT_DEFAULT_END=❯
PROMPT_ROOT_END=❯❯❯
PROMPT_SUCCESS_COLOR=$FG[071]
PROMPT_FAILURE_COLOR=$FG[124]
PROMPT_VCS_INFO_COLOR=$FG[250]

# Define prompts.
PROMPT="%{$PROMPT_VCS_INFO_COLOR%}"'$vcs_info_msg_1_'"%{$FX[reset]%}"
PROMPT+="%(0?.%{$PROMPT_SUCCESS_COLOR%}.%{$PROMPT_FAILURE_COLOR%})"
PROMPT+="${SSH_TTY:+[%n@%m]}"
PROMPT+="%{$FX[bold]%}%$PROMPT_PATH_MAX_LENGTH<..<"'${vcs_info_msg_0_%%.}'"%<<%(!.$PROMPT_ROOT_END."
PROMPT+="${PROMPT_DEFAULT_END}"
PROMPT+="%{$FX[no-bold]%}%{$FX[reset]%} "

# History file settings
export HISTIGNORE="&:ls:[bf]g:reset:clear:cd:cd .."
export HISTSIZE=25000
export HISTFILE=~/.zsh_history
export SAVEHIST=5000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# Report time of command if it took longer than 30 seconds
export REPORTTIME=15

# Configure FZF
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
source ~/.zsh/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

# Setup aliases
alias gd="git diff"
alias gdc="git diff --cached"
alias glo="git log --oneline"
alias icat="kitty +kitten icat"

# Load ASDF tool version manager
source /opt/asdf-vm/asdf.sh

# Load local zshrc
if [[ -f "${HOME}/.zshrc.local" ]]; then
  source "${HOME}/.zshrc.local"
fi

export HUSKY=0

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then 
  source "$HOME/google-cloud-sdk/path.zsh.inc"
fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then 
  source "$HOME/google-cloud-sdk/completion.zsh.inc"
fi
