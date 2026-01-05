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
local user_symbol='%(?.$(random_emoji).${EMOJI_FAIL})'
local current_dir="%B${BLUE}%~ ${RESET_C}"

local vcs_branch='$(git_prompt_info)'
local venv_prompt='$(virtualenv_prompt_info)'

# ╭── 𖹭 EMOJI 𖹭 ───────────────────────────────────────────────────────────────────────────────────
# │
# ✦ ─ Emoji sets ──────────────────────────────────────────────────────────────────────────────────

EMOJI_DEFAULT=(🐦 🍕 👽 ☕️ 🐧 🔮 💎 💾 🐌 🍄 )
EMOJI_FAIL='💥'
EMOJI_XMAS=(🎄 🎅 🎇 🎉 🍾 🎁 🦌 ☃️ 🛷 🥂 ❄️ 🧣 🍪 ⛸️ 🎀 )
EMOJI_EDUCATION_DAY=(🎓 📖 📚 )
EMOJI_AUSTRALIA_DAY=(🦘 🇦🇺 🐨 🐊 🕷️ 🍺 🏄 🪃 🌊 )
EMOJI_CANDLE=(🕯️ )
EMOJI_RADIO_DAY=(📻 🎙️ 🎧 )
EMOJI_VALENTINE_DAY=(💘 💞 💕 💝 💖 💌 )
EMOJI_CHINESE_NY=(🐲 🧧 🥮 🐉 🍊 🥠 🪭 🎆 🫖 🥟 🏮 )
EMOJI_WOMEN_DAY=(♀️ )
EMOJI_ST_PATRICK=(🍻 ☘️ 💚 🍀 🪉 🇮🇪 )
EMOJI_SHUNBUN_NO_HI=(🌸 )
EMOJI_NOWRUZ=(🌷 🌱 🪻 ☀️ 🕌 🍏 🐫 )
EMOJI_ZERO_WASTE=(♻️ )
EMOJI_AUTISM=(♾️ 🧩 🌈 )
EMOJI_SPACE=(🚀 🪐 🛸 🌜 🛰️ 📡 💫 🔭 ☄️ )
EMOJI_SONGKRAN=(🐘 🔫 🏵️ 🧡 🛵 💦 )
EMOJI_EARTH_DAY=(🌍 🌎 🌏 )
EMOJI_EASTER=(🥚 🪺 ⛪ 🩷 🐝 🐇 🎗️ 🐣 🍫 🥕 🌼 🔔 🧺 )
EMOJI_JAZZ=(🎷 🪊 🎹 🥁 🎼 )
EMOJI_CINCO_DE_MAYO=(🌮 🇲🇽 💃 🥑 🌵 🌶️ 🪅 )
EMOJI_VICTORY_DAY=(🎖️ 🪖 ✌️ )
EMOJI_FOOTBALL=(⚽ )
EMOJI_POTATO=(🥔 🍠 🍟 )
EMOJI_FESTA_DELLA_REPUBBLICA=(🍕 🍝 🇮🇹 🏛️ 🤌 )
EMOJI_CANADA_DAY=(🍁 🦫 🥞 🇨🇦 🏒 🥌 )
EMOJI_INDEPENDENCE_DAY=(🗽 🌭 🇺🇸 🎺 🍔 🥜 🦅 📜 🏈 )
EMOJI_BASTILLE_DAY=(🥖 🍷 🇫🇷 📽️ 🥐 🏰 🎈 )
EMOJI_LABOR_DAY=(🦺 ⛑️ 💼 ⛏️ ⚒️ 🛠️ 🔧 🧰 🔬 )
EMOJI_POST=(✉️ 📯 📮 🏣 📫 📪 📬 📭 📨 )
EMOJI_UN_DAY=(🇺🇳 )
EMOJI_HALLOWEEN=(🎃 👻 🍬 🕸️ 🦇 💀 🍷 ⚰️ 🕷️ 🪦 🧟 )
EMOJI_BUNKA_NO_HI=(🎎 🎐 🍙 🍡 🍣 🍶 🍥 🗼 🍢 💮 🍘 🥢 🍤 🍵 🎏 👘 ⛩️ )
EMOJI_TOILET_DAY=(🚽 🧻 💩 )
EMOJI_THANKSGIVING=(🦃 🌰 🍗 🌽 🕯️ 🍄‍🟫 🙏 🍂 🥧 )
EMOJI_BASKETBALL=(🏀 )

# ✦ ─ Holiday checks ──────────────────────────────────────────────────────────────────────────────

function is_xmas_season() {
  local current_date
  current_date=10#$(date +%m%d)

  # Dec 23 → 12.23
  # Jan 7  → 1.07
  (( current_date >= 1223 || current_date <= 107 ))
}

function is_education_day() {
  local current_date
  current_date=10#$(date +%m%d)

  # Jan 24 → 1.24
  (( current_date == 124 ))
}

function is_australia_day() {
  local current_date
  current_date=10#$(date +%m%d)

  # Jan 26 → 1.26
  (( current_date == 126 ))
}

function is_holocaust_remembrance_day() {
  local current_date
  current_date=10#$(date +%m%d)

  # Jan 27 → 1.27
  (( current_date == 127 ))
}

function is_radio_day() {
  local current_date
  current_date=10#$(date +%m%d)

  # Feb 13 → 2.13
  (( current_date == 213 ))
}

function is_valentine_day() {
  local current_date
  current_date=10#$(date +%m%d)

  # Feb 14 → 2.14
  (( current_date == 214 ))
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

function is_women_day() {
  local current_date
  current_date=10#$(date +%m%d)

  # Mar 8 → 3.08
  (( current_date == 308 ))
}

function is_saint_patrick_day() {
  local current_date
  current_date=10#$(date +%m%d)

  # Mar 17 → 3.17
  (( current_date == 317 ))
}

function is_vernal_equinox() {
  local current_date
  current_date=10#$(date +%m%d)

  # Mar 20 → 3.20
  (( current_date == 320 ))
}

function is_nowruz() {
  local current_date
  current_date=10#$(date +%m%d)

  # Mar 21 → 3.21
  # Mar 23 → 3.23
  (( current_date >= 321 && current_date <= 323 ))
}

function is_zero_waste_day() {
  local current_date
  current_date=10#$(date +%m%d)

  # Mar 30 → 3.30
  (( current_date == 330 ))
}

function is_autism_awareness_day() {
  local current_date
  current_date=10#$(date +%m%d)

  # Apr 2 → 4.02
  (( current_date == 402 ))
}

function is_human_space_flight_day() {
  local current_date
  current_date=10#$(date +%m%d)

  # Apr 12 → 4.12
  (( current_date == 412 ))
}

function is_songkran() {
  local current_date
  current_date=10#$(date +%m%d)

  # Apr 13 → 4.13
  # Apr 15 → 4.15
  (( current_date >= 413 && current_date <= 415 ))
}

function is_earth_day() {
  local current_date
  current_date=10#$(date +%m%d)

  # Apr 22 → 4.22
  (( current_date == 422 ))
}

function is_easter() {
  local current_year
  local current_date
  current_year=$(date +%Y)
  current_date=10#$(date +%m%d)

  local eve
  local end

  case $current_year in
    2026)
      # Mar 29 → 3.29
      eve=329
      # Apr 5 → 4.05
      end=405
      # etc.
      ;;
    2027)
      eve=321
      end=328
      ;;
    2028)
      eve=409
      end=416
      ;;
    *)
      return 1
      ;;
  esac

  (( current_date >= eve && current_date <= end ))
}

function is_jazz_day() {
  local current_date
  current_date=10#$(date +%m%d)

  # Apr 30 → 4.30
  (( current_date == 430 ))
}

function is_may_5th() {
  local current_date
  current_date=10#$(date +%m%d)

  # May 5 → 5.05
  (( current_date == 505 ))
}

function is_victory_day() {
  local current_date
  current_date=10#$(date +%m%d)

  # May 8 → 5.08
  # May 9 → 5.09
  (( current_date >= 508 && current_date <= 509 ))
}

function is_football_day() {
  local current_date
  current_date=10#$(date +%m%d)

  # May 25 → 5.25
  (( current_date == 525 ))
}

function is_potato_day() {
  local current_date
  current_date=10#$(date +%m%d)

  # May 30 → 5.30
  (( current_date == 530 ))
}

function is_italian_national_day() {
  local current_date
  current_date=10#$(date +%m%d)

  # Jun 2 → 6.02
  (( current_date == 602 ))
}

function is_canada_day() {
  local current_date
  current_date=10#$(date +%m%d)

  # Jul 1 → 7.01
  (( current_date == 701 ))
}

function is_july_4th() {
  local current_date
  current_date=10#$(date +%m%d)

  # Jul 4 → 7.04
  (( current_date == 704 ))
}

function is_bastille_day() {
  local current_date
  current_date=10#$(date +%m%d)

  # Jul 14 → 7.14
  (( current_date == 714 ))
}

function is_labor_day() {
  local day
  local month
  local weekday
  day=10#$(date +%d)
  month=10#$(date +%m)
  weekday=$(date +%u) # Monday → 1 <...> Sunday → 7

  (( weekday == 1 && month == 9 && day <= 7 ))
}

function is_world_post_day() {
  local current_date
  current_date=10#$(date +%m%d)

  # Oct 9 → 10.09
  (( current_date == 1009 ))
}

function is_united_nations_day() {
  local current_date
  current_date=10#$(date +%m%d)

  # Oct 24 → 10.24
  (( current_date == 1024 ))
}

function is_halloween() {
  local current_date
  current_date=10#$(date +%m%d)

  # Oct 25 → 10.25
  # Oct 31 → 10.31
  (( current_date >= 1025 && current_date <= 1031 ))
}

function is_japanese_culture_day() {
  local current_date
  current_date=10#$(date +%m%d)

  # Nov 3 → 11.03
  (( current_date == 1103 ))
}

function is_toilet_day() {
  local current_date
  current_date=10#$(date +%m%d)

  # Nov 19 → 11.19
  (( current_date == 1119 ))
}

function is_thanksgiving() {
  local current_year
  local current_date
  current_year=$(date +%Y)
  current_date=10#$(date +%m%d)

  local eve
  local end

  case $current_year in
    2026)
      # Nov 19 → 11.19
      eve=1119
      # Nov 26 → 11.26
      end=1126
      # etc.
      ;;
    2027)
      eve=1118
      end=1125
      ;;
    2028)
      eve=1116
      end=1123
      ;;
    *)
      return 1
      ;;
  esac

  (( current_date >= eve && current_date <= end ))
}

function is_basketball_day() {
  local current_date
  current_date=10#$(date +%m%d)

  # Dec 21 → 12.21
  (( current_date == 1221 ))
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
  elif is_education_day; then
    random_from_array EMOJI_EDUCATION_DAY
  elif is_australia_day; then
    random_from_array EMOJI_AUSTRALIA_DAY
  elif is_holocaust_remembrance_day; then
    random_from_array EMOJI_CANDLE
  elif is_radio_day; then
    random_from_array EMOJI_RADIO_DAY
  elif is_valentine_day; then
    random_from_array EMOJI_VALENTINE_DAY
  elif is_chinese_new_year; then
    random_from_array EMOJI_CHINESE_NY
  elif is_women_day; then
    random_from_array EMOJI_WOMEN_DAY
  elif is_saint_patrick_day; then
    random_from_array EMOJI_ST_PATRICK
  elif is_vernal_equinox; then
    random_from_array EMOJI_SHUNBUN_NO_HI
  elif is_nowruz; then
    random_from_array EMOJI_NOWRUZ
  elif is_zero_waste_day; then
    random_from_array EMOJI_ZERO_WASTE
  elif is_autism_awareness_day; then
    random_from_array EMOJI_AUTISM
  elif is_human_space_flight_day; then
    random_from_array EMOJI_SPACE
  elif is_songkran; then
    random_from_array EMOJI_SONGKRAN
  elif is_earth_day; then
    random_from_array EMOJI_EARTH_DAY
  elif is_easter; then
    random_from_array EMOJI_EASTER
  elif is_jazz_day; then
    random_from_array EMOJI_JAZZ
  elif is_may_5th; then
    random_from_array EMOJI_CINCO_DE_MAYO
  elif is_victory_day; then
    random_from_array EMOJI_VICTORY_DAY
  elif is_football_day; then
    random_from_array EMOJI_FOOTBALL
  elif is_potato_day; then
    random_from_array EMOJI_POTATO
  elif is_italian_national_day; then
    random_from_array EMOJI_FESTA_DELLA_REPUBBLICA
  elif is_canada_day; then
    random_from_array EMOJI_CANADA_DAY
  elif is_july_4th; then
    random_from_array EMOJI_INDEPENDENCE_DAY
  elif is_bastille_day; then
    random_from_array EMOJI_BASTILLE_DAY
  elif is_labor_day; then
   random_from_array EMOJI_LABOR_DAY
  elif is_world_post_day; then
    random_from_array EMOJI_POST
  elif is_united_nations_day; then
    random_from_array EMOJI_UN_DAY
  elif is_halloween; then
    random_from_array EMOJI_HALLOWEEN
  elif is_japanese_culture_day; then
    random_from_array EMOJI_BUNKA_NO_HI
  elif is_toilet_day; then
    random_from_array EMOJI_TOILET_DAY
  elif is_thanksgiving; then
    random_from_array EMOJI_THANKSGIVING
  elif is_basketball_day; then
    random_from_array EMOJI_BASKETBALL
  else
    random_from_array EMOJI_DEFAULT
  fi
}

# ╭── 𖹭 EXTRA 𖹭 ───────────────────────────────────────────────────────────────────────────────────
# │
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
