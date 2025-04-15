#!/bin/bash

echo "🔧 初始化 WSL2 開發環境"

echo "📦 更新套件列表..."
sudo apt update

echo "📥 安裝 wget..."
sudo apt install -y wget

echo "🈶 安裝中文字型..."
sudo apt install -y \
    fonts-noto-cjk \
    fonts-wqy-zenhei \
    fonts-wqy-microhei \
    fonts-arphic-ukai \
    fonts-arphic-uming

echo "🌐 安裝繁體中文語系..."
sudo apt install -y language-pack-zh-hant
sudo update-locale LANG=zh_TW.UTF-8
sudo locale-gen zh_TW zh_TW.UTF-8
source /etc/default/locale

echo "🐳 安裝 Docker..."
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER

echo "💻 安裝 Zsh + Oh My Zsh..."
sudo apt install -y zsh git
chsh -s $(which zsh)

echo "🌈 安裝 Oh My Zsh..."
export RUNZSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sed -i 's/ZSH_THEME=".*"/ZSH_THEME="agnoster"/' ~/.zshrc

echo "📦 安裝 thefuck 指令修正工具..."
sudo apt install -y python3-dev python3-pip
pip3 install --user thefuck
echo 'eval "$(thefuck --alias)"' >> ~/.zshrc

echo "🟢 安裝 Node.js（LTS）..."
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

echo "🐍 安裝 Python 3.12..."
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt update
sudo apt install -y python3.12 python3.12-venv python3.12-dev
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.12 1

echo "🔁 設定 pip 為 python3.12 對應版本..."
curl -sS https://bootstrap.pypa.io/get-pip.py | sudo python3.12

echo "✅ 中文測試：繁體中文顯示正常。"
echo "⚙️ 開發工具安裝完成，請重新啟動 WSL 以套用 docker 群組與 zsh 設定。"
