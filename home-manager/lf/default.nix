{
  config,
  pkgs,
  lib,
  nix-medley,
  host-options,
  inputs,
  system,
  rootPath,
  username,
  ...
}:

# SEE
# https://github.com/gokcehan/lf/blob/master/doc.md

let
  previewer = pkgs.writeShellApplication {
    name = "lf-previewer";
    runtimeInputs = with pkgs; [
      file
      kitty.kitten
      pistol
    ];
    text = ''
      file_path=$1
      w=$2
      h=$3
      x=$4
      y=$5

      case "$(file -Lb --mime-type "$file_path")" in
        image/*)
          # Use explicit placement so lf layout is not disturbed.
          # lf previewer convention: return 1 when preview is drawn directly to tty
          # (so lf does not try to render stdout preview text on top of it).
          if kitten icat --stdin no --transfer-mode memory --place "''${w}x''${h}@''${x}x''${y}" "$1" </dev/null >/dev/tty 2>/dev/null; then
            exit 1
          fi
          ;;
      esac

      pistol "$file_path"
    '';
  };

  cleaner = pkgs.writeShellApplication {
    name = "lf-cleaner";
    runtimeInputs = with pkgs; [ kitty.kitten ];
    text = ''
      exec kitten icat --clear --stdin no --transfer-mode memory </dev/null >/dev/tty
    '';
  };

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

    # cmd in lf
    commands = {

      open = ''
        &{{
          case $(file --mime-type -Lb $f) in
            image/*)
              ristretto $fx
              ;;
            video/*)
              mpv $fx
              ;;
            text/* | inode/x-empty)
              lf -remote "send $id \$nvim \$fx"
              ;;
            application/zip | application/gzip | application/x-tar)
              lf -remote "send $id extract \$fx"
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

      mkdir = ''%IFS=" "; mkdir -- "$*"'';
      touch = ''%IFS=" "; touch -- "$*"'';

    };
    # Free space on device from CWD
    # df -Ph . | tail -1 | awk '{print $4}'

    # map in lf
    keybindings = {

      K = "push :mkdir<space>";
      N = "push :touch<space>";

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

    # cmap in lf
    cmdKeybindings = {
      "<tab>" = "cmd-menu-complete";
      "<backtab>" = "cmd-menu-complete-back";
    };

    settings = {
      previewer = "${previewer}/bin/lf-previewer";
      cleaner = "${cleaner}/bin/lf-cleaner";
      preview = true;
      hidden = true;
      drawbox = true;
      icons = false;
      ignorecase = true;
      # cursorpreviewfmt = "\\033[7;2m";
      # cursorpreviewfmt = "\\033[7;90m";
      cursorpreviewfmt = "";
      info = "size";
      ifs = "\\n";
      rulerfile = builtins.toString (
        pkgs.writeText "lf-ruler" ''
          {{with .Message -}}
              {{. -}}
          {{else with .Stat -}}
              {{.Permissions | printf "\033[36m%s\033[0m" -}}
              {{with .LinkCount}} {{.}}{{end -}}
              {{with .User}} {{.}}{{end -}}
              {{with .Group}} {{.}}{{end -}}
              {{.Size | humanize | printf " %5s" -}}
              {{.ModTime | printf " %s" -}}
              {{with .Target}} -> {{.}}{{end -}}
          {{end -}}
          {{.SPACER -}}
          {{with .Keys}}  {{.}}{{end -}}
          {{with .Progress}}  {{join . " "}}{{end -}}
          {{with .Copy}}  {{len . | printf "%s %d \033[0m" $.Options.copyfmt}}{{end -}}
          {{with .Cut}}  {{len . | printf "%s %d \033[0m" $.Options.cutfmt}}{{end -}}
          {{with .Select}}  {{len . | printf "%s %d \033[0m" $.Options.selectfmt}}{{end -}}
          {{with .Visual}}  {{len . | printf "%s %d \033[0m" $.Options.visualfmt}}{{end -}}
          {{with .Filter}}  {{join . " " | printf "\033[7;34m %s \033[0m"}}{{end -}}
          {{printf "%s  %d/%d" (df) .Index .Total}}
        ''
      );
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
