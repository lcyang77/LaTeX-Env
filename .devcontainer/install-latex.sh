#!/bin/bash

# 错误处理
set -e
trap 'echo "Error occurred at line $LINENO. Exit code: $?"' ERR

# 日志函数
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

# 检查是否为 root 用户
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

# 安装前检查
log "Checking available disk space..."
REQUIRED_SPACE=10000000  # 约10GB
AVAILABLE_SPACE=$(df -k / | awk 'NR==2 {print $4}')
if [ $AVAILABLE_SPACE -lt $REQUIRED_SPACE ]; then
    echo "Insufficient disk space. Need at least 10GB"
    exit 1
fi

# 更新系统
log "Updating package lists..."
apt-get update -q
apt-get upgrade -y -q

# 安装基础包
log "Installing TeX Live and basic tools..."
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    texlive \
    texlive-latex-recommended \
    texlive-latex-extra \
    latexmk \
    pandoc \
    python3-pip \
    librsvg2-bin \
    pandoc-citeproc \
    libreoffice \
    fonts-noto-cjk \
    poppler-utils

# 安装 Python 工具
log "Installing Python packages..."
pip3 install --no-cache-dir pandoc-latex-environment

# 配置字体缓存
log "Updating font cache..."
fc-cache -fv

# 清理
log "Cleaning up..."
apt-get clean
rm -rf /var/lib/apt/lists/*
pip3 cache purge

# 验证安装
log "Verifying installation..."
REQUIRED_COMMANDS=("xelatex" "latexmk" "pandoc" "python3")
for cmd in "${REQUIRED_COMMANDS[@]}"; do
    if ! command -v $cmd &> /dev/null; then
        log "Error: $cmd is not installed properly"
        exit 1
    fi
done

log "Installation completed successfully!"

# 创建测试文件
log "Creating test document..."
cat > test.tex << 'EOL'
\documentclass{article}
\usepackage{ctex}
\begin{document}
Installation Test - 安装测试
\end{document}
EOL

# 测试编译
log "Testing compilation..."
if xelatex -interaction=nonstopmode test.tex; then
    log "Test compilation successful!"
    rm -f test.*
else
    log "Test compilation failed!"
    exit 1
fi

# 为环境检查脚本赋予执行权限
chmod +x /workspaces/$(basename $PWD)/check-environment.sh
