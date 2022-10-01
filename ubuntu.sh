#!/bin/bash

start() {
    clear
    cd $HOME
}

install-linux-packages() {
    echo "==========================================================="
    echo "* Install following packages:"
    echo ""
    echo "  - zsh"
    echo "  - curl"
    echo "  - git"
    echo "-----------------------------------------------------------"

    sudo apt update
    sudo apt install -y zsh curl git tree
    sudo chsh -s /bin/zsh
}

clone-repo() {
    echo "-----------------------------------------------------------"
    echo "* Cloning dotfiles Repo from GitHub.com"
    echo "-----------------------------------------------------------"

    git clone https://github.com/zzfn/dotfiles.git
    cd ./dotfiles || exit
    rm -rf .git
}


setup-omz() {
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}


install-nodejs() {
        echo "-----------------------------------------------------------"
        echo "* Installing NVM..."
        echo "-----------------------------------------------------------"

        curl https://get.volta.sh | bash
        volta install node
        source ~/.bashrc
        echo "-----------------------------------------------------------"
        echo -n "* NVM Verision: "
        node -v
        echo "-----------------------------------------------------------"
}

zshrc() {
    echo "==========================================================="
    echo "                  Import sukka env zshrc                   "
    echo "-----------------------------------------------------------"

    cat ./_zshrc/wsl-ubuntu.zshrc > $HOME/.zshrc
}

upgrade-packages() {
    echo "==========================================================="
    echo "                      Upgrade packages                     "
    echo "-----------------------------------------------------------"

    sudo apt-get update && sudo apt-get upgrade -y
    pip install --upgrade pip
    npm i -g npm
}

chmod() {
    sudo chmod u+s /bin/ping
    sudo chmod u+s /usr/sbin/traceroute
}

finish() {
    echo "==========================================================="
    echo "> Sukka Enviroment Setup finished!"
    echo "> Do not forget run those things:"
    echo ""
    echo "- chsh -s /usr/bin/zsh"
    echo "- npm login"
    echo "- ci-edit-update"
    echo "- oload-config"
    echo "- git-config"
    echo "- we .netrc"
    echo "==========================================================="
}

start
install-linux-packages
clone-repo
setup-omz
install-nodejs
lazygit
install-nali
install-ctop
thefuck
ci_editor
zshrc
chmod
upgrade-packages
finish
