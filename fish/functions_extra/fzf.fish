set fzf_preview_all '--preview "if test -d {};\
                                    tree -C {} | head -200;\
                                else;\
                                    file -ib {} | rg binary ^ /tmp/null; or bat --color always --style changes --paging never --line-range :200 {} ^ /dev/null;\
                                end;"'

set fzf_preview_dir '--preview "tree -C {} | head -200"'

set -x FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow'
set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -x FZF_CTRL_T_OPTS $fzf_preview_all

set -x FZF_ALT_C_COMMAND "fd -t d . $HOME"
set -x FZF_ALT_C_OPTS $fzf_preview_dir

set -x FZF_CTRL_R_OPTS '--preview "echo {}" --preview-window down:3:hidden --bind "?:toggle-preview"'

# function fshow
#   git log --graph --color=always \
#       --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$argv" | \
#   fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
#       --bind "ctrl-m:execute:
#                 (grep -o '[a-f0-9]\{7\}' | head -1 |
#                 xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
#                 {}
# FZF-EOF"
# end

function fssh -d "Fuzzy-find ssh host"
  set -q FZF_TMUX_HEIGHT; or set FZF_TMUX_HEIGHT 20%
    begin
      set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT +m"
      rg --ignore-case '^host [^*]' ~/.ssh/config | cut -d ' ' -f 2- | tr ' ' '\n' | eval (__fzfcmd) -q '(commandline)' | read -l result
      and commandline -- "ssh $result"
    end
    commandline -f repaint
end


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
