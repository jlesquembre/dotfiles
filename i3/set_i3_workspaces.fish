#!/usr/bin/fish


function xterm_cmd
    set tempdir (mktemp -d)
    mkdir $tempdir/fish
    set temp_config $tempdir/fish/config.fish

    # Set XDG_CONFIG_HOME in new shell
    if set -q XDG_CONFIG_HOME
        echo "set -g XDG_CONFIG_HOME $XDG_CONFIG_HOME" >> $temp_config
    else
        echo "set -e XDG_CONFIG_HOME" >> $temp_config
    end

    # Remove welcome message
    echo 'set fish_greeting ""' >> $temp_config

    # Evaluates original config.fish
    if test -f $HOME/.config/fish/config.fish
        echo ". $HOME/.config/fish/config.fish" >> $temp_config
    end

    # Commands to run
    for line in $argv
        echo $line >> $temp_config
    end

    #echo "urxvt -e \"export XDG_CONFIG_HOME=$tempdir && fish -i\""
    echo "urxvt -e /bin/bash -c \"export XDG_CONFIG_HOME=$tempdir && fish -i\""

    # If only want to start a xterm, run this
    # i3-msg "exec xterm -e \"export XDG_CONFIG_HOME=$tempdir && fish -i\""

end



function i3exec_focus
    python3 $HOME/.i3/i3-exec-focus.py $argv
end



function ws
    i3-msg workspace number $argv > /dev/null
end

function rws
    i3-msg "rename workspace $argv[1] to \"$argv[1]:$argv[2]\"" > /dev/null
end

function s
    i3-msg split $argv > /dev/null
    sleep 0.2
end

function moveto
    i3-msg $argv[1] move workspace number $argv[2]
    sleep 0.2
end


# Hack for first start
set gvim (i3exec_focus gvim)
set ranger (i3exec_focus (xterm_cmd 'ranger'))


ws 1
rws 1 'browser'
i3exec_focus chromium


#ws 2
#rws 2 'mail'
#i3exec_focus (xterm_cmd ls)



ws 3
rws 3 'gvim'
#i3-msg $gvim move workspace number 3
moveto $gvim 3



ws 4
rws 4 'explorer'
moveto $ranger 4


ws 5
rws 5 'term'
set win ( i3exec_focus ( xterm_cmd ) )
s h
i3exec_focus ( xterm_cmd )
s v
i3exec_focus ( xterm_cmd )
i3-msg $win focus
s v
i3exec_focus ( xterm_cmd )



ws 6
rws 6 'gtypist'
i3exec_focus ( xterm_cmd 'gtypist -l R13' )



ws 7
rws 7 'vim tutor'
i3exec_focus gvim
s h
i3exec_focus 'okular $HOME/documentos/libros/vim/Pragmatic.Practical.Vim.Sep.2012.pdf'


ws 8
rws 8 'RSS / Twitter'
i3-msg 'layout tabbed'
#i3exec_focus 'bitcoin-qt'
i3exec_focus 'akregator'
