# Define color palette
RED="%{$fg[red]%}"
GREEN="%{$fg[green]%}"
YELLOW="%{$fg[yellow]%}"
BLUE="%{$fg[blue]%}"
MAGENTA="%{$fg[magenta]%}"
CYAN="%{$fg[cyan]%}"
GRAY="%F{8}"
RESET="%{$reset_color%}"
  
local return_code="%(?..${RED}%? ↵${RESET})"
local user_host="%B%(!.${RED}.${CYAN})%n@%m${RESET} "
local user_symbol='%(!.💀.😺)'
local current_dir="%B${BLUE}%~ ${RESET}"

local vcs_branch='$(git_prompt_info)$(hg_prompt_info)'
local venv_prompt='$(virtualenv_prompt_info)'

# Kubernetes shit
if [[ "${plugins[@]}" =~ 'kube-ps1' ]]; then
  local kube_prompt='$(kube_ps1)'
else
  local kube_prompt=''
fi

# Prompt
PROMPT="╭─${user_host}${current_dir}${vcs_branch}${venv_prompt}${kube_prompt}
╰─%B${user_symbol}%b "
RPROMPT="%B${return_code}%b"

ZSH_THEME_GIT_PROMPT_PREFIX="%{\e[3m%}${GRAY}["
ZSH_THEME_GIT_PROMPT_SUFFIX="] %{\e[0m%}%f${RESET}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{\e[3m%}${RED} S ${GRAY}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{\e[3m%}${YELLOW}"

ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="${GREEN}‹"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="› ${RESET}"
ZSH_THEME_VIRTUALENV_PREFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX"
ZSH_THEME_VIRTUALENV_SUFFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX"
