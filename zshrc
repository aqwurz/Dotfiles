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

### User configuration

# Environment variables
export EDITOR='nvim'
export OPENCV_LOG_LEVEL=ERROR
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export $(dbus-launch)
export WINIT_X11_SCALE_FACTOR=1
export YTFZF_CUSTOM_INTERFACES_DIR=~/.config/ytfzf/interfaces
export CDPATH=:..:~
export GPATH=$HOME/.go
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=gasp'
. "/home/antoine/.cache/wal/colors.sh"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Import colorscheme from 'wal' asynchronously
#(cat ~/.cache/wal/sequences &)
# Alternative (blocks terminal for 0-3ms)
cat ~/.cache/wal/sequences
# To add support for TTYs this line can be optionally added.
source ~/.cache/wal/colors-tty.sh

# fancy custom syntax highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
typeset -A ZSH_HIGHLIGHT_PATTERNS
ZSH_HIGHLIGHT_PATTERNS+=('sudo' 'fg=cyan,bold')

# motd
clear; figlet -cf slant antoine | lolcat; echo "\033[0;37m" "$(fortune /usr/share/fortune/vimtips | figlet -cf term)" "\033[0m \n"

# set prompt
PROMPT='╭─%{$terminfo[bold]%}[$(date +"%H:%M:%S")]%{$fg[yellow]%} %n at %m %{$reset_color%}%{$terminfo[bold]$fg[blue]%}in %(5~|%-1~/.../%3~|%4~) %{$reset_color%}$(ruby_prompt_info)$(git_prompt_info)$(virtualenv_prompt_info)
╰─%B$%b '

### The grand list of aliases
# Change vim into neovim - old habits die hard
alias vim='nvim'
# Colourize utilities
alias ls='ls --color=auto'
alias grep='grep --color=auto'
# sudo lectures
alias sudo='cowsay -f tux "plz do not do anything stupid thx <3<3 XOXO" | lolcat && sudo'
alias ASCEND='echo "( ..) I am watching you" | lolcat && sudo -i'
# Pretty please?
alias absolutely="yes | sudo"
# Weather scripts
alias w1='curl v2.wttr.in/Oslo'
alias w0='curl wttr.in/Oslo'
alias wM='curl wttr.in/Moon'
# Pastebin script that I never use
alias ix='curl -F "f:1=<-" ix.io'
# Run update function (see below)
alias Syu='syu'
# Accelerate zsh performance (DO NOT REMOVE!)
alias rr='curl -sL https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'
# Sometimes, I hold down Shift for too long when running the update alias, 
# which makes me type `SA` instead of `Syu`
alias SA='sl; syu; rr'
# Terminal map?
alias map='telnet mapscii.me'
# Spawn motd
alias header='clear; figlet -cf slant antoine | lolcat; echo "\033[0;37m" "$(fortune -s | figlet -cf term)" "\033[0m \n"'
# Browse the Arch wiki in the terminal
alias archwiki='wikicurses -w ArchWiki'
# Fix keybinds so that Caps lock actually gets set to Hyper
# TODO: Expand alias to include the setxkbsmthsmth command as well
alias x='xmodmap ~/.Xmodmap'
# Fancy cd aliases
alias u1='..'
alias u2='../..'
alias u3='../../..'
alias u4='../../../..'
alias ...=u2
alias ....=u3
alias .....=u4
# pacman/yay aliases
alias yaay="yay -Slq | fzf -m --preview 'cat <(yay -Si {1}) <(yay -Fl {1} | awk \"{print \$2}\")' | xargs -ro yay -S"
alias inspec="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias delet="yay -Rns"

### Functions
# Update script
syu() { sudo clear; cat ~/.config/bigarch | figlet -ctf term; yay -Pw && time yay -Syu $@; sudo pacdiff; paccache -r; ncdu ~/.cache/yay }
# Rebuild packages that require a certain recently updated package (often python)
fix() { pacman -Qoq $1 | yay -S --rebuild - }
# Reinstall a package
reinstall() { yay -Rns $@; yay -S $@}
# Harvest bits while afking Twitch
# TODO: Update mouse coordinates
twitchFarm() { while true; do xdotool mousemove 1072 1002 && xdotool click 1; sleep 900; done; }
# Play some unappealing tunes
muzak() { cat /dev/urandom | hexdump -v -e '/1 "%u\n"' | awk '{ split("4,5,7,11",a,","); for (i = 0; i < 1; i+= 0.0001) printf("%08X\n", 100*sin(1046*exp((a[$1 % 8]/12)*log(2))*i)) }' | xxd -r -p | pacat --channels=2 --format=s32le --rate=24000; }
# Yet another weather function
w() { curl v2.wttr.in/"$1"; }
# Cheat sheet
cht() { curl cht.sh/"$1"/"$2"; }
# Compile and run Java programs
j() { javac *.java; java "$@"}
# Not sure what this is, but it looks cool
rimage() { feh --scale-down "$(reddio print -f '$url$nl' info/$1)" }
# Extracts various archive files
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
            # Fun fact: Did you know that MSOffice files are zip files?
            *.doc)      unzip $1    ;;
            *.docx)     unzip $1    ;;
            *.ppt)      unzip $1    ;;
            *.pptx)     unzip $1    ;;
            *.xls)      unzip $1    ;;
            *.xlsx)     unzip $1    ;;

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
# Extract a Word document
unword() { unzip -p $1 word/document.xml | sed -e 's/<[^>]\{1,\}>/\n/g; s/[^[:print:]]\{1,\}/\n/g' }
# Make a directory and immediately cd to it
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
