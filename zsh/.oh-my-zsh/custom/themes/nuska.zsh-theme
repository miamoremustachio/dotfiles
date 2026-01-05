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

CURRENT_YEAR=$(date +%Y)
CURRENT_DATE=10#$(date +%m%d)

# ✦ ─ Local variables ─────────────────────────────────────────────────────────────────────────────

local return_code="%(?..${RED}%? ❰ ${RESET_C})"
local user_host="%B%(!.${RED}.${CYAN})%n${WHITE}‧%(!.${RED}.${CYAN})%m${RESET_C} "
local user_symbol='%(?.$(get_emoji).${EMOJI_FAIL})'
local current_dir="%B${BLUE}%~ ${RESET_C}"

local vcs_branch='$(git_prompt_info)'
local venv_prompt='$(virtualenv_prompt_info)'

# ╭── 𖹭 EMOJI 𖹭 ───────────────────────────────────────────────────────────────────────────────────
# │
# ✦ ─ Emoji sets ──────────────────────────────────────────────────────────────────────────────────

EMOJI_DEFAULT=(🐦 🍕 👽 ☕️ 🐧 🔮 💎 💾 🐌 🍄 )
EMOJI_FAIL="💥"
EMOJI_XMAS=(🎄 🎅 🎇 🎉 🍾 🎁 🦌 ☃️ 🛷 🥂 ❄️ 🧣 🍪 ⛸️ 🎀 )
EMOJI_EDUCATION=(🎓 📖 📚 )
EMOJI_AUSTRALIA=(🦘 🇦🇺 🐨 🐊 🕷️ 🍺 🏄 🪃 🌊 )
EMOJI_CANDLE=(🕯️ )
EMOJI_RADIO=(📻 🎙️ 🎧 )
EMOJI_LOVE=(💘 💞 💕 💝 💖 💌 )
EMOJI_CHINESE_NY=(🐲 🧧 🥮 🐉 🍊 🥠 🪭 🎆 🫖 🥟 🏮 )
EMOJI_FEMALE=(♀️ )
EMOJI_ST_PATRICK=(🍻 ☘️ 💚 🍀 🪉 🇮🇪 )
EMOJI_SAKURA=(🌸 )
EMOJI_NOWRUZ=(🌷 🌱 🪻 ☀️ 🕌 🍏 🐫 )
EMOJI_ZERO_WASTE=(♻️ )
EMOJI_AUTISM=(♾️ 🧩 🌈 )
EMOJI_SPACE=(🚀 🪐 🛸 🌜 🛰️ 📡 💫 🔭 ☄️ )
EMOJI_SONGKRAN=(🐘 🔫 🏵️ 🧡 🛵 💦 )
EMOJI_EARTH=(🌍 🌎 🌏 )
EMOJI_EASTER=(🥚 🪺 ⛪ 🩷 🐝 🐇 🎗️ 🐣 🍫 🥕 🌼 🔔 🧺 )
EMOJI_JAZZ=(🎷 🪊 🎹 🥁 🎼 )
EMOJI_MEXICO=(🌮 🇲🇽 💃 🥑 🌵 🌶️ 🪅 )
EMOJI_VICTORY=(🎖️ 🪖 ✌️ )
EMOJI_FOOTBALL=(⚽ )
EMOJI_POTATO=(🥔 🍠 🍟 )
EMOJI_ITALY=(🍕 🍝 🇮🇹 🏛️ 🤌 )
EMOJI_CANADA=(🍁 🦫 🥞 🇨🇦 🏒 🥌 )
EMOJI_USA=(🗽 🌭 🇺🇸 🎺 🍔 🥜 🦅 📜 🏈 )
EMOJI_FRANCE=(🥖 🍷 🇫🇷 📽️ 🥐 🏰 🎈 )
EMOJI_LABOR=(🦺 ⛑️ 💼 ⛏️ ⚒️ 🛠️ 🔧 🧰 🔬 )
EMOJI_POST=(✉️ 📯 📮 🏣 📫 📪 📬 📭 📨 )
EMOJI_UN=(🇺🇳 )
EMOJI_HALLOWEEN=(🎃 👻 🍬 🕸️ 🦇 💀 🍷 ⚰️ 🕷️ 🪦 🧟 )
EMOJI_JAPAN=(🎎 🎐 🍙 🍡 🍣 🍶 🍥 🗼 🍢 💮 🍘 🥢 🍤 🍵 🎏 👘 ⛩️ )
EMOJI_TOILET=(🚽 🧻 💩 )
EMOJI_THANKSGIVING=(🦃 🌰 🍗 🌽 🕯️ 🍄‍🟫 🙏 🍂 🥧 )
EMOJI_BASKETBALL=(🏀 )

# ✦ ─ Holiday checks ──────────────────────────────────────────────────────────────────────────────

function is_xmas_season() {
  # Dec 23 → 12.23
  # Jan 7  → 1.07
  (( CURRENT_DATE >= 1223 || CURRENT_DATE <= 107 ))
}

function is_education_day() {
  # Jan 24 → 1.24
  (( CURRENT_DATE == 124 ))
}

function is_australia_day() {
  # Jan 26 → 1.26
  (( CURRENT_DATE == 126 ))
}

function is_holocaust_remembrance_day() {
  # Jan 27 → 1.27
  (( CURRENT_DATE == 127 ))
}

function is_radio_day() {
  # Feb 13 → 2.13
  (( CURRENT_DATE == 213 ))
}

function is_valentine_day() {
  # Feb 14 → 2.14
  (( CURRENT_DATE == 214 ))
}

function is_chinese_new_year() {
  local eve
  local end

  case $CURRENT_YEAR in
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

  (( CURRENT_DATE >= eve && CURRENT_DATE <= end ))
}

function is_women_day() {
  # Mar 8 → 3.08
  (( CURRENT_DATE == 308 ))
}

function is_saint_patrick_day() {
  # Mar 17 → 3.17
  (( CURRENT_DATE == 317 ))
}

function is_vernal_equinox() {
  # Mar 20 → 3.20
  (( CURRENT_DATE == 320 ))
}

function is_nowruz() {
  # Mar 21 → 3.21
  # Mar 23 → 3.23
  (( CURRENT_DATE >= 321 && CURRENT_DATE <= 323 ))
}

function is_zero_waste_day() {
  # Mar 30 → 3.30
  (( CURRENT_DATE == 330 ))
}

function is_autism_awareness_day() {
  # Apr 2 → 4.02
  (( CURRENT_DATE == 402 ))
}

function is_human_space_flight_day() {
  # Apr 12 → 4.12
  (( CURRENT_DATE == 412 ))
}

function is_songkran() {
  # Apr 13 → 4.13
  # Apr 15 → 4.15
  (( CURRENT_DATE >= 413 && CURRENT_DATE <= 415 ))
}

function is_earth_day() {
  # Apr 22 → 4.22
  (( CURRENT_DATE == 422 ))
}

function is_easter() {
  local eve
  local end

  case $CURRENT_YEAR in
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

  (( CURRENT_DATE >= eve && CURRENT_DATE <= end ))
}

function is_jazz_day() {
  # Apr 30 → 4.30
  (( CURRENT_DATE == 430 ))
}

function is_cinco_de_mayo() {
  # May 5 → 5.05
  (( CURRENT_DATE == 505 ))
}

function is_victory_day() {
  # May 8 → 5.08
  # May 9 → 5.09
  (( CURRENT_DATE >= 508 && CURRENT_DATE <= 509 ))
}

function is_football_day() {
  # May 25 → 5.25
  (( CURRENT_DATE == 525 ))
}

function is_potato_day() {
  # May 30 → 5.30
  (( CURRENT_DATE == 530 ))
}

function is_italian_national_day() {
  # Jun 2 → 6.02
  (( CURRENT_DATE == 602 ))
}

function is_canada_day() {
  # Jul 1 → 7.01
  (( CURRENT_DATE == 701 ))
}

function is_july_4th() {
  # Jul 4 → 7.04
  (( CURRENT_DATE == 704 ))
}

function is_bastille_day() {
  # Jul 14 → 7.14
  (( CURRENT_DATE == 714 ))
}

function is_labor_day() {
  local day month weekday

  day=10#$(date +%d)
  month=10#$(date +%m)
  weekday=$(date +%u) # Monday → 1 <...> Sunday → 7

  (( weekday == 1 && month == 9 && day <= 7 ))
}

function is_world_post_day() {
  # Oct 9 → 10.09
  (( CURRENT_DATE == 1009 ))
}

function is_united_nations_day() {
  # Oct 24 → 10.24
  (( CURRENT_DATE == 1024 ))
}

function is_halloween() {
  # Oct 25 → 10.25
  # Oct 31 → 10.31
  (( CURRENT_DATE >= 1025 && CURRENT_DATE <= 1031 ))
}

function is_japanese_culture_day() {
  # Nov 3 → 11.03
  (( CURRENT_DATE == 1103 ))
}

function is_toilet_day() {
  # Nov 19 → 11.19
  (( CURRENT_DATE == 1119 ))
}

function is_thanksgiving_season() {
  local thanksgiving today diff

  # Find Thanksgiving:

  # 1) Get the ISO weekday number of Nov 1
  local nov_1st_weekday=$(date -d "$CURRENT_YEAR-11-01" +%u)

  # 2) Calculate the number of days to the first Thursday
  local days_to_first_thursday=$(( (4 - $nov_1st_weekday + 7) % 7 ))

  # 3) Add 3 weeks (21 days) to first Thursday
  local days_to_thanksgiving=$(( $days_to_first_thursday + 21 ))

  # 4) Get Thanksgiving & current timestamps
  thanksgiving=$(date -d "$CURRENT_YEAR-11-01 +$days_to_thanksgiving days" +%s)  
  today=$(date +%s)

  # Diggerence from today to Thanksgiving (in days)
  # 86400 → seconds in a day
  diff=$(( (thanksgiving - today) / 86400 ))

  (( diff >= 0 && diff <= 7 ))
}

function is_basketball_day() {
  # Dec 21 → 12.21
  (( CURRENT_DATE == 1221 ))
}

# ✦ ─ Randomizer ──────────────────────────────────────────────────────────────────────────────────

random_from_array() {
  local name=$1
  local -a arr
  arr=( "${(@P)name}" )
  echo -n "${arr[RANDOM % ${#arr[@]} + 1]}"
}

# ✦ ─ Pick the right set ──────────────────────────────────────────────────────────────────────────

function get_emoji() {
  if is_xmas_season; then
    random_from_array EMOJI_XMAS
  elif is_education_day; then
    random_from_array EMOJI_EDUCATION
  elif is_australia_day; then
    random_from_array EMOJI_AUSTRALIA
  elif is_holocaust_remembrance_day; then
    random_from_array EMOJI_CANDLE
  elif is_radio_day; then
    random_from_array EMOJI_RADIO
  elif is_valentine_day; then
    random_from_array EMOJI_LOVE
  elif is_chinese_new_year; then
    random_from_array EMOJI_CHINESE_NY
  elif is_women_day; then
    random_from_array EMOJI_FEMALE
  elif is_saint_patrick_day; then
    random_from_array EMOJI_ST_PATRICK
  elif is_vernal_equinox; then
    random_from_array EMOJI_SAKURA
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
    random_from_array EMOJI_EARTH
  elif is_easter; then
    random_from_array EMOJI_EASTER
  elif is_jazz_day; then
    random_from_array EMOJI_JAZZ
  elif is_cinco_de_mayo; then
    random_from_array EMOJI_MEXICO
  elif is_victory_day; then
    random_from_array EMOJI_VICTORY
  elif is_football_day; then
    random_from_array EMOJI_FOOTBALL
  elif is_potato_day; then
    random_from_array EMOJI_POTATO
  elif is_italian_national_day; then
    random_from_array EMOJI_ITALY
  elif is_canada_day; then
    random_from_array EMOJI_CANADA
  elif is_july_4th; then
    random_from_array EMOJI_USA
  elif is_bastille_day; then
    random_from_array EMOJI_FRANCE
  elif is_labor_day; then
   random_from_array EMOJI_LABOR
  elif is_world_post_day; then
    random_from_array EMOJI_POST
  elif is_united_nations_day; then
    random_from_array EMOJI_UN
  elif is_halloween; then
    random_from_array EMOJI_HALLOWEEN
  elif is_japanese_culture_day; then
    random_from_array EMOJI_JAPAN
  elif is_toilet_day; then
    random_from_array EMOJI_TOILET
  elif is_thanksgiving_season; then
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
