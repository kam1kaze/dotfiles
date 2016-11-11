" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
call plug#begin('~/.config/nvim/plugged')

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'

Plug 'ntpeters/vim-better-whitespace'

" Colors
Plug 'lifepillar/vim-solarized8'

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" VCS
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" Run code linters and compilers
Plug 'neomake/neomake'

" Languages
Plug 'plasticboy/vim-markdown'
Plug 'vim-ruby/vim-ruby'
Plug 'ekalinin/Dockerfile.vim'
Plug 'hashivim/vim-terraform'

" Add plugins to &runtimepath
call plug#end()

""" General settings
set wildmenu
set number
set hidden
set colorcolumn=150 " Line length highlighting
set diffopt=filler,vertical
set autoread
set mouse=a
set completeopt=longest,menuone,preview

" bash scripts
let b:is_bash = 1 " Force to use bash syntax for all sh scipts
let g:neomake_sh_enabled_makers = ['shellcheck']
let g:neomake_sh_shellcheck_args = ["-x"] +  neomake#makers#ft#sh#shellcheck()['args']

" Colors
syntax enable
colorscheme solarized8_dark_high

" Copy buffer to system clipboard
noremap <Leader>y "*y
noremap <Leader>p "*p
noremap <Leader>Y "+y
noremap <Leader>P "+p

" From https://github.com/rakr/vim-one
" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
" (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
" For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
" Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
  if (exists($TMUX))
    " https://github.com/lifepillar/vim-solarized8
    set t_8f=[38;2;%lu;%lu;%lum
    set t_8b=[48;2;%lu;%lu;%lum
    "let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    "let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
endif

" Set tab size
set expandtab
set tabstop=2 shiftwidth=2 softtabstop=2
set autoindent

" Allow backspacing everything in insert mode
set backspace=2

" Shortcuts to vimdiff
" http://stackoverflow.com/questions/7309707/why-does-git-mergetool-opens-4-windows-in-vimdiff-id-expect-3
let mapleader=','
let g:mapleader=','

if &diff
   map <leader>1 :diffget LOCAL<CR>
   map <leader>2 :diffget BASE<CR>
   map <leader>3 :diffget REMOTE<CR>
endif

""" Plugins
" FZF
map <leader>t :Files<CR>
map <leader>b :Buffers<CR>

" airline
let g:airline#extensions#tabline#enabled = 1

" neomake
autocmd! BufWritePost,BufEnter * Neomake

""" deoplete
let g:deoplete#enable_at_startup = 1
" tab-complete
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

""" airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

""" terraform
autocmd BufNewFile,BufRead *.tfstate set filetype=json
