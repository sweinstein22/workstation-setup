scriptencoding utf-8

" Homebrew's python is externally managed (PEP 668), so pynvim cannot be installed
" into it. dev-setup.sh puts it in a virtualenv instead; point neovim at that.
let s:python_host = expand('~/.local/share/nvim-venv/bin/python3')
if executable(s:python_host)
  let g:python3_host_prog = s:python_host
endif
