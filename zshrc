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


if [[ -d "${HOME}/.rbenv" ]]
then
  PATH="${HOME}/.rbenv/bin:${HOME}/.rbenv/shims:${PATH}"
  eval "$(rbenv init -)"
fi

PATH=$PATH:/usr/sbin:/sbin:/usr/local/bin
export PATH

# Load zsh modules
autoload -U zargs
autoload -U zcalc
autoload -U vcs_info
autoload -U add-zsh-hook

# Load compleation system
autoload -U compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' menu select=20
setopt menu_complete

# Load my functions
fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

add-zsh-hook chpwd vcs_root_hook

# Add hook for calling vcs_info before each command.
add-zsh-hook precmd vcs_info

# # Set vcs_info parameters.
zstyle ':vcs_info:*' enable hg bzr git
zstyle ':vcs_info:*:*' check-for-changes true # Can be slow on big repos.
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'
zstyle ':vcs_info:*:*' actionformats "%S" "%r/%s/%b %u%c (%a)"
zstyle ':vcs_info:*:*' formats "%S" "%r/%s/%b %u%c"
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
PROMPT_VCS_INFO_COLOR=$FG[242]

# Define prompts.
PROMPT="%(0?.%{$PROMPT_SUCCESS_COLOR%}.%{$PROMPT_FAILURE_COLOR%})${SSH_TTY:+[%n@%m]}%{$FX[bold]%}%$PROMPT_PATH_MAX_LENGTH<..<"'${vcs_info_msg_0_%%.}'"%<<%(!.$PROMPT_ROOT_END.$PROMPT_DEFAULT_END)%{$FX[no-bold]%}%{$FX[reset]%} "
RPROMPT="%{$PROMPT_VCS_INFO_COLOR%}"'$vcs_info_msg_1_'"%{$FX[reset]%}"

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
