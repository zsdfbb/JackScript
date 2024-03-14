# My Path
export PATH=/snap/bin/:$PATH

# CUDA configuration
if [[ -a /usr/local/cuda/bin ]]; then
    export PATH=/usr/local/cuda/bin:$PATH
fi
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=/usr/lib/wsl/lib:$LD_LIBRARY_PATH

# rust configuration
export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup

# My Alias
alias date='date +%Y-%m-%d'

alias cdd='cd ${HOME}/Develop'
alias cdms='cd ${HOME}/Develop/myscript'
alias cdai='cd ${HOME}/Develop/AI_RAG'

