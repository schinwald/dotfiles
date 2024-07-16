![image](https://github.com/user-attachments/assets/36fde504-80a5-433f-a0ab-3790197b1165)

These are my dotfiles for both Ubuntu and MacOS systems. I will probably extend this for other systems as I see fit, but for now I'm content with just these systems. This repository should be installed as a bare-repository to allow it to mount to the home directory and avoid the use of any linking. This is what I have read to be the simplist method for installing between systems (at least until I learn Nix).

## Installation

The installation process is a WIP since there are many ways the installation can go wrong.

### Clone
Clone the repository as a bare-repository
```bash
cd ~/
git clone --bare git@github.com:schinwald/dotfiles.git $HOME/.dotfiles
alias df='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
df config --local status.showUntrackedFiles no
df status
```

### Setup

#### Ubuntu
```bash
~/setup/ubuntu/install.sh
```

#### MacOS
```bash
~/setup/mac/install.sh
```
