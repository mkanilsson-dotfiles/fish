#!/usr/bin/fish

set fish_greeting ""

# function fish_user_key_bindings
#     fish_vi_key_bindings
# end


# Enviroment variables
set -gx TERM xterm-256color
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx GOPATH "$HOME/Documents/dev/go"
set -gx CMAKE_GENERATOR Ninja
set -gx DOOMDIR "~/.doom.d"

# Quality of life
alias cp "cp -i" # confirm before overwriting something
alias rm "rm -i" # confirm before deleting something
alias df 'df -h' # human-readable sizes
alias free 'free -m' # show sizes in MB
alias more less
alias sdn "doas shutdown -P now" # sdn = "sudo shutdown now"
alias du gdu # gdu is a bit nicer than du
alias ls "exa --color=always --git" # prettiy colors
alias cat bat # prettiy colors

# Git
alias ga "git add"
alias gpull "git pull"
alias gc "git commit"
alias gpush "git push"
alias gai "git add -p ."

function gd -d "git diff with bat"
    git diff --name-only | xargs bat --diff
end

# Python
alias python python3
alias pip pip3

# Laravel
alias artisan "php artisan"
alias tinker "php artisan tinker"
alias migrate "php artisan migrate"
alias sail "vendor/bin/sail"

# AdonisJS
alias ace "node ace"
alias arepl "node ace repl"

# DOAS IS BETTER THAN SUDO!!!! >:(
alias sudo doas

alias v lvim

alias sx "startx ~/.config/X11/xinitrc"

# Extract different archives
# Shamelessly stolen from either Manjaro i3 edition default .bashrc or Ubuntu 20.04 LTS default .bashrc
function ex -d "Extracts archives"
    if test -f $argv[1]
        switch $argv[1]
            case '*.tar.bz2'
                tar xjf $argv[1]
            case '*.tar.gz'
                tar xzf $argv[1]
            case '*.bz2'
                bunzip2 $argv[1]
            case '*.rar'
                unrar x $argv[1]
            case '*.gz'
                gunzip $argv[1]
            case '*.tar'
                tar xf $argv[1]
            case '*.tbz2'
                tar xjf $argv[1]
            case '*.tgz'
                tar xzf $argv[1]
            case '*.zip'
                unzip $argv[1]
            case '*.Z'
                uncompress $argv[1]
            case '*.7z'
                7z x $argv[1]
            case '*'
                echo "$argv[1] cannot be extracted via ex"
        end
    else
        echo "$argv[1] is not a file"
    end
end

# Paths
fish_add_path "$HOME/Android/Sdk/emulator"
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/opt/cross/bin"
fish_add_path "$HOME/.emacs.d/bin"
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/Documents/dev/go/bin"
fish_add_path "$HOME/.cabal/bin"
fish_add_path /usr/lib/node_modules/npm
fish_add_path /var/lib/snapd/snap/bin
fish_add_path "$HOME/.config/composer/vendor/bin"

# Prompt
# user@host:/current/path (master)$ commands and stuff        status_code       
function fish_prompt
    set -l user (set_color blue --bold) (whoami)
    set -l at (set_color grey) "@"
    set -l host (set_color brgreen) (prompt_hostname)
    set -l in (set_color grey) ":"
    set -l dir (set_color magenta) (string replace $HOME '~' $PWD)
    set -l vsc (set_color yellow) (fish_vcs_prompt)
    set -l prompt_symbol (set_color grey) '$'
    set -l end (set_color normal) " "

    echo -s $fish $user $at $host $in $dir $vsc $prompt_symbol $end
end

function fish_mode_prompt
    switch $fish_bind_mode
        case default
            set_color --bold red
            echo '[N] '
        case insert
            set_color --bold green
            echo '[I] '
        case replace_one
            set_color --bold green
            echo '[R] '
        case visual
            set_color --bold brmagenta
            echo '[V] '
        case '*'
            set_color --bold red
            echo '[?] '
    end
    set_color normal
end

function fish_right_prompt
    set -l last_status $status

    if test $last_status != 0
        echo -s (set_color red) "$last_status" (set_color normal)
    end
end
