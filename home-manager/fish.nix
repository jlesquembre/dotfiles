{
  config,
  pkgs,
  lib,
  username,
  ...
}:
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
      gw = "git worktree";
      gwa = "git_worktree_add";
      gwr = "git_worktree_remove";
      # gwa = {
      #   expansion = "git worktree add .worktree/%";
      #   setCursor = "%";
      # };

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
      nru = {
        expansion = "nix run github:NixOS/nixpkgs/nixos-unstable#%";
        setCursor = "%";
      };
      nsu = {
        expansion = "nix shell github:NixOS/nixpkgs/nixos-unstable#%";
        setCursor = "%";
      };
      nr = "nix run";
      nb = "nix build";
      nbu = {
        expansion = "nix build github:NixOS/nixpkgs/nixos-unstable#%";
        setCursor = "%";
      };

      nd = "nvd diff /run/current-system result";
      ndd = "nvd diff /nix/var/nix/profiles/per-user/${username}/home-manager result";

      # Others
      pi = "nix shell github:NixOS/nixpkgs/nixos-unstable#nodejs -c npx @mariozechner/pi-coding-agent";
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
      clju = "clj -A:outdated -a";
      clj-find-deps = "clj -A:find-deps -F:table -l 10";
      clj-rebel = "clojure -A:rebel";

      cljs = "clj -m cljs.main";
      cljs-repl = "clj -m cljs.repl.node";
      cljs-rebel = "clojure -A:rebel-cljs";

      "!!" = {
        position = "anywhere";
        function = "last_history_item";
      };
      y = {
        function = "_expand_yt-dlp";
      };
      ym = {
        function = "_expand_yt-dlp_m";
      };

    };

    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      # p = "prettyping --nolegend";
    };

    functions = {
      gww = ''
        set dir "$(git worktree list | fzf | awk '{print $1}')"
        if test -n "$dir"
            cd "$dir"
        end
      '';

      git_worktree_remove = ''
        set -l clean_icon "⠀" # NOTE: this is a unicode whitespace: \u2800 (Braille pattern blank)
        set -l dirty_icon "⚠"

        set -l items

        for wt_dir in (git worktree list --porcelain 2>/dev/null | grep '^worktree ' | awk '{print $2}' | rg '.worktree')
            set -l wt_icon $clean_icon
            if test (count (git -C "$wt_dir" status --porcelain 2>/dev/null)) -gt 0
                set wt_icon $dirty_icon
            end
            set -a items "$wt_icon:$wt_dir"
        end

        set -l out (printf '%s\n' $items | fzf --prompt="worktree remove> " --accept-nth 2 --with-nth '{1} {2}'  --delimiter : --expect=ctrl-d --footer="⚠ = dirty worktree (Ctrl-D to force delete)")

        set -l picked_dir $out[2]
        if test -z "$picked_dir"
            return 1
        end

        if test (count (git -C "$picked_dir" status --porcelain 2>/dev/null)) -gt 0
            if test "$key" != ctrl-d
                echo "Worktree is dirty: $picked_dir" >&2
                echo "Press Ctrl-D in fzf to force delete." >&2
                return 1
            end
            if test (pwd) = "$picked_dir"; cd (_git_worktree_root); end
            git worktree remove --force "$picked_dir"
            echo "--> git worktree remove --force $picked_dir"
        else
            if test (pwd) = "$picked_dir"; cd (_git_worktree_root); end
            git worktree remove "$picked_dir"
            echo "--> git worktree remove $picked_dir"
        end
      '';

      _git_worktree_root = ''
        git worktree list --porcelain 2>/dev/null | rg '^worktree ' | awk '{print $2}' | rg -v '.worktree'
      '';

      git_worktree_add = ''
        if test (count $argv) -ne 1
            echo "Usage: new_git_worktree <name>" >&2
            return 2
        end

        set -l new_tree "$argv[1]"
        set -l tree_path "$(_git_worktree_root)/.worktree/$new_tree"
        echo "--> " git worktree add "$tree_path" -b "$new_tree"
        git worktree add "$tree_path" -b "$new_tree"
        or begin
            return $status
        end

        cd "$tree_path"
      '';

      l = "eza --long --group --header --git --group-directories-first $argv";
      ll = "l --all --all $argv";
      lll = "l --all --tree --level 2 $argv";
      lookbusy = ''cat /dev/urandom | hexdump -C | grep --color "ca fe"'';
      srg = ''nvim -c "Grepper -jump -highlight -query '$argv'"'';
      passgen = "pwgen $argv";
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      denter = "docker exec -it $argv sh";
      w = "realpath (command -sa $argv)";
      last_history_item = "echo $history[1]";
      _expand_yt-dlp = ''
        set url (wl-paste)
        if string match -q -r '^http' "$url"
            set url (wl-paste -p)
        end
        echo -e "yt-dlp \"$url\""
      '';
      _expand_yt-dlp_m = ''
        set url (wl-paste)
        if string match -q -r '^http' "$url"
            set url (wl-paste -p)
        end
        echo -e "yt-dlp -x --audio-quality 0 \"$url\""
      '';

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

      fish_greeting = ''
        if not set -q WHATSUP
          set -gx WHATSUP 1
          ${pkgs.fastfetch}/bin/fastfetch -c ${../dotfiles/fastfetch.jsonc}
        end
      '';

      preexec = {
        body = "set -gx PAGE_BUFFER_NAME $argv";
        onEvent = "fish_preexec";
      };

      get_pwd = ''
        echo $PWD | sed -e "s|^$HOME|~|"
      '';

      prepend_to_command = ''
        set -l cmd (commandline -poc)
        if test "$cmd[1]" != "$argv"
            commandline -C 0
            commandline -i "$argv "
            commandline -f end-of-line
        end
      '';

      fish_user_key_bindings = ''
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
