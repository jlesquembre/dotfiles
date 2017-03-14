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

function compress_videos(){

    # shopt -s nocaseglob -> case insensitive match

    # See http://unix.stackexchange.com/a/9499
    find . -type f \( -iname "*.mp4" -or -iname "*.mts" \) -print0 | while IFS= read -r -d '' path
    do
      # file=$(basename $path)
      filename="${path##*/}"
      videoname="${filename%.*}"

      newvideo=$( ffprobe ${filename} 2>&1 | grep -i creation_time | head -1 | cut -d: -f2- | date +"%Y-%m-%d_%H:%M:%S" -f -; exit ${PIPESTATUS[1]} )
      if [[ $? != 0 ]]; then
        newvideo="${videoname}"
      fi

      newvideo="${newvideo}.mkv"

      echo "$filename -> $newvideo"
      if [ -e "$newvideo" ]
      then
        echo "$newvideo already exists, skiping"
      else
        #ffmpeg -i "${filename}" -c:v libx265 -preset medium -x265-params crf=23 -c:a libopus -b:a 160k "${videoname}_medium_23.mkv"
        #ffmpeg -i "${filename}" -c:v libx265 -preset medium -x265-params crf=23 -c:a copy "${videoname}_medium_23_audio_original.mkv"
        #ffmpeg -i "${filename}" -c:v libx265 -preset medium -x265-params crf=20 -c:a libopus -b:a 160k "${videoname}_medium_20.mkv"
        echo "ffmpeg -i '${filename}' -c:v libx265 -preset placebo -x265-params crf=23 -c:a libopus -b:a 160k '${newvideo}'"
      fi

    done
    exit 0

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
        compress_videos )
            compress_videos $@
            ;;
        * )
            echo "Don't know what todo!"
            ;;
    esac
}


main $@
