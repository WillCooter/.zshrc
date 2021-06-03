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

function printline {
    printf "$1\n"
}

function colours {
    printline "\n ${REDBACK}${BLACKTEXT}   REDBACK   ${NORM}           ${BLACKBACK}${REDTEXT}   REDTEXT   ${NORM}"
    printline " ${ORANGEBACK}${BLACKTEXT} ORANGEBACK  ${NORM}           ${BLACKBACK}${ORANGETEXT} ORANGETEXT  ${NORM}"
    printline " ${YELLOWBACK}${BLACKTEXT} YELLOWBACK  ${NORM}           ${BLACKBACK}${YELLOWTEXT} YELLOWTEXT  ${NORM}"
    printline " ${GREENBACK}${BLACKTEXT}  GREENBACK  ${NORM}           ${BLACKBACK}${GREENTEXT}  GREENTEXT  ${NORM}"
    printline " ${CYANBACK}${BLACKTEXT}  CYANBACK   ${NORM}           ${BLACKBACK}${CYANTEXT}  CYANTEXT   ${NORM}"
    printline " ${BLUEBACK}${BLACKTEXT}  BLUEBACK   ${NORM}           ${BLACKBACK}${BLUETEXT}  BLUETEXT   ${NORM}"
    printline " ${PURPLEBACK}${BLACKTEXT} PURPLEBACK  ${NORM}           ${BLACKBACK}${PURPLETEXT} PURPLETEXT  ${NORM}"
    printline " ${MAGENTABACK}${BLACKTEXT} MAGENTABACK ${NORM}           ${BLACKBACK}${MAGENTATEXT} MAGENTATEXT ${NORM}"
    printline " ${BLACKBACK}${WHITETEXT}  BLACKBACK  ${NORM}           ${WHITEBACK}${BLACKTEXT}  BLACKTEXT  ${NORM}"
    printline " ${WHITEBACK}${BLACKTEXT}  WHITEBACK  ${NORM}           ${BLACKBACK}${WHITETEXT}  WHITETEXT  ${NORM}"
    printline "\n\n ${NORM}${WHITETEXT}NORMAL${NORM}  |  ${BOLD}${WHITETEXT}BOLD${NORM}  |  ${DIM}${WHITETEXT}DIM${NORM}  |  ${UNDERLINED}${WHITETEXT}UNDERLINED${NORM}  |  ${INVERTED}${WHITETEXT}INVERTED${NORM}"
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
alias ls="ls -l -a  --color=auto"
alias ..="cd ../"
alias home="cd ~"
alias cls="clear"
alias quit="exit"
alias weather="curl wttr.in/London?format='%l:+%c++%t+%w+%m'"
alias please="sudo"

# NODE PROCESS FUNCTIONS
function shownode {
    printline "${REDTEXT}${BOLD}ps aux | grep node${NORM}"
    ps aux | grep node
}
function killnode {
    printline "${REDTEXT}${BOLD}pkill -f node${NORM}"
    pkill -f node
}

# BASH SCRIPT FUNCTIONS
function edit {
    printline "${REDTEXT}>>> vim ${BOLD}~/.bashrc${NORM}"
    vim ~/.bashrc
}
function editvs {
    printline "${REDTEXT}>>> code ${BOLD}~/.bashrc${NORM}"
    code ~/.bashrc
}
function apply {
    printline "${REDTEXT}>>> source ${BOLD}~/.bash_profile${NORM}"
    source ~/.bash_profile
}

# GIT FUNCTIONS
function gcommit {
    git diff --stat
    printline "${REDTEXT}${BOLD}Enter a commit message:${NORM}"
    commit_message=
    while [[ $commit_message = "" ]]; do
        read commit_message
    done
    printline "${REDTEXT}>>> git commit -a -m ${BOLD}$commit_message${NORM}"
    git commit -a -m "$commit_message"
}
function gpush {
    printline "${REDTEXT}>>> git add ${BOLD}*${NORM}"
    git add *
    if [[ -n $(git status -s) ]]
    then
        gcommit
    fi
    printline "${REDTEXT}>>> git push origin ${BOLD}`branch_name`${NORM}"
    git push origin `branch_name`
}
function gpull {
    printline "${REDTEXT}>>> git pull origin ${BOLD}`branch_name`${NORM}"
    git pull origin `branch_name`
}
function gadd {
    printline "${REDTEXT}>>> git add ${BOLD}*${NORM}"
    git add *
}
function gmerge {
    if [ $# -eq 0 ]
    then
        printline "${REDTEXT}${BOLD}Must supply a branch to merge from${NORM}"
    else
        printline "${REDTEXT}>>> git pull origin ${BOLD}$1${NORM}"
        git pull origin $1	
        printline "${REDTEXT}>>> git merge ${BOLD}$1${NORM}"
        git merge $1
    fi
}
function gfetch {
    printline "${REDTEXT}>>> git fetch${NORM}"
    git fetch
}
function gstatus {
    printline "${REDTEXT}>>> git status ${BOLD}-s${NORM}"
    git status -s
}
function glog {
    printline "${REDTEXT}>>> git log${NORM}"
    git log
}
function gdiff {
    printline "${REDTEXT}>>> git diff${NORM}"
    git diff
}
function gstat {
    printline "${REDTEXT}>>> git diff ${BOLD}--stat${NORM}"
    git diff --stat
}
function gcheck {
    if [ $# -eq 0 ]
    then
        printline "${REDTEXT}${BOLD}Must supply a branch name${NORM}"
    else
        printline "${REDTEXT}>>> git checkout ${BOLD}$1${NORM}"
        git checkout $1
    fi 
}
function gbranch {
    printline "${REDTEXT}>>> git branch${NORM}"
    git branch
}
function gnewbranch {
    if [ $# -eq 0 ]
    then
        printline "${REDTEXT}${BOLD}Must supply a name for new branch${NORM}"
    else
        printline "${REDTEXT}>>> git checkout -b ${BOLD}$1 `branch_name`${NORM}"
        git checkout -b $1 `branch_name`
    fi  
}
function gdelete {
    printline "${REDTEXT}>>> git branch -D ${BOLD}$1${NORM}"
    git branch -D $1
}
function gpurge {
    printline "${REDTEXT}${BOLD}This will attempt to remove all local branches except 'dev'. Continue?${NORM}"
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
        printline "${REDTEXT}${BOLD}Canceling purge...${NORM}"
    fi
}

function help {
    printline "\n ${REDBACK}${BLACKTEXT} UTILITY ALIASES ${NORM}${REDTEXT}"
    printline " ls           →      ls -a -l"
    printline " ..           →      cd ../"
    printline " home         →      cd ~"
    printline " cls          →      clear"
    printline " please       →      sudo"
    printline " quit         →      exit"
    printline " weather      →      curl wttr.in/London"

    printline "\n ${REDBACK}${BLACKTEXT} NODE PROCESS FUNCTIONS ${NORM}${REDTEXT}"
    printline " shownode     →      ps aux | grep node"
    printline " killnode     →      pkill -f node"

    printline "\n ${REDBACK}${BLACKTEXT} BASH SCRIPT FUNCTIONS ${NORM}${REDTEXT}"
    printline " edit         →      vim ~/.bash_profile"
    printline " editvs       →      code ~/.bash_profile"
    printline " apply        →      source ~/.bash_profile"

    printline "\n ${REDBACK}${BLACKTEXT} GIT FUNCTIONS ${NORM}${REDTEXT}"
    printline " gcommit      →      git commit -a -m"
    printline " gpush        →      git push origin"
    printline " gpull        →      git pull origin"
    printline " gadd         →      git add"
    printline " gmerge       →      git merge"
    printline " gfetch       →      git fetch"
    printline " gstatus      →      git status"
    printline " glog         →      git log"
    printline " gdiff        →      git diff"
    printline " gstat        →      git diff --stat"
    printline " gcheck       →      git checkout"
    printline " gbranch      →      git branch"
    printline " gnewbranch   →      git checkout -b"
    printline " gdelete      →      git branch -D"
    printline " gpurge       →      git branch -D (all branches except dev)"
}

date
weather
echo "set completion-ignore-case On" >> ~/.inputrc
