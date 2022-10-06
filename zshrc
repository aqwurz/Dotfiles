#################################################################################
#                                                                               #
#                   So it's the same type of shell as [bash]...                 #
#                                                                               #
#################################################################################

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$HOME/.gem/ruby/*/gems:$HOME/.gem/ruby/*/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/antoine/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="bira"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  fancy-ctrl-z
)

# vi mode
bindkey -v

source $ZSH/oh-my-zsh.sh

autoload zmv

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

export EDITOR='nvim'
export OPENCV_LOG_LEVEL=ERROR
#export LØGFILE='~/.local/share/track.log'
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export $(dbus-launch)
export WINIT_X11_SCALE_FACTOR=1
export YTFZF_CUSTOM_INTERFACES_DIR=~/.config/ytfzf/interfaces
export CDPATH=:..:~
export GPATH=$HOME/.go
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp'
. "/home/antoine/.cache/wal/colors.sh"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
#(cat ~/.cache/wal/sequences &)

# # Alternative (blocks terminal for 0-3ms)
cat ~/.cache/wal/sequences
#
# # To add support for TTYs this line can be optionally added.
source ~/.cache/wal/colors-tty.sh

# fancy custom syntax highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
typeset -A ZSH_HIGHLIGHT_PATTERNS
ZSH_HIGHLIGHT_PATTERNS+=('sudo' 'fg=cyan,bold')

## if not a vim terminal, do fancy prompt and motd
#if [[ $SHLVL == 1 ]]; then

# motd
clear; figlet -cf slant antoine | lolcat; echo "\033[0;37m" "$(fortune /usr/share/fortune/vimtips | figlet -cf term)" "\033[0m \n"

# set prompt
#PROMPT='╭─%{$terminfo[bold]$fg[yellow]%}$(python ~/prog/ps1char.py) %n at %m %{$reset_color%}%{$terminfo[bold]$fg[blue]%}in %(5~|%-1~/.../%3~|%4~) %{$reset_color%}$(ruby_prompt_info)$(git_prompt_info)$(virtualenv_prompt_info)
PROMPT='╭─%{$terminfo[bold]%}[$(date +"%H:%M:%S")]%{$fg[yellow]%} %n at %m %{$reset_color%}%{$terminfo[bold]$fg[blue]%}in %(5~|%-1~/.../%3~|%4~) %{$reset_color%}$(ruby_prompt_info)$(git_prompt_info)$(virtualenv_prompt_info)
╰─%B$%b '

## else, do simple prompt
#elif [[ $SHLVL == 2 ]]; then

#clear

# set prompt
#PROMPT='[VIM] %(5~|%-1~/.../%3~|%4~) $(ruby_prompt_info)$(git_prompt_info)$(virtualenv_prompt_info)'    
#fi

#PROMPT='╭─%{$terminfo[bold]$fg[green]%}EKSAMEN: %{$reset_color%}%{$terminfo[bold]$fg[blue]%} %~ %{$reset_color%}$(ruby_prompt_info)$(git_prompt_info)$(virtualenv_prompt_info)
#╰─%B$%b '

alias vim='nvim'
# copy-paste from .bashrc - I don't take responsibility for my own actions
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias sudo='cowsay -f tux "plz do not do anything stupid thx <3<3 XOXO" | lolcat && sudo'
alias ASCEND='echo "( ..) I am watching you" | lolcat && sudo -i'
alias w1='curl v2.wttr.in/Oslo'
alias w0='curl wttr.in/Oslo'
alias wM='curl wttr.in/Moon'
alias exodus='sudo mount -U 1684E0AA84E08D95 /mnt/exodus/; ln -sf /mnt/exodus ~/Exodus'
alias ix='curl -F "f:1=<-" ix.io'
alias solitaire='ttysolitaire'
alias bjpycli='python ~/personal/bujo/bjpycli.py'
alias bjvim='nvim -p ~/personal/bujo/bjmoodsnew.dat ~/personal/bujo/bjselfdiscipline.dat ~/personal/bujo/bjtitles.csv ~/personal/bujo/bjtexts.dat ~/personal/bujo/bjpss.csv ~/personal/bujo/bjratings.csv ~/personal/bujo/bjmoods.csv ~/personal/bujo/bjpygrdat.txt'
alias Syu='syu'
alias rr='curl -sL https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'
alias SA='sl; syu; rr'
alias chess='gnuchess'
alias sw='python ~/prog/switchTheme.py && xdotool key ctrl+shift+r'
alias bsod='unimatrix -c white -g blue -s 97'
alias map='telnet mapscii.me'
alias xterm='python ~/prog/xtermLaunch.py'
alias storUse='cd / && ncdu'
alias rtv='tuir'
alias rtvm='tuir --monochrome'
alias turn='xrandr --output eDP-1 --rotate'
alias purge='sudo -k'
alias nfbonsai='bonsai -n -L 20 -g 35,20 > ~/prog/my_bonsai_art.txt && neofetch --ascii ~/prog/my_bonsai_art.txt --ascii_colors 11 3 10 2 0'
alias rfbonsai='bonsai -L 20 -g 35,20 > ~/prog/my_bonsai_art.txt && rsfetch -PdhikrsuwUH@lp pacman -L ~/prog/my_bonsai_art.txt'
alias header='clear; figlet -cf slant antoine | lolcat; echo "\033[0;37m" "$(fortune -s | figlet -cf term)" "\033[0m \n"'
alias archwiki='wikicurses -w ArchWiki'
alias four='sed -i "s/	/    /g"'
alias pinball='wine ~/Games/pinball/pinball.exe'
alias re='tuir -s'
alias calsync='~/prog/calsync.sh'
alias vja='vim *.java'
alias x='xmodmap ~/.Xmodmap'
alias t='sudo tlp start'
alias zoom='firejail --quiet --profile=~/.config/firejail/zoom.profile --private=/opt/zoom/home /usr/bin/zoom'
alias torstart='sudo ~/prog/torstart.sh'
alias torstop='sudo ~/prog/torstop.sh'
alias u1='..'
alias u2='../..'
alias u3='../../..'
alias u4='../../../..'
alias ...=u2
alias ....=u3
alias .....=u4
alias yaay="yay -Slq | fzf -m --preview 'cat <(yay -Si {1}) <(yay -Fl {1} | awk \"{print \$2}\")' | xargs -ro yay -S"
alias inspec="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias bkgset="~/prog/bkgset.sh"
alias delet="yay -Rns"
alias absolutely="yes | sudo"
syu() { sudo clear; cat ~/prog/bigarch | figlet -ctf term; yay -Pw && time yay -Syu $@; sudo pacdiff; paccache -r; ncdu ~/.cache/yay }
fix() { pacman -Qoq $1 | yay -S --rebuild - }
twitchFarm() { while true; do xdotool mousemove 1072 1002 && xdotool click 1; sleep 900; done; }
muzak() { cat /dev/urandom | hexdump -v -e '/1 "%u\n"' | awk '{ split("4,5,7,11",a,","); for (i = 0; i < 1; i+= 0.0001) printf("%08X\n", 100*sin(1046*exp((a[$1 % 8]/12)*log(2))*i)) }' | xxd -r -p | pacat --channels=2 --format=s32le --rate=24000; }
w() { curl v2.wttr.in/"$1"; }
cht() { curl cht.sh/"$1"/"$2"; }
j() { javac *.java; java "$@"}
vj() { vim -p *java }
rimage() { feh --scale-down "$(reddio print -f '$url$nl' info/$1)" }
ex() { # thanks, dt
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)  tar xjf $1  ;;
            *.tar.gz)   tar xzf $1  ;;
            *.bz2)      bunzip2 $1  ;;
            *.rar)      unrar x $1  ;;
            *.gz)       gunzip $1   ;;
            *.tar)      tar xf $1   ;;
            *.tbz2)     tar xjf $1  ;;
            *.tgz)      tar xzf $1  ;;
            *.zip)      unzip $1    ;;
            *.Z)        uncompress $1;;
            *.7z)       7z x $1     ;;
            *.deb)      ar x $1     ;;
            *.tar.xz)   tar xf $1   ;;
            *.tar.zst)  unzstd $1   ;;
            *)          echo "'$1' ain\'t a thing to extract dude" ;;
        esac
    else
        echo "dude wtf"
    fi
}
unword() { unzip -p $1 word/document.xml | sed -e 's/<[^>]\{1,\}>/\n/g; s/[^[:print:]]\{1,\}/\n/g' }
# sl() { "/usr/bin/sl" "$@"; ls "$@"; }
reinstall() { yay -Rns $@; yay -S $@}
mc() { mkdir -p $1 && cd $1 }

#will z work?
. /usr/share/z/z.sh

# fishy stuff
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval $(thefuck --alias)
# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' max-errors 3
zstyle :compinstall filename '/home/antoine/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall


PATH="/home/antoine/.perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/antoine/.perl5/lib/.perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/antoine/.perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/antoine/.perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/antoine/.perl5"; export PERL_MM_OPT;
