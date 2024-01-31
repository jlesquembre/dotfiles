{ config, pkgs, lib, username, ... }:
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
      set -x SHELL /run/current-system/sw/bin/fish
      source ${fishFunctionsDir}/l.fish
      source ${fishFunctionsDir}/ll.fish
    '';

    shellAbbrs = {

      # Git
      g = "git";
      gcl = "git clone";
      gco = "git checkout";
      gcon = "git checkout -b";
      gs = "git switch";
      gsc = "git switch --create";
      gre = "git restore --";
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
      gdt = "git difftool";
      gdd = "git diff --staged";
      gds = "git stash show -p";
      gst = "git status";
      grm = "git_delete_merged";

      # Docker
      d = "podman";
      dp = "podman ps";
      dpa = "podman ps --all";
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
      nru = "nix run github:NixOS/nixpkgs/nixos-unstable#";
      nsu = "nix shell github:NixOS/nixpkgs/nixos-unstable#";
      nr = "nix run";
      nb = "nix build";
      nbu = "nix build github:NixOS/nixpkgs/nixos-unstable#";

      nd = "nvd diff /run/current-system result";
      ndd = "nvd diff /nix/var/nix/profiles/per-user/${username}/home-manager result";

      # Others
      s = "caddy file-server --browse --listen :8080";
      c = "bat";
      v = "nvim";
      r = "lf";
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
      l = "eza --long --group --header --git --group-directories-first $argv";
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
    };

    plugins = [
      # TODO unify with function in overlays, as previous examples
      {
        name = "custom_functions";
        src = ../dotfiles/fish;
      }

    ];
  };
}
