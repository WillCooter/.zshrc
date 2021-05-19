case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

NORM=$(tput sgr0)
BOLD='\e[1m'
DIM='\e[2m'
UNDERLINED='\e[4m'
INVERTED='\e[7m'

REDTEXT='\e[31m'
ORANGETEXT='\e[38;5;208m'
YELLOWTEXT='\e[33m'
GREENTEXT='\e[32m'
CYANTEXT='\e[36m'
BLUETEXT='\e[34m'
PURPLETEXT='\e[38;5;98m'
MAGENTATEXT='\e[38;5;165m'
BLACKTEXT='\e[30m'
WHITETEXT='\e[97m'
DEFAULTTEXT='\e[39m'

REDBACK='\e[41m'
ORANGEBACK='\e[48;5;208m'
YELLOWBACK='\e[43m'
GREENBACK='\e[42m'
CYANBACK='\e[46m'
BLUEBACK='\e[44m'
PURPLEBACK='\e[48;5;98m'
MAGENTABACK='\e[48;5;165m'
BLACKBACK='\e[40m'
WHITEBACK='\e[107m'
DEFAULTBACK='\e[49m'

function colours {
    echo -e "\n ${REDBACK}${BLACKTEXT}   REDBACK   ${NORM}           ${BLACKBACK}${REDTEXT}   REDTEXT   ${NORM}"
    echo -e " ${ORANGEBACK}${BLACKTEXT} ORANGEBACK  ${NORM}           ${BLACKBACK}${ORANGETEXT} ORANGETEXT  ${NORM}"
    echo -e " ${YELLOWBACK}${BLACKTEXT} YELLOWBACK  ${NORM}           ${BLACKBACK}${YELLOWTEXT} YELLOWTEXT  ${NORM}"
    echo -e " ${GREENBACK}${BLACKTEXT}  GREENBACK  ${NORM}           ${BLACKBACK}${GREENTEXT}  GREENTEXT  ${NORM}"
    echo -e " ${CYANBACK}${BLACKTEXT}  CYANBACK   ${NORM}           ${BLACKBACK}${CYANTEXT}  CYANTEXT   ${NORM}"
    echo -e " ${BLUEBACK}${BLACKTEXT}  BLUEBACK   ${NORM}           ${BLACKBACK}${BLUETEXT}  BLUETEXT   ${NORM}"
    echo -e " ${PURPLEBACK}${BLACKTEXT} PURPLEBACK  ${NORM}           ${BLACKBACK}${PURPLETEXT} PURPLETEXT  ${NORM}"
    echo -e " ${MAGENTABACK}${BLACKTEXT} MAGENTABACK ${NORM}           ${BLACKBACK}${MAGENTATEXT} MAGENTATEXT ${NORM}"
    echo -e " ${BLACKBACK}${WHITETEXT}  BLACKBACK  ${NORM}           ${WHITEBACK}${BLACKTEXT}  BLACKTEXT  ${NORM}"
    echo -e " ${WHITEBACK}${BLACKTEXT}  WHITEBACK  ${NORM}           ${BLACKBACK}${WHITETEXT}  WHITETEXT  ${NORM}"
    echo -e "\n\n ${NORM}${WHITETEXT}NORMAL${NORM}  |  ${BOLD}${WHITETEXT}BOLD${NORM}  |  ${DIM}${WHITETEXT}DIM${NORM}  |  ${UNDERLINED}${WHITETEXT}UNDERLINED${NORM}  |  ${INVERTED}${WHITETEXT}INVERTED${NORM}"
}

function parse_git_branch {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

function branch_name {
    git branch --no-color | grep -E '^\*' | awk '{print $2}' \
    || echo "default_value"
}

export PS1="\n\[\033[1;33m\]\u \[\033[0;33m\]\w -\[\033[1;33m\]\$(parse_git_branch) \n \[\033[1;32m\]\A \[\033[0;32m\][\#] → $NORM"
export PS2="\[\033[0;32m\] | → $NORM"

# UTILITY ALIASES
alias ls="ls -l --color=auto"
alias ..="cd ../"
alias home="cd ~"
alias cls="clear"
alias quit="exit"
alias weather="curl wttr.in/London?format='%l:+%c++%t+%w+%m'"
alias please="sudo"

# NODE PROCESS FUNCTIONS
function shownode {
    echo -e "${REDTEXT}${BOLD}ps aux | grep node${NORM}"
    ps aux | grep node
}
function killnode {
    echo -e "${REDTEXT}${BOLD}pkill -f node${NORM}"
    pkill -f node
}

# BASH SCRIPT FUNCTIONS
function edit {
    echo -e "${REDTEXT}>>> vim ${BOLD}~/.bashrc${NORM}"
    vim ~/.bashrc
}
function editvs {
    echo -e "${REDTEXT}>>> code ${BOLD}~/.bashrc${NORM}"
    code ~/.bashrc
}
function apply {
    echo -e "${REDTEXT}>>> source ${BOLD}~/.bash_profile${NORM}"
    source ~/.bash_profile
}

# GIT FUNCTIONS
function gcommit {
    echo -e "${REDTEXT}${BOLD}Enter a commit message:${NORM}"
    commit_message=
    while [[ $commit_message = "" ]]; do
        read commit_message
    done
    echo -e "${REDTEXT}>>> git commit -a -m ${BOLD}$commit_message${NORM}"
    git commit -a -m "$commit_message"
}
function gpush {
    echo -e "${REDTEXT}>>> git add ${BOLD}*${NORM}"
    git add *
    if [[ -n $(git status -s) ]]
    then
        echo -e "${REDTEXT}${BOLD}Enter a commit message:${NORM}"
        commit_message=
        while [[ $commit_message = "" ]]; do
            read commit_message
        done
        echo -e "${REDTEXT}>>> git commit -a -m ${BOLD}$commit_message${NORM}"
        git commit -a -m "$commit_message"
    fi
    echo -e "${REDTEXT}>>> git push origin ${BOLD}`branch_name`${NORM}"
    git push origin `branch_name`
}
function gpull {
    echo -e "${REDTEXT}>>> git pull origin ${BOLD}`branch_name`${NORM}"
    git pull origin `branch_name`
}
function gfetch {
    echo -e "${REDTEXT}>>> git fetch${NORM}"
    git fetch
}
function gstatus {
    echo -e "${REDTEXT}>>> git status ${BOLD}-s${NORM}"
    git status -s
}
function gadd {
    echo -e "${REDTEXT}>>> git add ${BOLD}*${NORM}"
    git add *
}
function gdiff {
    echo -e "${REDTEXT}>>> git diff${NORM}"
    git diff
}
function gstat {
    echo -e "${REDTEXT}>>> git diff ${BOLD}--stat${NORM}"
    git diff --stat
}
function gcheck {
    if [ $# -eq 0 ]
    then
        echo -e "${REDTEXT}${BOLD}Must supply a branch name${NORM}"
    else
        echo -e "${REDTEXT}>>> git checkout ${BOLD}$1${NORM}"
        git checkout $1
    fi 
}
function gbranch {
    echo -e "${REDTEXT}>>> git branch${NORM}"
    git branch
}
function gnewbranch {
    if [ $# -eq 0 ]
    then
        echo -e "${REDTEXT}${BOLD}Must supply a name for new branch${NORM}"
    else
        echo -e "${REDTEXT}>>> git checkout -b ${BOLD}$1 `branch_name`${NORM}"
        git checkout -b $1 `branch_name`
    fi  
}
function gmerge {
    if [ $# -eq 0 ]
    then
        echo -e "${REDTEXT}${BOLD}Must supply a branch to merge from${NORM}"
    else
        echo -e "${REDTEXT}>>> git pull origin ${BOLD}$1${NORM}"
        git pull origin $1	
        echo -e "${REDTEXT}>>> git merge ${BOLD}$1${NORM}"
        git merge $1
    fi
}
function glog {
    echo -e "${REDTEXT}>>> git log${NORM}"
    git log
}
function gdelete {
    echo -e "${REDTEXT}>>> git branch -D ${BOLD}$1${NORM}"
    git branch -D $1
}
function gpurge {
    echo -e "${REDTEXT}${BOLD}This will attempt to remove all local branches except 'dev'. Continue?${NORM}"
    read input
    if [[ $input == y* || $input = Y* ]]
    then
        for branch in $(git for-each-ref refs/heads  | cut -d/ -f3-)
        do
            if [ $branch != "dev" ]
            then
                gdelete $branch
            fi
        done
    else
        echo -e "${REDTEXT}${BOLD}Canceling purge...${NORM}"
    fi
}

function help {
    echo -e "\n ${REDBACK}${BLACKTEXT} UTILITY ALIASES ${NORM}${REDTEXT}"
    echo " ls           →      ls -l --color=auto"
    echo " ..           →      cd ../"
    echo " home         →      cd ~"
    echo " cls          →      clear"
    echo " please       →      sudo"
    echo " quit         →      exit"
    echo " weather      →      curl wttr.in/London?format='%l:+%c++%t+%w+%m'"

    echo -e "\n ${REDBACK}${BLACKTEXT} NODE PROCESS FUNCTIONS ${NORM}${REDTEXT}"
    echo " shownode     →      ps aux | grep node"
    echo " killnode     →      pkill -f node"

    echo -e "\n ${REDBACK}${BLACKTEXT} BASH SCRIPT FUNCTIONS ${NORM}${REDTEXT}"
    echo " edit         →      vim ~/.bash_profile"
    echo " editvs       →      code ~/.bash_profile"
    echo " apply        →      source ~/.bash_profile"

    echo -e "\n ${REDBACK}${BLACKTEXT} GIT FUNCTIONS ${NORM}${REDTEXT}"
    echo " gcommit      →      git commit -a -m"
    echo " gpush        →      git push origin"
    echo " gpull        →      git pull origin"
    echo " gfetch       →      git fetch"
    echo " gstatus      →      git status"
    echo " gadd         →      git add"
    echo " gdiff        →      git diff"
    echo " gstat        →      git diff --stat"
    echo " gcheck       →      git checkout"
    echo " gnewbranch   →      git checkout -b"
    echo " gmerge       →      git merge"
    echo " gbranch      →      git branch"
    echo " gdelete      →      git branch -D"
    echo " gpurge       →      git branch -D (all branches except dev)"
}

date
weather
echo "set completion-ignore-case On" >> ~/.inputrc
