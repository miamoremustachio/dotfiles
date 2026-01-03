# Color & formatting
RED="%{$fg[red]%}"
GREEN="%{$fg[green]%}"
YELLOW="%{$fg[yellow]%}"
BLUE="%{$fg[blue]%}"
MAGENTA="%{$fg[magenta]%}"
CYAN="%{$fg[cyan]%}"
WHITE="%{$fg[white]%}"
GRAY="%F{8}"

ITALIC="%{\e[3m%}"
RESET_I="%{\e[0m%}"
RESET_C="%{$reset_color%}"

# Local variables
local return_code="%(?..${RED}%? ❰ ${RESET_C})"
local user_host="%B%(!.${RED}.${CYAN})%n${WHITE}•%(!.${RED}.${CYAN})%m${RESET_C} "
local user_symbol='%(?.$(random_emoji).💥)'
local current_dir="%B${BLUE}%~ ${RESET_C}"

local vcs_branch='$(git_prompt_info)'
local venv_prompt='$(virtualenv_prompt_info)'

# Emoji set
EMOJI=(💩 🐦 🚀 🎨 🍕 👽 ☕️ 🔬 💀 🐷 🐧 🐳 🍔 🍣 🍻 🔮 💰 💎 💾 🍪 🌞 🐌 🍄 )

function random_emoji {
  echo -n "$EMOJI[$RANDOM%$#EMOJI+1]"
}

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

ZSH_THEME_GIT_PROMPT_PREFIX="${GRAY}✦ ${ITALIC}"
ZSH_THEME_GIT_PROMPT_SUFFIX=" ${RESET_I}%f${RESET_C}"
ZSH_THEME_GIT_PROMPT_DIRTY="${RESET_I}${RED} ❤︎ ${GRAY}"
ZSH_THEME_GIT_PROMPT_CLEAN="${RESET_I}${GREEN} ☘︎ ${GRAY}"

ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX="${GREEN}‹"
ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX="› ${RESET_C}"
ZSH_THEME_VIRTUALENV_PREFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_PREFIX"
ZSH_THEME_VIRTUALENV_SUFFIX="$ZSH_THEME_VIRTUAL_ENV_PROMPT_SUFFIX"
