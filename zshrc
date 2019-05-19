# Use home local bin if it exists
if [[ -d "$HOME/local/bin" ]]
then
  PATH=$HOME/local/bin:$PATH
fi

ADT_BUNDLE_PATH="${HOME}/local/adt-bundle-mac-x86_64-20140321"
if [[ -d "$ADT_BUNDLE_PATH" ]]
then
  export PATH="${ADT_BUNDLE_PATH}/sdk/tools:${PATH}"
  export PATH="${ADT_BUNDLE_PATH}/sdk/platform-tools:${PATH}"
  export ANDROID_BIN="${ADT_BUNDLE_PATH}/sdk/tools/android"
fi

PATH=/usr/sbin:/sbin:/usr/local/bin:$PATH


if [[ -d "${HOME}/.rbenv" ]]
then
  PATH="${HOME}/.rbenv/bin:${HOME}/.rbenv/shims:${PATH}"
  eval "$(rbenv init -)"
fi

if [[ -d "/Applications/CMake.app/Contents/bin" ]]
then
  PATH="/Applications/CMake.app/Contents/bin:${PATH}"
fi

if [[ -d "${HOME}/go" ]]
then
  PATH="${HOME}/go/bin:${PATH}"
fi

if [[ -d "/usr/local/opt/python/libexec/bin" ]]; then
  PATH="/usr/local/opt/python/libexec/bin:${PATH}"
fi

if [[ -e "${HOME}/.cargo/env" ]]; then
  source $HOME/.cargo/env
fi

if hash pyenv
then
  PATH="$(pyenv root)/shims:${PATH}"
  eval "$(pyenv init -)"
fi

export PATH

# Load zsh modules
autoload -U zargs
autoload -U zcalc
autoload -U vcs_info
autoload -U add-zsh-hook
autoload -z edit-command-line

# Load compleation system
autoload -U compinit && compinit
autoload -U bashcompinit
zstyle ':completion:*' menu select
zstyle ':completion:*' menu select=20
setopt menu_complete

if [[ -e /usr/local/share/zsh/site-functions/aws_zsh_completer.sh ]];
then
  source /usr/local/share/zsh/site-functions/aws_zsh_completer.sh
fi

zle -N edit-command-line

if [[ -e /usr/local/bin/virtualenvwrapper.sh ]]
then
  export WORKON_HOME=$HOME/Code/.virtualenvs
  export PROJECT_HOME=$HOME/Code/Projects
  export VIRTUALENVWRAPPER_PYTHON=python
  source /usr/local/bin/virtualenvwrapper.sh
  compdef '_files -W $WORKON_HOME -/' workon
fi


# Load my functions
fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)
. ~/.zsh/functions/p
. ~/.zsh/functions/s
. ~/.zsh/functions/d

add-zsh-hook chpwd vcs_root_hook

# Add hook for calling vcs_info before each command.
add-zsh-hook precmd vcs_info

# # Set vcs_info parameters.
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*:*' check-for-changes true # Can be slow on big repos.
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'
zstyle ':vcs_info:*:*' actionformats "%S" "%b%m%u%c (%a)"
zstyle ':vcs_info:*:*' formats "%S" "%b%m%u%c "
zstyle ':vcs_info:*:*' nvcsformats "%~" ""

# Watch all user except me
watch=notme
LOGCHECK=0

# Use vi mode but restore some sane emacs commands.
bindkey -v
bindkey -M viins '^a' beginning-of-line
bindkey -M viins '^e' end-of-line
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

bindkey "[C" forward-word
bindkey "[D" backward-word
bindkey "^X^E" edit-command-line

# fixa backspace på solaris tangentbord
bindkey '^?' backward-delete-char
# Set required options.
setopt promptsubst

# Load colors
spectrum

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

# Language
UTF8=sv_SE.UTF-8
export LANG=$UTF8
export LC_ALL=$UTF8
export LC_LANG=$UTF8
export LC_CTYPE=$UTF8
export LANGUAGE=$UTF8

# Use vim as editor if it exists
if [[ -x $(which vim) ]]
then
  export EDITOR="vim"
  export USE_EDITOR=$EDITOR
  export VISUAL=$EDITOR
fi

# History file settings
export HISTIGNORE="&:ls:[bf]g:reset:clear:cd:cd .."
export HISTSIZE=25000
export HISTFILE=~/.zsh_history
export SAVEHIST=5000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# Report time of command if it took longer than 30 seconds
export REPORTTIME=30

# Promts for confirmation after 'rm *'
setopt RM_STAR_WAIT

# Enable color support of ls
if [[ "$TERM" != "dumb" ]]
then
  if [[ -x `which dircolors` ]]
  then
    eval `dircolors -b`
    alias 'ls=ls --color=auto'
  fi
fi

export CLICOLOR=1

### Added by the Heroku Toolbelt
if [[ -d "$HOME/local/bin" ]]
then
  export PATH="/usr/local/heroku/bin:$PATH"
fi

# Alias
alias tree_diff=diff -Naur
alias ta="tmux a"
alias ts="tmux list-sessions"
alias be="bundle exec"
alias bi="bundle install"
alias c="bundle console"
alias pd="pushd"
alias pop="popd"
alias rtags="ctags -R --languages=ruby --exclude=.git --exclude=log . \$(bundle list --paths)"
alias gd="git diff"
alias gdc="git diff --cached"
alias ra="./bin/rake"
alias rt="./bin/rake test"
alias de="docker exec -it \$(docker ps -l -q) bash"

if [ -e ~/.ssh-agent-pid ] && ps -p $(cat ~/.ssh-agent-pid) > /dev/null
then
  export SSH_AGENT_PID=$(cat ~/.ssh-agent-pid)
  export SSH_AUTH_SOCK=$(cat ~/.ssh-agent-socket)
else
  eval $(ssh-agent -s) > /dev/null
  echo $SSH_AGENT_PID > ~/.ssh-agent-pid
  echo $SSH_AUTH_SOCK > ~/.ssh-agent-socket
fi

# Source local file if exists
if [[ -e "$HOME/.zshrc.local" ]]
then
  source $HOME/.zshrc.local
fi

export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
