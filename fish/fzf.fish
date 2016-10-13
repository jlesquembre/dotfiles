function fcd --description 'fzf cd'
    set -l tempfile (mktemp)
    #locate -Ai -0 $argv | grep -z -vE '~$' | fzf --read0 -0 -1 > $tempfile
    locate -Ai -0 $argv | fzf --read0 -0 -1 > $tempfile
    #if test (cat $tempfile | wc -l) -gt 0
    if test ! -s $tempfile
        echo "Canceled, nothing to do!"
    else
        set -l file (cat $tempfile)
        if test -d $file
            cd $file
        else
            cd (dirname $file)
        end
    end
    rm $tempfile
end

# Not too useful
function fcdd --description 'fzf cd (only match basename)'
    set -l tempfile (mktemp)
    locate -Ai -0 -b $argv | fzf --read0 -0 -1 > $tempfile
    #if test (cat $tempfile | wc -l) -gt 0
    if test ! -s $tempfile
        echo "Canceled, nothing to do!"
    else
        set -l file (cat $tempfile)
        if test -d $file
            cd $file
        else
            cd (dirname $file)
        end
    end
    rm $tempfile
end


function fo --description 'open file using fzf and rifle (CTRL-V for vim)'
    set -l tempfile (mktemp)
    locate -Ai -0 $argv | fzf --read0 -0 -1 --expect=ctrl-v > $tempfile

    if test ! -s $tempfile
        echo "Canceled, nothing to do!"
    else
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
    end
    rm $tempfile
end
