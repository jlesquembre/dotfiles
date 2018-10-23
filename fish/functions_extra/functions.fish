# Don't limit yourself to fish, use cool bash script too
function extract --description 'Extract archives'
    bash $HOME/.config/fish/functions_extra/utils.bash "extract" $argv
end

#function compress_videos --description 'Compress all videos in directory'
#    bash $HOME/.config/fish/utils.bash "compress_videos" $argv
#end

function compress_videos --description 'Find and compress videos'

    set use_time 0
    set low_res 0

    for item in $argv
        switch "$item"
          case "use_time"
            set use_time 1
          case "low_res"
            set low_res 1
          case '*'
            echo 'Only valid arguments are "use_time" and "low_res"'
            return 1
        end
    end

    # echo "Use time -> $use_time -- Low res -> $low_res"

    for path in ( find (pwd) -type f \( -iname "*.mp4" -or -iname "*.mts" -or -iname "*.webm" \)  )
        set -l dirname ( dirname "$path" )
        set -l name ( basename "$path"  | rev | cut -d. -f2- | rev )

        if test $use_time -eq 1
            set newname ( ffprobe "$path" 2>&1 | grep -i creation_time | head -1 | cut -d: -f2- | date +"%Y-%m-%d_%H_%M_%S" -f - )
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

        if test $low_res -eq 1
          echo "$cmd -i '$escaped_path' -c:v libx265 -preset placebo -x265-params crf=32 -c:a libopus -b:a 128k '$escaped_new_file'"
        else
          echo "$cmd -i '$escaped_path' -c:v libx265 -preset placebo -x265-params crf=23 -c:a libopus -b:a 160k '$escaped_new_file'"
        end
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

function clone --description "clone something, cd into it. install it."
  git clone $argv[1]
  cd (basename $argv[1] | sed 's/.git$//')
  # yarn install
end

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

function sudo!!
  eval sudo $history[1]
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


function nixcd -d 'cd to nix store executable'
  cd (dirname (readlink -f (command -s $argv[1])) | sed 's/bin$//')
end
complete --command nixcd -f --arguments '(__fish_complete_command)'


function git_delete_merged
  set branches_to_die (git branch --no-color --merged origin/master | rg -v '\smaster$' | rg -v '\slocal$' | rg -v '^\*')
  echo "Local branches to be deleted:"
  printf '%s\n'  $branches_to_die
  echo ""

  set remote_branches_to_die (git branch --no-color --remotes --merged origin/master | \
                              rg -v '\smaster$' | rg -v '/master$' | rg -v 'origin/HEAD' | rg -v 'origin/master' | \
                              rg -v '/local' | rg --color never '\sorigin/' )
  echo "Remote branches to be deleted:"
  printf '%s\n' $remote_branches_to_die

  echo ""
  echo "Enter Y to confirm"

  read confirm

  if test $confirm = "Y"

    for branch in $branches_to_die
      git branch -d (string trim $branch)
    end

    for branch in $remote_branches_to_die
      git push origin --delete (string trim $branch | sed "s/origin\///")
      # set -l remote_names $remote_names (string trim $branch | sed "s/origin\///")
    end
    # git push origin --delete $remote_names

    echo ""
    echo "Pruning all remotes"
    git remote | xargs -n 1 git remote prune

  else
    echo "Cancel!"
    return 1
  end
end

function pg_load-db --description 'Load DB dump into a docker container'
  # It expects the file name to have this format: `YYYYMMDD_HHMMSS_$DBUSER_$DBNAME.dump`
  switch (count $argv)
    case 1
      set -l filename $argv[1]
      set -l name (basename $filename  | rev | cut -d. -f2- | rev | cut -d_ -f3- )
      set -l db_user (echo "$name" | cut -d_ -f1)
      set -l db_name (echo "$name" | cut -d_ -f2)

      set -l exists (docker ps -q -f name="^/psql_db\$")
      if test -n exists
        read -l -P 'Container "psql_db" exists. Delete it and continue? [y/N] ' confirm
        switch $confirm
            case Y y
              # docker stop psql_db
              # docker wait psql_db
              docker rm --force --volumes psql_db
            case '*'
              echo 'Cancel by user'
              return 1
          end
        end
        # docker run --name psql_db -p 5555:5432 -e POSTGRES_DB=$db_name -e POSTGRES_PASSWORD=pass -e POSTGRES_USER=$db_user -d healthcheck/postgres:alpine
        docker run --name psql_db -p 5555:5432 -e POSTGRES_DB=$db_name \
        -e POSTGRES_PASSWORD=pass -e POSTGRES_USER=$db_user \
        --health-cmd=pg_isready -d postgres:alpine
        set -l db_uri "postgresql://$db_user:pass@localhost:5555/$db_name"
        set -l counter 0
        while test (docker inspect --format='{{.State.Health.Status}}' psql_db) != 'healthy'; and test $counter -lt 10
          printf "."
          set counter (math $counter + 1)
          sleep 0.3
        end
        echo ""
        pg_restore -v -d "$db_uri" $filename
        echo -e "\nTo connect to the database:"
        echo "psql $db_uri"
        return 0

    case 0
      echo 'Provide a valid dump filename'
      echo 'Usage: pg_load-db [DB_DUMP]'
      return 1

    case '*'
      echo 'Too many arguments!'
      echo 'Usage: pg_load-db [DB_DUMP]'
      return 1
  end
end


# Navigation
function ..    ; cd .. ; end
function ...   ; cd ../.. ; end
function ....  ; cd ../../.. ; end
function ..... ; cd ../../../.. ; end
function l     ; exa --long --group --header --git $argv ; end
function ll    ; exa --long --group --header --git --all --all $argv ; end
function lll   ; exa --long --group --header --git --all --tree --level 2 $argv ; end

# Utilities
function c        ; bat $argv ; end
# function c        ; pygmentize -O style=monokai -f console256 -g $argv ; end
function g        ; git $argv ; end
function lookbusy ; cat /dev/urandom | hexdump -C | grep --color "ca fe" ; end
function srg      ; nvim -c "Grepper -jump -highlight -query '$argv'" ; end
function passgen -d 'Alias for pwgen' ; pwgen $argv; end;
#function grep     ; command grep --color=auto $argv ; end
alias push="git push"
alias diskspace_report="df -P -kHl"
alias disk_usage 'ncdu --color dark -r -x --exclude .git --exclude node_modules'
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias dig-short="dig +nocmd any +multiline +noall +answer"
alias getip="getent hosts"
alias v="nvim"
alias r="ranger"
alias p="prettyping --nolegend"


# Some abbreviations
abbr -a g 'git'
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
abbr -a grm 'git_delete_merged'
abbr -a drm 'docker system prune --all --volumes'

function _clj-deps
  for dep in $argv
    set deps "$deps $dep {:mvn/version \"RELEASE\"}"
  end
  set deps "{:deps {$deps}}"
  echo $deps
end

# clj aliasses
alias   cljs-repl='clj -m cljs.repl.node'
abbr -a cljs-repl 'clj -m cljs.repl.node'

alias   cljs='clj -m cljs.main'
abbr -a cljs 'clj -m cljs.main'

alias   clj-outdated='clj -A:outdated'
abbr -a clj-outdated 'clj -A:outdated'

alias   clj-rebel 'clojure -A:rebel'
abbr -a clj-rebel 'clojure -A:rebel'
function clj-rebel-extra -d 'clj repl with extra deps'
  clojure -Sdeps (_clj-deps $argv) -A:rebel
end

alias   cljs-rebel 'clojure -A:rebel-cljs'
abbr -a cljs-rebel 'clojure -A:rebel-cljs'
function cljs-rebel-extra -d 'clj repl with extra deps'
  clojure -Sdeps (_clj-deps $argv) -A:rebel
end

alias   clj-find-deps 'clj -A:find-deps -F:table -l 10'
abbr -a clj-find-deps 'clj -A:find-deps -F:table -l 10'
