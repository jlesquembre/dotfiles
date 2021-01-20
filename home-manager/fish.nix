{ config, pkgs, lib, ... }:
let
  fishFunctionsDir = "${config.xdg.configHome}/fish/functions";
in
{
  programs.fish = {
    enable = true;

    # For the scripts you usually write like
    # status --is-interactive; and ...
    # promptInit = ''
    #   source (jump shell fish | psub)
    # '';

    # Override default fish functions
    interactiveShellInit = ''
      source ${fishFunctionsDir}/l.fish
      source ${fishFunctionsDir}/ll.fish
    '';

    shellAbbrs = {
      # Git
      g = "git";
      gcl = "git clone";
      gco = "git checkout";
      gcon = "git checkout -b";
      gss = "git switch";
      gsc = "git switch --create";
      grs = "git restore --";
      gf = "git fetch";
      gfa = "git fetch --all";
      gp = "git pull --ff-only";
      p = "git push";
      pp = "git push --set-upstream origin HEAD";
      pt = "git push --tags";
      pf = "git push --force-with-lease";
      gr = "git branch -d";
      grr = "git push origin --delete";
      gm = "git merge --ff-only";
      gd = "git diff";
      gdd = "git diff --staged";
      gsd = "git stash show -p";
      gs = "git status";
      grm = "git_delete_merged";

      # Docker
      d = "docker";
      dp = "docker ps";
      dpa = "docker ps --all";
      drm = "docker system prune --all --volumes";

      # K8S
      k = "kubectl";
      kc = "kubectx";
      kn = "kubens";
      kp = "kubeprompt";
      kg = "kubectl get";
      kga = "kubectl get all -o wide";
      kgi = "kubectl get ingress";
      ka = "kubectl apply -f";
      kd = "kubectl delete -f";

      # Nix
      ns = "nix_switch";
      nb = "nix_build";

      # Others
      s = "caddy file-server --browse --listen :8080";
      c = "bat";
      v = "nvim";
      r = "ranger";
      t = "terraform";
      diskspace_report = "df -P -kHl";
      disk_usage = "ncdu --color dark -r -x --exclude .git --exclude node_modules";
      myip = "dig +short myip.opendns.com @resolver1.opendns.com";
      dig-short = "dig +nocmd any +multiline +noall +answer";
      getip = "getent hosts";

      # Clojure
      cljs-repl = "clj -m cljs.repl.node";
      cljs = "clj -m cljs.main";
      clj-outdated = "clj -A:outdated -a";
      clj-rebel = "clojure -A:rebel";
      cljs-rebel = "clojure -A:rebel-cljs";
      clj-find-deps = "clj -A:find-deps -F:table -l 10";

    };

    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      # p = "prettyping --nolegend";
    };

    functions = {
      l = "exa --long --group --header --git --group-directories-first $argv";
      ll = "l --all --all $argv";
      lll = "l --all --tree --level 2 $argv";
      lookbusy = ''cat /dev/urandom | hexdump -C | grep --color "ca fe"'';
      srg = ''nvim -c "Grepper -jump -highlight -query '$argv'"'';
      passgen = "pwgen $argv";
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      denter = "docker exec -it $argv sh";
      w = "realpath (command -sa $argv)";


      fzf_preview_all = ''
        if test -d $argv
          tree -C $argv | head -200
        else
          file -ib $argv | rg binary ^ /tmp/null
          or bat --color always --style changes --paging never --line-range :200 $argv ^ /dev/null
        end
      '';

      # TODO unify with function in overlays
      # TODO do something like https://github.com/hlissner/dotfiles/blob/master/bin/hey
      nix_switch =
        ''
          set -lx BLACKBOX_REPOBASE $HOME/dotfiles;
          blackbox_postdeploy
          echo
          echo
          echo "sudo nixos-rebuild switch"
          sudo nixos-rebuild switch
          blackbox_shred_all_files
        '';

      nix_build =
        ''
          set -lx BLACKBOX_REPOBASE $HOME/dotfiles;
          blackbox_postdeploy
          echo
          echo
          echo "nixos-rebuild build"
          nixos-rebuild build
          blackbox_shred_all_files
        '';

      md = # mkdir + cd
        ''
          command mkdir -p $argv
          if test $status = 0
            switch $argv[(count $argv)]
              case '-*'
              case '*'
                cd $argv[(count $argv)]
                return
            end
          end
        '';

      # minikube
      minidocker = "fish -C 'functions -e fish_greeting; eval (minikube docker-env)'";

      fish_greeting =
        ''
          if not set -q WHATSUP
            set -gx WHATSUP 1
            ${pkgs.pfetch}/bin/pfetch
          end
        '';


      preexec = {
        body = "set -gx PAGE_BUFFER_NAME $argv";
        onEvent = "fish_preexec";
      };

      get_pwd =
        ''
          echo $PWD | sed -e "s|^$HOME|~|"
        '';

      prepend_to_command =
        ''
          set -l cmd (commandline -poc)
          if test "$cmd[1]" != "$argv"
              commandline -C 0
              commandline -i "$argv "
              commandline -f end-of-line
          end
        '';

      fish_user_key_bindings =
        ''
          bind \cc 'commandline ""'

          bind \ew 'prepend_to_command "watch"'

          bind \cs 'fssh'
        '';

      nix_prompt_txt =
        ''
          if test -n "$IN_NIX_SHELL"
            if test "$IN_NIX_SHELL" = "pure"
                set_color -b 0087af faf5e3
                printf " ❄ "
                set_color -b normal normal
            else
                set_color -b 897e01 faf5e3
                printf " ❄ "
                set_color -b normal normal
            end
          end
        '';

      fish_prompt = ''
        # $status gets nuked as soon as something else is run, e.g. set_color
        # so it has to be saved asap.   #echo "$prompt""$git_p"
        set -l last_status $status

        # Powerline Glyphs
        set FLSYM_LEFT_CLOSE "\uE0B0"
        set BG_NORMAL 444
        set BG_ERROR A22

        if test -n "$RANGER_LEVEL"
          # printf '[%sranger%s]' (set_color -o yellow) (set_color normal)
          set ranger_txt ' ranger'
        end

        if test "$DOCKER_CERT_PATH" = "$HOME/.minikube/certs"
          set minikube_txt ' minikube'
        end

        printf '%s%s%s @ %s%s%s in ' (set_color cyan) (whoami) (set_color normal) \
                                     (set_color yellow) (hostname|cut -d . -f 1) (set_color normal)

        if not test -w .
          printf '%s%s ' (set_color red) ''
        end

        # printf '%s%s%s%s' (set_color e0c060) (get_pwd) (set_color normal) (__fish_git_prompt)
        printf '%s%s %s%s' (set_color e0c060) (get_pwd) (githud) (set_color normal)

        echo ""

        set k8s_txt (kubeprompt -f default)
        # set k8s_txt (~/projects/kubeprompt/bin/kubeprompt -f default)

        nix_prompt_txt
        printf "$k8s_txt"
        if test $last_status = 0
            #printf '%s%s%s' (set_color green) '✔  ' (set_color normal)
            set_color -b $BG_NORMAL
            printf "$ranger_txt$minikube_txt → "
            set_color $BG_NORMAL -b normal
        else
            #printf '%s%s%s' (set_color red) '✗  ' (set_color normal)
            set_color -b $BG_ERROR
            printf "$ranger_txt$minikube_txt $last_status "
            set_color $BG_ERROR -b normal
        end
        printf $FLSYM_LEFT_CLOSE
        set_color normal -b normal
        printf " "
      '';

      fish_right_prompt =
        ''
          set -l last_duration (echo $CMD_DURATION | humanize_duration)
          set -l now (date "+%T %F")
          printf "$now [ $last_duration ]"
        '';

      humanize_duration =
        ''
          if not string length --quiet $argv
               set --erase argv
               read --line argv
          end
          set hours (math --scale=0 $argv/\(3600 \*1000\))
          set mins (math --scale=0 $argv/\(60 \*1000\) % 60)
          set secs (math --scale=0 $argv/1000 % 60)
          if test $hours -gt 0
              set --append output $hours"h"
          end
          if test $mins -gt 0
              set --append output $mins"m"
          end
          if test $secs -gt 0
              set --append output $secs"s"
          end
          if not set --query output
              echo $argv"ms"
          else
              echo $output
          end
        '';

    };

    plugins = [
      # Move to funtions, git repo moves too much
      # {
      #   name = "humanize_duration";
      #   src =
      #     let
      #       file = pkgs.fetchurl {
      #         url = "https://raw.githubusercontent.com/fishpkg/fish-humanize-duration/master/humanize_duration.fish";
      #         sha256 = "0qvhafrddymhry7k7k8ib1mkda600gsbpa22fza3q7i01ja0cw0a";
      #       };
      #     in
      #     pkgs.runCommand "humanize_duration"
      #       { } ''
      #       mkdir -p $out/functions
      #       cp ${file} $out/functions/humanize_duration.fish
      #     '';
      # }

      # TODO unify with function in overlays, as previous examples
      {
        name = "custom_functions";
        src = ../dotfiles/fish;
      }

    ];
  };
}
