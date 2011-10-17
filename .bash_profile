###--------------------------------------------------------------###
###--------------------------------------------------------------###
###                   STUS BASH PREFERENCES                      ###
###--------------------------------------------------------------###
###--------------------------------------------------------------###


###-------------------------------
### NOTES
###-------------------------------

# run previous command but w/ replacment
# >>> ^foo^bar
#
# e.g.:
# >>> echo "no typozs"
# ^z

# quickly backup or copy a file
# >>> cp filename{,.bak}

# empty a file
# >>> > file.txt

# quickly rename a file
# >>> mv filename.{old,new}


# ignore backups, CVS directories, python bytecode,
# and vim swap files for bash's autocompletion
FIGNORE="~:CVS:#:.pyc:.swp:.swa:apache-solr-*"

###-------------------------------
### FUNCTIONS
###-------------------------------

# create a readable path to replace ( echo $PATH )
function path(){
    old=$IFS
    IFS=:
    printf "%s\n" $PATH
    IFS=$old
}

# Function that stores my personal help files
function stuhelp(){
    # print instructions
    STR="\n\
    ENTER ONE OF THE FOLLOWING: \n\
    --------------------------- \n\
    <ENTER>      - to see default help file \n\
    bashfu       - for a list useful bash commands \n\
    macports     - macports commands \n\
    sass         - sass commands \n\
    vim          - vim commands \n\
    virtualenv   - virtual environment commands \n"
    echo -e "$STR"
    read ARG
    if [ -z "$ARG" ]; then
        cat ~/bin/stuhelp/.stu-bash-help | more
    else
        cat ~/bin/stuhelp/.stu-bash-help-$ARG | more
    fi
}

#------------------------------------------------
# Shorthand function that watches the current
# directories coffescript files, and compiles
# them to javascript whenever you save them.
# The commands single argument is the path
# you want your js files to output to.
function watchcoffee(){
    coffee -wc -o . -c "$1";
}

#!/bin/bash --posix 
#tee /tmp/stu_tmp.html 
#tell application "Google Chrome" to open location \"file:///tmp/chrome_tmp.html\""

# download a website into a PDF
makepdf(){
wget $URL | htmldoc --webpage -f "$URL".pdf - ; xpdf "$URL".pdf &
}

# Bash snippet to open new shells in most recently visited dir
# Useful for opening a new terminal tab at the present location
# taken from: https://gist.github.com/132456
pathed_cd () {
    if [ "$1" == "" ]; then
        cd
    else
        cd "$1"
    fi
    pwd > ~/.cdpath
}
alias pcd="pathed_cd"

if [ -f ~/.cdpath ]; then
    cd $(cat ~/.cdpath)
fi

# command to make a directory and cd into immediately afterwards
function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

# Zip a file or a directory
# Example: >>> zip filename
function zip () { command sudo ditto -c -k -rsrc "$0" "$0.zip"; }


###-------------------------------
###  DEFAULT EDITORS
###-------------------------------

# export EDITOR='/Users/stu/bin/vim'

# make TextMate your default editor
export EDITOR='mate -w'

# press 'v' in less and it should open the current file in textmate
export LESSEDIT='mate -l %lm %f'


###-------------------------------
###  ALIASES
###-------------------------------

# navigation aliases
alias cd..='cd ..'
alias ..="cd .."        #go to parent dir
alias ...="cd ../.."    #go to grandparent dir
alias -- -="cd -"       #go to previous dir

# list aliases
alias l.='ls -d .*'     #list hidden files
alias ll='ls -lhrt'     #extra info compared to "l"
alias lld='ls -lUd */'  #list directories
alias lsa='ls -alhp'

# Git aliases
alias gs='git status'
alias gb='git branch'
alias gu='git up'
alias gf='git fetch'
alias gr='git remote -v'
alias gba='git branch -a'
alias gc='git commit -v'
alias gd='git diff | $EDITOR'
alias gpl='git pull'
alias gp='git push'
alias gl='git log'
alias ga='git add'


# misc aliases
alias kp='ps auxwww'
alias redo='sudo !!'              # redo last command
alias inst='sudo port -v install' # macport install shortcut
alias cwd='pwd | pbcopy'          # copy working dir to clipboard

# system monitoring
alias topcpu='ps aux | sort -n +2 | tail -10' # top 10 cpu processes
alias topmem='ps aux | sort -n +3 | tail -10' # top 10 memory processes

# disk usage with human sizes and minimal depth
alias du1='du -h --max-depth=1'
alias fn='find . -name'
alias hi='history | tail -20'

# list currently mounted filesystems in a nice readable columns
alias mount='mount | column -t'

# list all files in the pwd along with their sizes
alias d='du -h -d 1'

# show all apps using the internet at the moment
alias usingnet='lsof -P -i -n'

# history configuration
alias h=history
export HISTFILESIZE=10000
export HISTSIZE=1000
export HISTCONTROL=erasedups

# confirm whenever moving, copying, or
# deleting files & be verbose about it.
alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'

# Django aliases
alias dj='python manage.py'
alias djr='python manage.py runserver'


# keeps you from overwriting original
# when redirecting output to a file.
set -o noclobber

# turn a directory of pngs into an avi
alias pngs_to_avi='mencoder mf://*.png -mf fps=30 -ovc lavc -lavcopts vcodec=mpeg4:mbd=2:trell:vbitrate=5000 -oac copy -o'

# Tab completion from the contents of .ssh/known_hosts
complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed 's/,.*//g' | sed 's/\[//g '| sed 's/\\]:[0-9]*//g' | uniq | grep -v "\["`;)" ssh

# use unicode
export LC_CTYPE=en_US.UTF-8
 
# add color to the terminal
alias ls='ls -G'
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
export CLICOLOR=1
# export TERM=xterm-256color

# add shortcut to ruby gems directory
alias gems='cd /Library/Ruby/Gems/1.8/gems/'

# add shortcut to python site-packages directory
alias sitepackages='cd /opt/local/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/site-packages/'

###-------------------------------
###  macports && darwinports
###-------------------------------

export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:${PATH}"

# MacPorts Installer addition on 2011-01-06_at_16:31:19: PATH to macports 
export PATH="/opt/local/bin:/opt/local/sbin:{$PATH}"

# Setting PATH for MacPython 2.7
# PATH="/Library/Frameworks/Python.framework/Versions/2.6/bin:${PATH}"

###-------------------------------
###  misc command line programs
###-------------------------------

# Add my personal utilties files
export PATH="~/.stutils:${PATH}"

# Add TSVutils script for parsing various files into TSV file format
export PATH="/Users/stu/.TSVutils:${PATH}"

# PATH to numenta
# NTA=$HOME/nta/current
# export PATH=$NTA/bin:$PATH
# export PYTHONPATH=$NTA/lib/python2.5/site-packages:$PYTHONPATH

###------------------------------
###  node.js
###------------------------------
export NODE_PATH="/usr/local/lib/node"
export PATH="/usr/local/share/npm/bin:${PATH}"

###-------------------------------
###  ruby paths below
###-------------------------------
export PATH="/Users/stu/.gem/ruby/1.8/bin:${PATH}"

###-------------------------------
###  python paths below
###-------------------------------
# setting the PATH for MY local executable directory
export PATH="/Users/stu/bin:${PATH}"

# setting the PATH for MY Local Python modules directory
export PATH="/Users/stu/usr/lib/python2.6/site-packages:${PATH}"

# PATH to python 2.6
#export PATH="/Library/Frameworks/Python.framework/Versions/2.6/bin:${PATH}"

# PATH to python 2.7
export PATH="/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PYTHONPATH='/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin'

###------------------------------
###  virtualenv wrapper
###-------------------------------

# it must be exported after your PYTHON path
# otherwise it will draw from default directory

export WORKON_HOME=$HOME/Projects/virtualenvs
# source '/usr/local/bin/virtualenvwrapper.sh'
source '/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin/virtualenvwrapper.sh'

export DYLD_FALLBACK_LIBRARY_PATH="/opt/local/lib"

