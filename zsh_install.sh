#!/bin/bash

# 安装并配置zsh
function zsh_install() {
    echo "Configure zsh"

    if ! [ -d "$HOME/.oh-my-zsh" ]; then
        if ! git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"; then
            echo "ERROR: 克隆 oh-my-zsh 失败" >&2
            return 1
        fi
    fi

    # 备份已有 zshrc，并保留其内容用于后续合并
    if [ -e "$HOME/.zshrc" ]; then
        if ! cp "$HOME/.zshrc" "$HOME/.zshrc.orig"; then
            echo "ERROR: 备份 $HOME/.zshrc 失败，请检查权限或磁盘空间" >&2
            return 1
        fi
        echo "已备份旧 zshrc 到 $HOME/.zshrc.orig"
    fi

    # 用模板作为新的 .zshrc
    if ! cp "$HOME/.oh-my-zsh/templates/zshrc.zsh-template" "$HOME/.zshrc"; then
        echo "ERROR: 复制 zsh 模板到 $HOME/.zshrc 失败，请检查 $HOME/.oh-my-zsh 是否存在" >&2
        return 1
    fi

    # 合并：把旧 zshrc 的内容追加到新模板之后，保留用户自定义设置
    if [ -e "$HOME/.zshrc.orig" ]; then
        if ! cat "$HOME/.zshrc.orig" >> "$HOME/.zshrc"; then
            echo "ERROR: 合并旧 zshrc 到新模板失败" >&2
            return 1
        fi
        echo "已将旧 zshrc 合并到新模板"
    fi

    if ! chsh -s "$(which zsh)"; then
        echo "ERROR: chsh 失败，请手动切换默认 shell" >&2
        return 1
    fi

    if ! echo "source $HOME/.profile" >> "$HOME/.zshrc"; then
        echo "ERROR: 追加 source $HOME/.profile 失败" >&2
        return 1
    fi

    if ! sed -i 's/ZSH_THEME=\".*\"/ZSH_THEME=\"crcandy\"/g' "$HOME/.zshrc"; then
        echo "ERROR: 设置 zsh 主题失败" >&2
        return 1
    fi

    if [ -e ./zshrc ]; then
        if ! cat ./zshrc >> "$HOME/.zshrc"; then
            echo "ERROR: 追加 ./zshrc 失败" >&2
            return 1
        fi
    fi

    echo "Configure zsh OK!"
    echo "NOTICE: Please log out from your user session and log back in to see this change"
}

zsh_install
