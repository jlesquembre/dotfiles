# Extract archives - use: extract <file>
# Based on https://github.com/paulirish/dotfiles/blob/master/.functions
function extract() {
    if [ -f "$1" ] ; then
        local filename=$(basename "$1")
        local foldername="${filename%%.*}"
        local fullpath=`perl -e 'use Cwd "abs_path";print abs_path(shift)' "$1"`
        local didfolderexist=false
        if [ -d "$foldername" ]; then
            didfolderexist=true
            read -p "$foldername already exists, do you want to overwrite it? (y/n) " -n 1
            echo
            if [[ $REPLY =~ ^[Nn]$ ]]; then
                return
            fi
        fi
        mkdir -p "$foldername" && cd "$foldername"
        case $1 in
            *.tar.bz2) tar xjf "$fullpath" ;;
            *.tar.gz) tar xzf "$fullpath" ;;
            *.tar.xz) tar Jxvf "$fullpath" ;;
            *.tar.Z) tar xzf "$fullpath" ;;
            *.tar) tar xf "$fullpath" ;;
            *.taz) tar xzf "$fullpath" ;;
            *.tb2) tar xjf "$fullpath" ;;
            *.tbz) tar xjf "$fullpath" ;;
            *.tbz2) tar xjf "$fullpath" ;;
            *.tgz) tar xzf "$fullpath" ;;
            *.txz) tar Jxvf "$fullpath" ;;
            *.zip) unzip "$fullpath" ;;
            *.rar) unrar x "$fullpath" ;;
            *) echo "'$1' cannot be extracted via extract()" && cd .. && ! $didfolderexist && rm -r "$foldername"
               exit ;;
        esac
        # Check number of files/folders, if only one, remove created folder for extract
        local filenumber=$(find -maxdepth 1 -mindepth 1 | wc -l)
        if [ $filenumber == "1" ] ; then
            local uniquefile=$(find -maxdepth 1 -mindepth 1)
            if [ ! $didfolderexits ] ; then
                local tmpname="aaabbbcccsdf23fgreg2dfg445"
                cd .. && mv $foldername $tmpname && cd $tmpname && mv $uniquefile .. && cd .. && rmdir $tmpname
            fi
        fi
    else
        echo "'$1' is not a valid file"
    fi
}

function test_(){
    echo "args: $@"
}

function main() {

    echo "$@"
    local cmd="$1"
    shift
    case $cmd in
        extract )
            extract $@
            ;;
        * )
            echo "Don't know what todo!"
            ;;
    esac
}


main $@
