set shell := ["fish", "-c"]

git-autocommit:
    git add .

rebuild: git-autocommit
    sudo nixos-rebuild switch --flake .#

lock: git-autocommit
    nix flake lock

optimise:
    nix-store --optimise
