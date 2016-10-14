function _run_fzf_cmd
    set -l tempfile $argv[1]
    set -l cmd $argv[2]
    set -l args $argv[3..-1]
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
    set -l cmd "locate -Ai -0 $argv | fzf --read0 -0 -1 --expect=ctrl-v --header='Open file with rifle (CTRL-V for vim)'"

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
    set -l cmd "locate -Ai -0 $argv | fzf --read0 -0 -1"

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
    set -l cmd "locate -Ai -0 -b $argv | fzf --read0 -0 -1"

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
    set -l cms "ps -ef | sed 1d | fzf -m | awk '{print $2}'"

    set -l tempfile (mktemp)
    _run_fzf_cmd $tempfile $cmd $argv; set -l last_status $status
    if test $last_status -ne 0; rm $tempfile; return $last_status
    end

    kill (cat $tempfile)
    rm $tempfile

end
