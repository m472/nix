set shell := ["fish", "-c"]

@list:
    just --list

git-autocommit:
    git add .

rebuild: git-autocommit
    sudo nixos-rebuild switch --flake .#

lock: git-autocommit
    nix flake lock

optimise:
    nix-store --gc
    nix-store --optimise -vv
