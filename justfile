set shell := ["fish", "-c"]

git-autocommit:
    -git add .
    -git commit -m'config updated'

rebuild: git-autocommit
    sudo nixos-rebuild switch --flake /home/matz/nix/#nixos-macbook

lock: git-autocommit
    nix flake lock
