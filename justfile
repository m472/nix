set shell := ["fish", "-c"]

git-autocommit:
    git add .

rebuild: git-autocommit
    sudo nixos-rebuild switch --flake .#nixos-macbook

lock: git-autocommit
    nix flake lock
