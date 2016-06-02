#!/usr/bin/env bash

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWSTASHSTATE=true

# Emoji-based theme to display source control management and
# virtual environment info beside the ordinary bash prompt.

# Theme inspired by:
#  - Naming your Terminal tabs in OSX Lion - http://thelucid.com/2012/01/04/naming-your-terminal-tabs-in-osx-lion/
#  - Bash_it sexy theme


# virtualenv prompts
VIRTUALENV_CHAR="ⓔ "
VIRTUALENV_THEME_PROMPT_PREFIX=""
VIRTUALENV_THEME_PROMPT_SUFFIX=""

# SCM prompts
SCM_NONE_CHAR=""
SCM_GIT_CHAR="[±] "
SCM_GIT_BEHIND_CHAR="${red}↓${white}"
SCM_GIT_AHEAD_CHAR="${green}↑${white}"
SCM_GIT_UNTRACKED_CHAR="${green}⌀${white}"
SCM_GIT_UNSTAGED_CHAR="${green}•${white}"
SCM_GIT_STAGED_CHAR="${yellow}+${white}"

SCM_THEME_PROMPT_DIRTY=""
SCM_THEME_PROMPT_CLEAN=""
SCM_THEME_PROMPT_PREFIX=""
SCM_THEME_PROMPT_SUFFIX=""

# Git status prompts
GIT_THEME_PROMPT_DIRTY=" ${red}✗${normal}"
GIT_THEME_PROMPT_CLEAN=" ${green}✓${normal}"
GIT_THEME_PROMPT_PREFIX=""
GIT_THEME_PROMPT_SUFFIX=""

# ICONS =======================================================================

icon_start="${white}┌${normal}"
icon_user=""
icon_host=" @ "
icon_directory=" in "
icon_branch=""
icon_end="${white}└❯ ${normal}"

# extra spaces ensure legiblity in prompt

# FUNCTIONS ===================================================================

# Display virtual environment info
function virtualenv_prompt {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    virtualenv=`basename "$VIRTUAL_ENV"`
    echo -e "$VIRTUALENV_CHAR$virtualenv "
  fi
}

# Rename tab
function tabname {
  printf "\e]1;$1\a"
}

# Rename window
function winname {
  printf "\e]2;$1\a"
}


export LS_COLORS="no=00:fi=37:di=34:ow=7;34:ln=36:pi=33:so=35:do=35:bd=01:cd=01:or=01:ex=32:*.tar=31:*.tgz=31:*.arj=31:*.taz=31:*.lzh=31:*.zip=31:*.z=31:*.Z=31:*.gz=31:*.bz2=31:*.deb=31:*.rpm=31:*.jar=31:*.jpg=35:*.jpeg=35:*.gif=35:*.svg=31:*.bmp=35:*.pbm=35:*.pgm=35:*.ppm=35:*.tga=35:*.xbm=35:*.xpm=35:*.tif=35:*.tiff=35:*.png=35:*.mov=35:*.mpg=35:*.mpeg=35:*.avi=35:*.fli=35:*.gl=35:*.dl=35:*.xcf=35:*.xwd=35:*.ogg=35:*.mp3=35:*.wav=35:*.css=33:*.html=32:*.htm=32:*.json=33"

export PROMPT_DIRTRIM=3

function prompt_command() {
    PS1="\n${icon_start} ${white}\t${normal} | $(virtualenv_prompt)${blue}\u${normal}${icon_host}${cyan}\h${normal}${icon_directory}${green}\w${normal}\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on ${icon_branch}\")${red}$(scm_prompt_info)${normal}\n${icon_end}${red}\$ ${yellow}"
    PS2="${normal}${icon_end}"
}

preexec () { :; }
preexec_invoke_exec () {
    [ -n "$COMP_LINE" ] && return  # do nothing if completing
    [ "$BASH_COMMAND" = "$PROMPT_COMMAND" ] && return # don't cause a preexec for $PROMPT_COMMAND
    local this_command=`HISTTIMEFORMAT= history 1 | sed -e "s/^[ ]*[0-9]*[ ]*//"`;
    preexec "$this_command"
}
trap '[[ -t 1 ]] && tput sgr0' DEBUG

PROMPT_COMMAND=prompt_command;
