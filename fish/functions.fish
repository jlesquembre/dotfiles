# Don't limit yourself to fish, use cool bash script too
function extract --description 'Extract archives'
    bash $HOME/.config/fish/utils.bash "extract" $argv
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

function aur_build --description 'Builds a package from the AUR'
    switch (count $argv)
        case 1
            set aur_url "https://aur.archlinux.org/packages"
            set name $argv[1]
            set directory (echo $name | cut -c -2)
            set tar_file $name.tar.gz

            set tgz_url "$aur_url/$directory/$name/$tar_file"

            wget $tgz_url
            if test $status -ne 0
                echo "'$name' was not found in the AUR repository"
                return 1
            end

            if test -d $name
                rm -r $name
            end

            tar -xzf $tar_file
            cd $name
            makepkg

            set packages (command ls *.tar.xz)
            mv *.tar.xz ..

            cd ..
            rm $tar_file

            echo ""
            echo "To install run:"
            for package in $packages
                echo "sudo pacman -U $package"
            end
            echo ""

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


#### Sack ####

set -x SACK_EDITOR gvim
set -x SACK_SHORTCUT /tmp/.sack_shortcuts

function sag --description 's(hortcut)-ag'
    bash $HOME/dotfiles/fish/extras/sack/sack -ag $argv
end

function F --description 'Open s(hortcut)-ag file'
    bash $HOME/dotfiles/fish/extras/sack/F $argv
end
