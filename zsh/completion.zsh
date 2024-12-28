function _fzf_complete_git() {
  ARGS="$@"
  local branches
  branches="$(git branch -vv | grep -v "*")"
  if [[ $ARGS == "git sw"* ]]; then
    _fzf_complete "--reverse --multi" "$@" < <(
      echo "${branches}"
    )
  else
    eval "zle ${fzf_default_completion:-expand-or-complete}"
  fi
}

function _fzf_complete_git_post() {
  awk '{print $1}'
}

function _fzf_complete_gh() {
  ARGS="$@"
  local pull_requests
  pull_requests="$(gh pr list)"
  if [[ $ARGS == "gh pr checkout"* || $ARGS == "gh sw"* ]]; then
    _fzf_complete "--reverse --multi" "$@" < <(
      echo "${pull_requests}"
    )
  else
    eval "zle ${fzf_default_completion:-expand-or-complete}"
  fi
}

function _fzf_complete_gh_post() {
  awk '{gsub("#", ""); print $1}'
}
