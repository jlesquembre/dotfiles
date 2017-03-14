# Don't limit yourself to fish, use cool bash script too
function extract --description 'Extract archives'
    bash $HOME/.config/fish/functions_extra/utils.bash "extract" $argv
end

#function compress_videos --description 'Compress all videos in directory'
#    bash $HOME/.config/fish/utils.bash "compress_videos" $argv
#end

function compress_videos --description 'Find and compress videos'

    switch (count $argv)
        case 0
            set use_time 0
        case 1

            if test $argv[1] = "use_time"
                set use_time 1
            else
                echo 'Only valid argument is "use_time"'
                return 1
            end
        case '*'
            echo 'Too many arguments'
            return 1
    end

    for path in ( find (pwd) -type f \( -iname "*.mp4" -or -iname "*.mts" \)  )
        set -l dirname ( dirname "$path" )
        set -l name ( basename "$path"  | rev | cut -d. -f2- | rev )

        if test $use_time -eq 1
            set newname ( ffprobe "$path" 2>&1 | grep -i creation_time | head -1 | cut -d: -f2- | date +"%Y-%m-%d_%H:%M:%S" -f - )
        else
            set newname ( echo "$name")
        end
        set -l fps (ffprobe -v error -select_streams v:0 -show_entries stream=avg_frame_rate -of default=noprint_wrappers=1:nokey=1 $path)

        set -l new_file ( echo "$dirname/$newname.mkv")

        set cmd 'ffmpeg'
        if test -e "$new_file"; set cmd "#$cmd"; end
        if test $fps != '25/1'; set cmd "$cmd -r $fps"; end

        set -l escaped_path (echo "$path" | sed "s/'/\\\'/g")
        set -l escaped_new_file (echo "$new_file" | sed "s/'/\\\'/g")

        echo "$cmd -i '$escaped_path' -c:v libx265 -preset placebo -x265-params crf=23 -c:a libopus -b:a 160k '$escaped_new_file'"
    end
end



function jltar --description 'Compress a directory'
    switch (count $argv)
        case 0
            tar -zc ./* > (basename $PWD).tgz
        case 1
            tar -zc $argv[1] > (basename $argv[1]).tgz
        case 2
            tar -zc $argv[1] > $argv[2]
        case '*'
            echo 'To many arguments'
    end
end


function __get_gpg_args
    set gpg_id_path $HOME/.password-store/.gpg-id
    if test ! -e $gpg_id_path
        echo "ERROR: You must run: \"pass init your-gpg-id\" before you may use this function."
        return 1
    end
    set -e gpg_args
    cat $gpg_id_path | while read gpg_id
        if [ $gpg_id != "" ]
            set gpg_args $gpg_args '-r' $gpg_id
        end
    end
    echo $gpg_args
end


function jletar --description 'Compress and encrypts a directory'
    set gpg_args (__get_gpg_args)
    if test $status != 0
        return $status
    end

    switch (count $argv)
        case 0
            tar -zc ./* | gpg --encrypt $gpg_args > (basename $PWD).tgz.gpg
        case 1
            tar -zc $argv[1] | gpg --encrypt $gpg_args > (basename $argv[1]).tgz.gpg
        case 2
            tar -zc $argv[1] | gpg --encrypt $gpg_args > $argv[2].gpg
        case '*'
            echo 'To many arguments'
    end
end


function jldtar --description 'Decrypts a tar file'
    switch (count $argv)
        case 1
            gpg --decrypt < $argv[1] | tar -xz
        case '*'
            echo 'Not valid options'
    end
end


function jlmakepkg --description 'Archlinux package build utility'
    mkdir -p /tmp/makepkg/_src
    makepkg -f PKGDEST=$HOME/aur SRCDEST=/tmp/makepkg/_src BUILDDIR=/tmp/makepkg
    set -l last_status $status
    if test $last_status -ne 0
        return $last_status
    end
    set packages (command ls ./*.tar.xz)
    if [ "$argv" != 'NODELETE' ]
        rm $packages
    end
end


function aur_build --description 'Builds a package from the AUR'
    switch (count $argv)
        case 1
            set name $argv[1]
            set aur_url "ssh://aur@aur.archlinux.org/"{$name}".git"
            set git_dir $HOME/aur/$name

            git ls-remote --exit-code $aur_url > /dev/null
            if test $status -ne 0
                echo "'$name' was not found in the AUR repository"
                return 1
            end

            git clone $aur_url $git_dir
            if test $status -ne 0
                echo "##### git clone failed! Try a git pull"
                git -C $git_dir pull --ff-only
                if test $status -ne 0
                    echo "##### ERROR on $git_dir"
                    return 1
                end
            end

            #fish subshell
            fish -c "cd $git_dir; jlmakepkg NODELETE"
            set -l last_status $status
            if test $last_status -ne 0
                return $last_status
            end
            set packages (command ls $git_dir/*.tar.xz)

            rm -rf /tmp/makepkg/
            rm $git_dir/*.tar.xz

            echo ""
            echo "To install run:"
            for package in $packages
                echo "sudo pacman -U ~/aur/"(basename $package)""
            end
            echo ""
            return 0

        case 0
            echo 'Provide a valid AUR package as argument'
            echo 'Usage: aur_build [AUR_PAKAGE_NAME]'
            return 1

        case '*'
            echo 'Too many arguments!'
            echo 'Usage: aur_build [AUR_PAKAGE_NAME]'
            return 1
    end
end


function pyclean --description 'Remove python bytecode'
    find . -name "*.pyc" -delete
    find . -name __pycache__ -exec rm -rf {} \;
end


function __get_new_image_name
    set timestamp ( dcraw -i -v $argv[1] | grep 'Timestamp: ' | sed 's/Timestamp: //g' )
    echo ( date -d"$timestamp" -Iseconds | sed 's/+.*$//' )
end

function nef2jpeg

    for nef in *.NEF
        set newfile ( __get_new_image_name $nef).jpg
        echo "$nef -> $newfile"
        dcraw -c -w $nef | cjpeg -quality 90 -optimize > $newfile
        # archlinux package perl-image-exiftool
        #exiftool -tagsFromFile $nef -exif:all --subifd:all $newfile
    end
end

function nef2webp

    for nef in *.NEF
        set newfile ( __get_new_image_name $nef).webp
        echo "$nef -> $newfile"
        #dcraw -c -w -T $nef | cwebp -o - -- - > $newfile
        dcraw -c -w -T $nef > /tmp/tmp_cwebp.tiff
        # exif extraction from tiff is not supported by cwebp
        # -metadata exif
        cwebp -quiet -q 90 /tmp/tmp_cwebp.tiff -o $newfile
    end
end


set here (dirname (status -f))

##   https://github.com/garaud/sack.git
#### Sack ####

set -x SACK_EDITOR gvim
set -x SACK_SHORTCUT /tmp/.sack_shortcuts

function sag --description 's(hortcut)-ag'
    bash $here/extras/sack/sack -ag $argv
end

function F --description 'Open s(hortcut)-ag file'
    bash $here/extras/sack/F $argv
end


##  https://github.com/StackExchange/blackbox.git
#### Blackbox ####

set -x PATH $PATH $here/extras/blackbox/bin


## https://github.com/nvbn/thefuck
#### thefuck ####

set -x THEFUCK_REQUIRE_CONFIRMATION true

function fuck --description 'Correct your previous console command'
    set -l exit_code $status
    set -l eval_script (mktemp 2>/dev/null ; or mktemp -t 'thefuck')
    set -l fucked_up_commandd $history[1]
    thefuck $fucked_up_commandd > $eval_script
    . $eval_script
    rm $eval_script
    if test $exit_code -ne 0
        history --delete $fucked_up_commandd
    end
end


#function chpwd --on-variable PWD --description 'handler of changing $PWD'
#  if not status --is-command-substitution ; and status --is-interactive
#
#    set cur_cwd (echo $PWD | sed -e "s|^$HOME|~|" -e 's|^/private||')
#
#    # set_color -o black
#    # printf (printf "%*s" (tput cols)) | sed -e "s/ /\─/g";
#    echo ""
#    printf "%s⇢ %sEntering %s%s%s …\n" (set_color $fish_color_cwd) (set_color normal) (set_color $fish_color_cwd) $cur_cwd (set_color normal)
#    ls
#
#  end
#end


function md --wraps mkdir -d "Create a directory and cd into it"
  command mkdir -p $argv
  if test $status = 0
    switch $argv[(count $argv)]
      case '-*'
      case '*'
        cd $argv[(count $argv)]
        return
    end
  end
end


function server -d 'Start a HTTP server in the current dir, optionally specifying the port'
    if test $argv[1]
        set port $argv[1]
    else
        set port 8000
    end

    open "http://localhost:$port/" &
    http-server -p "$port" .
end


# Navigation
function ..    ; cd .. ; end
function ...   ; cd ../.. ; end
function ....  ; cd ../../.. ; end
function ..... ; cd ../../../.. ; end
function l     ; tree --dirsfirst -aFCNL 1 $argv ; end
function ll    ; tree --dirsfirst -ChFupDaLg 1 $argv ; end

# Utilities
function c        ; pygmentize -O style=monokai -f console256 -g $argv ; end
function g        ; git $argv ; end
function lookbusy ; cat /dev/urandom | hexdump -C | grep --color "ca fe" ; end
function srg      ; nvim -c "Grepper -jump -highlight -query '$argv'" ; end
function passgen -d 'Alias for pwgen' ; pwgen $argv; end;
#function grep     ; command grep --color=auto $argv ; end
alias push="git push"
alias diskspace_report="df -P -kHl"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias dig="dig +nocmd any +multiline +noall +answer"
alias v="nvim"
alias r="ranger"


# Some abbreviations
abbr -a gcl 'git clone'
abbr -a gco 'git checkout'
abbr -a gcon 'git checkout -b'
abbr -a gf 'git fetch'
abbr -a gfa 'git fetch --all'
abbr -a gp 'git pull --ff-only'
abbr -a gpp 'git push'
abbr -a gps 'git push --set-upstream origin (git rev-parse --abbrev-ref HEAD)'
abbr -a gr 'git branch -d'
abbr -a grr 'git push origin --delete'
abbr -a gm 'git merge --ff-only'
abbr -a gd 'git diff'
abbr -a gdd 'git diff --staged'
abbr -a gsd 'git stash show -p'
abbr -a gs 'git status'