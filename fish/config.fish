set -x SHELL /usr/bin/fish
set -x EDITOR vim
set -x HOSTNAME (hostname)
set -x PROJECT_HOME $HOME/projects
set fish_greeting ""

# Until devpi issue #64 is implemented, you need to set REQUESTS_CA_BUNDLE environment variable
# Uhm, not really a good solution, in that case this is the only CA allowed by requests
# set -x REQUESTS_CA_BUNDLE $HOME/devpi_certs/nginx.crt

# We need this for now, see:
# https://github.com/fish-shell/fish-shell/issues/1485
# https://github.com/fish-shell/fish-shell/commit/5157ac30faf8fde5e9ea84977fdf430e01b71f96
# Not merged in any release yet
set fish_complete_path $fish_complete_path $__fish_datadir/vendor_completions.d

# Set go variables
set -x GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH


# Global npm packages
set -x NPM_CONFIG_PREFIX $HOME/.node
function npmg --description 'npm global'
    npm -g --prefix $NPM_CONFIG_PREFIX $argv
end
set -x PATH $NPM_CONFIG_PREFIX/bin $PATH
set -x NODE_PATH $NPM_CONFIG_PREFIX/lib/node_modules

# Use local node packages
set -x PATH ./node_modules/.bin $PATH


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
. $HOME/.config/fish/functions.fish
. $HOME/.config/fish/docker.fish

# Some abbreviations
set -x fish_user_abbreviations 'gco=git checkout'

#### A better prompt


# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch a0ff33
#set __fish_git_prompt_color_branch 53c156


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


function fish_prompt
    # $status gets nuked as soon as something else is run, e.g. set_color
    # so it has to be saved asap.   #echo "$prompt""$git_p"
    set -l last_status $status

    printf '%s%s%s%s%s @ %s%s%s in %s%s%s%s' (get_pyenv) (get_nodeenv) (set_color cyan) (whoami) (set_color normal) \
                                           (set_color yellow) (hostname|cut -d . -f 1) (set_color normal) \
                                           (set_color e0c060) (get_pwd) (set_color normal) (__fish_git_prompt)
    echo ''
    if test $last_status = 0
        printf '%s%s%s' (set_color green) '✔  ' (set_color normal)
    else
        printf '%s%s%s' (set_color red) '✗  ' (set_color normal)
    end
end
