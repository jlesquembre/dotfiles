set fzf_preview_all '--preview "file -ib {} | rg binary | rg -v inode/ ^ /tmp/null; or pygmentize -O style=monokai -f console256 -g {} ^ /dev/null; or tree -C {} | head -200"'
set fzf_preview_dir '--preview "tree -C {} | head -200"'

set -x FZF_CTRL_T_OPTS $fzf_preview_all
set -x FZF_ALT_C_OPTS $fzf_preview_dir
set -x FZF_CTRL_R_OPTS '--preview "echo {}" --preview-window down:3:hidden --bind "?:toggle-preview"'


function _run_fzf_cmd
    set -l tempfile $argv[1]
    set -l cmd $argv[2]
    if test (count $argv) -eq 2
        set -l args 'NULL'
    else
        set -l args $argv[3..-1]
    end
    eval $cmd > $tempfile

    set -l last_status $status

    if test $last_status -eq 130
        echo "Canceled, nothing to do!"
    end

    if test $last_status -eq 1
        echo "No match for '$args'"
    end

    return $last_status

end


function fo --description 'open file using fzf and rifle (CTRL-V for vim)'
    # Without args, get all files
    if test (count $argv) -eq 0; set argv '\*'; end
    set -l cmd "locate -Ai -0 $argv | fzf --read0 -0 -1 --expect=ctrl-v --header='Open file with rifle (CTRL-V for vim)' $fzf_preview_all"

    set -l tempfile (mktemp)
    _run_fzf_cmd $tempfile $cmd $argv; set -l last_status $status
    if test $last_status -ne 0; rm $tempfile; return $last_status
    end

    set -l key (cat $tempfile | head -1)
    set -l file (cat $tempfile | tail -1)

    if test "$key" = "ctrl-v"
        nvim "$file"
    else
        if test -d $file
            cd $file
        else
            rifle "$file"
        end
    end
    rm $tempfile
end


function fcd -d 'fzf cd'
    #locate -Ai -0 $argv | grep -z -vE '~$' | fzf --read0 -0 -1 > $tempfile
    if test (count $argv) -eq 0; set argv '\*'; end
    set -l cmd "locate -Ai -0 $argv | fzf --read0 -0 -1 $fzf_preview_all"

    set -l tempfile (mktemp)
    _run_fzf_cmd $tempfile $cmd $argv; set -l last_status $status
    if test $last_status -ne 0; rm $tempfile; return $last_status
    end

    set -l file (cat $tempfile)
    if test -d $file
        cd $file
    else
        cd (dirname $file)
    end
    rm $tempfile
end


# Not too useful
function fcdd --description 'fzf cd (only match basename)'
    if test (count $argv) -eq 0; set argv '\*'; end
    set -l cmd "locate -Ai -0 -b $argv | fzf --read0 -0 -1 $fzf_preview_all"

    set -l tempfile (mktemp)
    _run_fzf_cmd $tempfile $cmd $argv; set -l last_status $status
    if test $last_status -ne 0; rm $tempfile; return $last_status
    end

    set -l file (cat $tempfile)
    if test -d $file
        cd $file
    else
        cd (dirname $file)
    end
    rm $tempfile
end


function fkill --description 'kill with fzf'
    #set -l cmd "ps -ef | sed 1d | fzf -m | awk '{print \$2}'"
    set -l cmd "ps -ef | sed 1d | fzf -m"

    set -l tempfile (mktemp)
    _run_fzf_cmd $tempfile $cmd; set -l last_status $status
    if test $last_status -ne 0; rm $tempfile; return $last_status
    end

    set -l pid (cat $tempfile | tr -s ' ' | cut -d' ' -f 2)
    set -l command (cat $tempfile | tr -s ' ' | cut -d' ' -f 8-)
    echo "Killing command: '$command' with PID: $pid"
    kill $pid
    rm $tempfile

end


function jj -d 'autojump with fzf'
    if test (count $argv) -eq 0; set argv ''; end
    set -l cmd "autojump -s | head -n -7 | sort -nr | awk '{print \$2}' | fzf +s --query=\"$argv\" $fzf_preview_dir"

    set -l tempfile (mktemp)
    _run_fzf_cmd $tempfile $cmd; set -l last_status $status
    if test $last_status -ne 0; rm $tempfile; return $last_status
    end

    cd (cat $tempfile)
    rm $tempfile
end


function fp -d 'pew workon with fzf'
    if test (count $argv) -eq 0; set argv ''; end
    set -l cmd "ls $HOME/.local/share/virtualenvs | fzf -1 --query=\"$argv\""

    set -l tempfile (mktemp)
    _run_fzf_cmd $tempfile $cmd; set -l last_status $status
    if test $last_status -ne 0; rm $tempfile; return $last_status
    end

    pew workon (cat $tempfile)
    rm $tempfile
end
