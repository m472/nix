rebuild:
    git add .
    git commit -m'config updated'
    sudo nixos-rebuild switch --flake /home/matz/nix/#nixos-macbook
