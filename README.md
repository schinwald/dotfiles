![image](https://github.com/user-attachments/assets/36fde504-80a5-433f-a0ab-3790197b1165)

These are my dotfiles for both Ubuntu and MacOS computers. For those who don't know what dotfiles are, they are the hidden files (primarily in your home directory), that are used to configure your system. The purpose of this repository is for my records, as well as for sharing with others. I will probably extend this to other operating systems eventually, as I've come to enjoy trying out new distos! That being said, for now I'm content with just these operating systems.

## Setup

### Dependencies
- git
- ansible

### Clone

Before we get started, we need to clone the repository. I use a bare-repository for this, since it allows us to mount the repository to the home directory and avoid the use of any sort of linking. I've read this is a simple and effective alternative to solutions like GNU stow. I may need to consider linking eventually as files begin to bleed into other directories, but for now I'm happy with this setup (until I learn Nix).

Navigate to the home directory
```bash
cd ~/
```

Clone the repository as a bare-repository
```bash
git clone --bare git@github.com:schinwald/dotfiles.git $HOME/.dotfiles
```

Setup an alias for the verbose bare repository git command
```bash
alias df='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Make sure the bare repository is working correctly
```bash
df status
```

### Install

I use ansible playbooks to install everything. It has been a nice alternative to writing scripts for different operating systems. I've found that it is easier to maintain and extend especially with community plugins. Everything is much  more reproducible.

Install ansible galaxy dependencies
```bash
ansible-galaxy install -r ~/.setup/requirements.yml
```

Install everything else
```bash
ansible-playbook --ask-become-pass ~/.setup/playbooks
```

## Variants

On ubuntu you can add your startup files to `~/.xprofile` and they will be executed when you log in.
