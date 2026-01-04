# ╭── 𖹭 NAMESPACE 𖹭 ───────────────────────────────────────────────────────────────────────────────
# │
# ✦ ─ Color & formatting ──────────────────────────────────────────────────────────────────────────

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

# ✦ ─ Local variables ─────────────────────────────────────────────────────────────────────────────

local return_code="%(?..${RED}%? ❰ ${RESET_C})"
local user_host="%B%(!.${RED}.${CYAN})%n${WHITE}‧%(!.${RED}.${CYAN})%m${RESET_C} "
local user_symbol='%(?.$(random_emoji).💥)'
local current_dir="%B${BLUE}%~ ${RESET_C}"

local vcs_branch='$(git_prompt_info)'
local venv_prompt='$(virtualenv_prompt_info)'

# ╭── 𖹭 EMOJI 𖹭 ───────────────────────────────────────────────────────────────────────────────────
# │
# ✦ ─ Emoji sets ──────────────────────────────────────────────────────────────────────────────────

EMOJI_DEFAULT=(💩 🐦 🚀 🍕 👽 ☕️ 🔬 💀 🐷 🐧 🐳 🍔 🍣 🍻 🔮 💰 💎 💾 🍪 🌞 🐌 🍄 )
EMOJI_XMAS=(🎄 🎅 🎇 🎉 🍾 🎁 🦌 ☃️ 🛷 🍫 🥂 ❄️ 🧣 🍪 ⛸️ 🎀 )
EMOJI_CHINESE_NY=(🐲 🧧 🥮 🐉 🍊 🥠 🪭 🎆 🫖 🥟 🏮 )
EMOJI_SHUNBUN_NO_HI=(🌸 )
EMOJI_NOWRUZ=(🌷 🌱 🪻 ☀️ 🕌 💚 🐫 )
EMOJI_SONGKRAN=(🐘 🔫 🌊 🏵️ 🙏 🧡 🛵 💦 )
EMOJI_HALLOWEEN=(🎃 👻 🍬 🕸️ 🦇 💀 🍷 ⚰️ 🍂 🕷️ 🪦 🕯️ 🧟 )
EMOJI_BUNKA_NO_HI=(🎎 🎐 🍙 🍡 🍣 🍶 🍥 🗼 🍢 💮 🍘 🥢 🍤 🍵 🎏 👘 ⛩️ )

# ✦ ─ Holiday checks ──────────────────────────────────────────────────────────────────────────────

function is_xmas_season() {
  local current_date
  current_date=10#$(date +%m%d)

  # Dec 18 → 12.18
  # Jan 7  → 1.07
  (( current_date >= 1218 || current_date <= 107 ))
}

function is_chinese_new_year() {
  local current_year
  local current_date
  current_year=$(date +%Y)
  current_date=10#$(date +%m%d)

  local eve
  local end

  case $current_year in
    2026)
      # Feb 17 → 2.17
      eve=217
      # Mar 3 → 3.03
      end=303
      # etc.
      ;;
    2027)
      eve=206
      end=220
      ;;
    2028)
      eve=126
      end=209
      ;;
    *)
      return 1
      ;;
  esac

  (( current_date >= eve && current_date <= end ))
}

function is_vernal_equinox() {
  local current_date
  current_date=10#$(date +%m%d)

  # Mar 20 → 3.20
  (( current_date == 320))
}

function is_nowruz() {
  local current_date
  current_date=10#$(date +%m%d)

  # Mar 21 → 3.21
  # Mar 23 → 3.23
  (( current_date >= 321 && current_date <= 323 ))
}

function is_songkran() {
  local current_date
  current_date=10#$(date +%m%d)

  # Apr 13 → 4.13
  # Apr 15 → 4.15
  (( current_date >= 413 && current_date <= 415 ))
}

function is_halloween() {
  local current_date
  current_date=10#$(date +%m%d)

  # Oct 24 → 10.24
  # Oct 31 → 10.31
  (( current_date >= 1024 && current_date <= 1031 ))
}

function is_japanese_culture_day() {
  local current_date
  current_date=10#$(date +%m%d)

  # Nov 3 → 11.03
  (( current_date == 1103 ))
}

# ✦ ─ Randomizer ──────────────────────────────────────────────────────────────────────────────────

random_from_array() {
  local name=$1
  local -a arr
  arr=( "${(@P)name}" )
  echo -n "${arr[RANDOM % ${#arr[@]} + 1]}"
}

# ✦ ─ Emoji print ─────────────────────────────────────────────────────────────────────────────────

function random_emoji() {
  if is_xmas_season; then
    random_from_array EMOJI_XMAS
  elif is_vernal_equinox; then
    random_from_array EMOJI_SHUNBUN_NO_HI
  elif is_nowruz; then
    random_from_array EMOJI_NOWRUZ
  elif is_songkran; then
    random_from_array EMOJI_SONGKRAN
  elif is_halloween; then
    random_from_array EMOJI_HALLOWEEN
  elif is_japanese_culture_day; then
    random_from_array EMOJI_BUNKA_NO_HI
  else
    random_from_array EMOJI_DEFAULT
  fi
}

# ╭── 𖹭 EXTRA 𖹭 ───────────────────────────────────────────────────────────────────────────────────
# │
# ✦ ─ Kubernetes shit

if [[ "${plugins[@]}" =~ 'kube-ps1' ]]; then
  local kube_prompt='$(kube_ps1)'
else
  local kube_prompt=''
fi

# ╭── 𖹭 PROMPT 𖹭 ──────────────────────────────────────────────────────────────────────────────────
# │
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
