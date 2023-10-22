{ config, pkgs, lib, nix-medley, host-options, inputs, system, rootPath, username, ... }:


{

  ## ${{ }}  Regular shell command
  ## %{{ }}
  ## &{{ }}
  ## :{{ }}



  xdg.configFile."lf/icons".source = "${pkgs.lf.src}/etc/icons.example";

  programs.lf = {
    enable = true;
    commands = {
      editor-open = ''$$EDITOR $f'';
      mkdir = ''
        ''${{
          printf "Directory Name: "
          read DIR
          mkdir $DIR
        }}
      '';
      open = ''
        ''${{
          case $(file --mime-type -Lb $f) in
            image/*) swayimg -a $fx;;
            text/*) nvim $fx;;
            *) for f in $fx; do xdg-open $f > /dev/null 2> /dev/null & done;;
          esac
        }}
      '';
    };

    keybindings = {

      "\\\"" = "";
      o = "";
      c = "mkdir";
      "." = "set hidden!";
      "`" = "mark-load";
      "\\'" = "mark-load";
      "<enter>" = "open";

      do = "dragon-out";

      gh = "cd";
      "g/" = "/";

      ee = "editor-open";
      V = ''$${pkgs.bat}/bin/bat --paging=always --theme=gruvbox "$f"'';

      # ...
    };

    settings = {
      preview = true;
      hidden = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
      sixel = true;
      # cursorpreviewfmt = "\\033[7;2m";
      # cursorpreviewfmt = "\\033[7;90m";
      cursorpreviewfmt = "";
    };

    extraConfig =
      let
        previewer =
          # swayimg ??
          # https://github.com/horriblename/lfimg-sixel/blob/master/preview
          pkgs.writeShellScriptBin "pv.sh" ''
            file=$1
            w=$2
            h=$3
            x=$4
            y=$5

            if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
                # ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
                geometry="$(($2-2))x$3"
                # geometry="$2x$3"
                ${pkgs.chafa}/bin/chafa "$1" -f sixel -s "$geometry" --animate false
                # chafa "$1" -f sixel -s "$geometry" --animate false
                # ${pkgs.swayimg}/bin/swayimg -g $x,$y,$w,$h "$1"
                exit 1
            fi

            ${pkgs.pistol}/bin/pistol "$file"
          '';
        # cleaner = pkgs.writeShellScriptBin "clean.sh" ''
        #   ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
        # '';
      in
      # set cleaner ${cleaner}/bin/clean.sh
      ''
        set previewer ${previewer}/bin/pv.sh
      '';
  };

  programs.pistol = {
    enable = true;
  };

}
