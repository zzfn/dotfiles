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

    sudo apt-get update
    sudo apt-get install -y zsh curl git tree android-tools-adb android-tools-fastboot python2.7 python3-pip python3-setuptools whois axel iputils-tracepath dnsutils libxml2-utils
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
    install-nvm() {
        echo "-----------------------------------------------------------"
        echo "* Installing NVM..."
        echo "-----------------------------------------------------------"

        curl https://get.volta.sh | bash
        volta install node
        echo "-----------------------------------------------------------"
        echo -n "* NVM Verision: "
        command -v node
    }

    install-node() {
        echo "-----------------------------------------------------------"
        echo "* Installing NodeJS 10..."
        echo "-----------------------------------------------------------"

        nvm install 10

        echo "-----------------------------------------------------------"
        echo "* Set NodeJS 10 as default..."
        echo "-----------------------------------------------------------"

        nvm use v10
        nvm alias default v10

        echo "-----------------------------------------------------------"
        echo -n "* NodeJS Version: "

        node -v
    }

    install-yarn() {
        echo "-----------------------------------------------------------"
        echo "* Installing Yarn..."
        echo "-----------------------------------------------------------"

        curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
        echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
        sudo apt-get update && sudo apt-get install --no-install-recommends yarn

        echo "-----------------------------------------------------------"
        echo -n "* Yarn Version: "

        yarn --version
    }

    yarn-global-add() {
        echo "-----------------------------------------------------------"
        echo "* Yarn Global Add those packages:"
        echo ""
        echo "  - http-server"
        echo "  - serve"
        echo "  - hexo-cli"
        echo "  - gulp-cli"
        echo "  - docsify-cli"
        echo "  - openload-cli"
        echo "  - now"
        echo "  - @upimg/cli"
        echo "-----------------------------------------------------------"

        yarn global add http-server serve hexo-cli gulp-cli docsify-cli openload-cli now @upimg/cli
    }


    echo "==========================================================="
    echo "              Setting up NodeJS Environment"

    install-nvm
    install-node
    install-yarn
    yarn-global-add
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
