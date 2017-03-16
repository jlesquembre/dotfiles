function nix_update
    echo "git fetch --all"
    git -C /etc/nixos/nixpkgs fetch --all

    echo "git checkout local"
    git -C /etc/nixos/nixpkgs checkout local

    echo "git rebase channels/nixos-unstable"
    git -C /etc/nixos/nixpkgs rebase channels/nixos-unstable local

    echo "In case of errors try 'rebase -p', 'merge --ff-only' or to recreate local branch"
end


# Do a release branch
# -------------------

#git checkout -b ${name}_local channels/nixos-unstable

# Do changes....

#git checkout -b ${name} ${name}_local  # last part is optional
#git rebase upstream/master
#git push ${name}
#git checkout local
#git merge --ff-only ${name}_local
