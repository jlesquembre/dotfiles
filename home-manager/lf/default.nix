{ config, pkgs, lib, nix-medley, host-options, inputs, system, rootPath, username, ... }:

# SEE
# https://github.com/gokcehan/lf/blob/master/doc.md

let
  previewer =
    # https://github.com/horriblename/lfimg-sixel/blob/master/preview
    pkgs.writeShellScript "previewer" ''
      file=$1
      w=$2
      h=$3
      x=$4
      y=$5

      if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
          geometry="$(($2-2))x$3"
          ${pkgs.chafa}/bin/chafa "$1" -f sixel -s "$geometry" --animate false
          # ${pkgs.swayimg}/bin/swayimg -g $x,$y,$w,$h "$1"
          exit 1
      fi

      pistol "$file"
    '';
in

{

  # :  read (default)  builtin/custom command
  # $  shell           shell command
  # %  shell-pipe      shell command running with the ui
  # !  shell-wait      shell command waiting for key press
  # &  shell-async     shell command running asynchronously

  xdg.configFile."lf/icons".source = "${pkgs.lf.src}/etc/icons.example";

  programs.lf = {
    enable = true;
    commands = {

      open = ''
        ''${{
          case $(file --mime-type -Lb $f) in
            image/*)
              swayimg -a $fx
              ;;
            text/*)
              nvim $fx
              ;;
            *)
              for f in $fx; do xdg-open $f; done
              ;;
          esac
        }}
      '';

      extract = ''
        ''${{
          set -f
          atool -x $f
        }}
      '';

      mp3 = ''
        ''${{
          set -f
          outname=$(echo "$f" | cut -f 1 -d '.')
          ${pkgs.lame}/bin/lame -V --preset standard $f "''${outname}.mp3"
        }}
      '';

      mobi = ''
        ''${{
            set -f
            for book in $fx; do
              outname=$(echo "$book" | cut -f 1 -d '.')
              ${pkgs.calibre}/bin/ebook-convert "$book" "''${outname}.mobi"
            done
        }}
      '';

      on-cd = ''
        &{{
          # display git repository status in your prompt
          source ${pkgs.git}/share/git/contrib/completion/git-prompt.sh
          GIT_PS1_SHOWDIRTYSTATE=auto
          GIT_PS1_SHOWSTASHSTATE=auto
          GIT_PS1_SHOWUNTRACKEDFILES=auto
          GIT_PS1_SHOWUPSTREAM=auto
          GIT_PS1_COMPRESSSPARSESTATE=auto
          git=$(__git_ps1 " [GIT BRANCH:> %s]") || true
          fmt="\033[32;1m%u@%h\033[0m:\033[34;1m%w\033[0m\033[33;1m$git\033[0m"
          lf -remote "send $id set promptfmt \"$fmt\""
        }}
      '';

      fzf_search = ''
        ''${{
          RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
          res="$(
              FZF_DEFAULT_COMMAND="$RG_PREFIX '''" \
                  fzf --bind "change:reload:$RG_PREFIX {q} || true" \
                  --ansi --layout=reverse --header 'Search in files' \
                  | cut -d':' -f1 | sed 's/\\/\\\\/g;s/"/\\"/g'
          )"
          [ -n "$res" ] && lf -remote "send $id select \"$res\""
        }}
      '';

      bulkrename = ''
        ''${{
            nvim .
        }}
      '';

      open-with-gui = "&$@ $fx";
      open-with-cli = "$$@ $fx";

      mkdir = ''
        ''${{
            printf "Directory Name: "
            read ans
            mkdir "$ans"
        }}
      '';

      mkfile = ''
        ''${{
            printf "File Name: "
            read ans
            touch "$ans"
        }}
      '';

    };
    # Free space on device from CWD
    # df -Ph . | tail -1 | awk '{print $4}'
    keybindings = {

      # K = "push %mkdir<space>";
      # N = "push %touch<space>";
      K = "mkdir";
      N = "mkfile";

      H = "set hidden!";
      "<enter>" = "open";
      gh = "cd ~";
      gp = "cd /tmp";
      gc = "push :cd<space>";

      gs = ":fzf_search";

      gn = "%wezterm cli spawn --cwd $PWD -- lf";
      gt = "%wezterm cli activate-tab --tab-relative 1";

      i = ":rename; cmd-delete-home";
      I = ":rename; cmd-end; cmd-delete-home";
      R = ":bulkrename";

      ss = "calcdirsize";

      "<delete>" = ":delete";

      # o = "push :open-with-cli<space>";
      # O = "push :open-with-gui<space>";
      o = "push $<space>$f<home>";
      O = "push &<space>$f<home>";
    };

    settings = {
      previewer = builtins.toString previewer;
      preview = true;
      hidden = true;
      drawbox = true;
      icons = false;
      ignorecase = true;
      sixel = true;
      # cursorpreviewfmt = "\\033[7;2m";
      # cursorpreviewfmt = "\\033[7;90m";
      cursorpreviewfmt = "";
      info = "size";
      ifs = "\\n";
      rulerfmt = ''  %a|  %p|  %d|  \033[7;31m %m \033[0m|  \033[7;33m %c \033[0m|  \033[7;35m %s \033[0m|  \033[7;34m %f \033[0m|  %i/%t'';
    };
  };

  programs.pistol = {
    enable = true;
    associations = [
      {
        mime = "audio/*";
        command = "${pkgs.mediainfo}/bin/mediainfo %pistol-filename%";
      }
      {
        mime = "video/*";
        command = "${pkgs.mediainfo}/bin/mediainfo %pistol-filename%";
      }
    ];
  };

}
