# Don't user fisherman for now, see
# See https://github.com/fisherman/fisherman/issues/340

# Ensure fisherman and plugins are installed
#if not test -f $HOME/.config/fish/functions/fisher.fish
#  echo "==> Fisherman not found.  Installing."
#  curl -sLo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
#  fisher
#end

#set -U fish_path $HOME/dotfiles/fisherman
#
#set fish_function_path $fish_path/functions $fish_function_path
#set fish_complete_path $fish_path/completions $fish_complete_path
#for file in $fish_path/conf.d/*.fish
#    source $file
#end


set -x SHELL /usr/bin/fish
set -x EDITOR nvim
set -x HOSTNAME (hostname)
set -x PROJECT_HOME $HOME/projects

function fish_greeting -d "what's up, fish?"
  set_color $fish_color_autosuggestion
  uname -nmsr
  w
  set_color normal
end

# Until devpi issue #64 is implemented, you need to set REQUESTS_CA_BUNDLE environment variable
# Uhm, not really a good solution, in that case this is the only CA allowed by requests
# set -x REQUESTS_CA_BUNDLE $HOME/devpi_certs/nginx.crt

# We need this for now, see:
# https://github.com/fish-shell/fish-shell/issues/1485
# https://github.com/fish-shell/fish-shell/commit/5157ac30faf8fde5e9ea84977fdf430e01b71f96
# Not merged in any release yet
# set fish_complete_path $fish_complete_path $__fish_datadir/vendor_completions.d

# Set go variables
set -x GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH


# Instead of global npm packages, use a local one and add it to PATH
set -x PATH $HOME/dotfiles/node_modules/.bin $PATH

# Use local node packages
set -x PATH ./node_modules/.bin $PATH


## Use local python environment
# Better use pew/virtualenvwrapper, less error prone
#set -x PATH ./venv/bin $PATH
#function venv --description 'Virtual Python env at venv'
#    pyvenv $argv venv
#end


# Use ruby gems
if test -d "$HOME/.gem"
    set ruby_version (command ls $HOME/.gem/ruby | tail -1)
    set -x PATH $PATH "$HOME/.gem/ruby/$ruby_version/bin"
end


# Virtual node functions
#. $PROJECT_HOME/virtualnode/vn_complete.fish
#function vn
#    bash $PROJECT_HOME/virtualnode/virtualnode.sh $argv
#end


# Some extra utilities
source $HOME/.config/fish/functions.fish
source $HOME/.config/fish/docker.fish
source $HOME/.config/fish/fzf.fish
source /usr/share/autojump/autojump.fish

#### A better prompt


# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch a0ff33
#set __fish_git_prompt_color_branch 53c156
#set __fish_git_prompt_color_dirtystate 'red'
#set __fish_git_prompt_color_upstream_ahead 'ffb90f'
#set __fish_git_prompt_color_upstream_behind 'blue'


# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'


function get_pwd
    echo $PWD | sed -e "s|^$HOME|~|"
end


function get_pyenv
    if set -q VIRTUAL_ENV
        echo (set_color -b blue white)"("(basename "$VIRTUAL_ENV")")"(set_color normal)" "
    else
        echo ""
    end
end


function get_nodeenv
    if set -q VIRTUAL_NODE
        echo (set_color -b 62A white)"("(basename "$VIRTUAL_NODE")")"(set_color normal)" "
    else
        echo ""
    end
end


#fish_vi_key_bindings

function fish_mode_prompt --description 'Displays the current mode'
    # Do nothing if not in vi mode
    if test "$fish_key_bindings" = "fish_vi_key_bindings"
        switch $fish_bind_mode
            case default
                set_color --bold blue
                echo 🅽
            case insert
                set_color --bold green
                echo 🅸
            case replace-one
                set_color --bold red
                echo 🆁
            case visual
                set_color --bold brmagenta
                echo 🆅
        end
        set_color normal
        printf '  '
    end
end

function fish_user_key_bindings
    bind \cc 'commandline ""'
end

# From https://github.com/0rax/fishline
function fish_prompt
    # $status gets nuked as soon as something else is run, e.g. set_color
    # so it has to be saved asap.   #echo "$prompt""$git_p"
    set -l last_status $status

    # Powerline Glyphs
    set FLSYM_LEFT_CLOSE "\uE0B0"
    set BG_NORMAL 444
    set BG_ERROR A22

    printf '%s%s%s%s%s @ %s%s%s in ' (get_pyenv) (get_nodeenv) (set_color cyan) (whoami) (set_color normal) \
                                     (set_color yellow) (hostname|cut -d . -f 1) (set_color normal)

    if not test -w .
		printf '%s%s ' (set_color red) ''
	end

    printf '%s%s%s%s' (set_color e0c060) (get_pwd) (set_color normal) (__fish_git_prompt)

    echo ''

    if test $last_status = 0
        #printf '%s%s%s' (set_color green) '✔  ' (set_color normal)
        set_color -b $BG_NORMAL
        printf ' → '
        set_color $BG_NORMAL -b normal
    else
        #printf '%s%s%s' (set_color red) '✗  ' (set_color normal)
        set_color -b $BG_ERROR
        printf " $last_status "
        set_color $BG_ERROR -b normal
    end
    printf $FLSYM_LEFT_CLOSE
    set_color normal -b normal
    printf " "

end
