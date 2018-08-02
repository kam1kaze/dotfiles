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

" extends " and @ in normal mode and <CTRL-R> in insert mode so you can see the contents of the registers
Plug 'junegunn/vim-peekaboo'

" enable repeating supported plugin maps with "."
Plug 'tpope/vim-repeat'

Plug 'ntpeters/vim-better-whitespace'
Plug 'editorconfig/editorconfig-vim'

" File manager
Plug 'justinmk/vim-dirvish'

" hybrid line numbers
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" Colors
Plug 'lifepillar/vim-solarized8'

" Status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Such feature is enabled in 0.2.0 version be default
" https://github.com/neovim/neovim/wiki/Following-HEAD#20170402
"Plug 'jszakmeister/vim-togglecursor'

" VCS
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Snippets
"Plug 'SirVer/ultisnips' " Temp
"Plug 'honza/vim-snippets' " Temp
function! DoRemote(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  !pip3 install --user --upgrade neovim
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote')}
Plug 'wellle/tmux-complete.vim' " completion of words in adjacent tmux panes
""" not maintained anymore :(
"Plug 'roxma/nvim-completion-manager',
"  \ { 'do': 'pip3 install --user --upgrade neovim psutil setproctitle' }

" Run code linters and compilers
"Plug 'neomake/neomake'
Plug 'w0rp/ale'

" vim plugin to interact with tmux
Plug 'benmills/vimux'

" curl queries
Plug 'nicwest/vim-http'

" Languages

" the following plugins already in sheerun/vim-polyglot
" Plug 'plasticboy/vim-markdown'
" Plug 'vim-ruby/vim-ruby'
Plug 'hashivim/vim-terraform' " wanna to use plugin for :TerraformFmt
Plug 'juliosueiras/vim-terraform-completion'
" Plug 'martinda/Jenkinsfile-vim-syntax'
" Plug 'chr4/nginx.vim'
Plug 'sheerun/vim-polyglot'
"Plug 'ekalinin/Dockerfile.vim' " conflict with vim-polyglot
Plug 'saltstack/salt-vim'
Plug 'thecodesmith/groovyindent-unix'

" Add plugins to &runtimepath
call plug#end()

""" General settings
set wildmenu
set number relativenumber
set hidden
set colorcolumn=150 " Line length highlighting
set diffopt=filler,vertical
set autoread
set mouse=a

" (Optional)Hide Info(Preview) window after completions
" TODO: fix conflict with command-line window with Ctrl-f
" https://github.com/maralla/completor.vim/commit/6350a367baec6904a5f6e2005a9f5da2aaae311b
"autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" create directories on save if neccessary
au BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')

" Set python3 host (i.e executable) to speedup startup time
let g:python3_host_prog = '/usr/local/bin/python3'

""" Plug dirvish
let g:dirvish_relative_paths = 0

""" Plug 'w0rp/ale'
let g:ale_sign_error = 'EE'
let g:ale_sign_warning = 'WW'
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" bash scripts
"let g:neomake_sh_enabled_makers = ['shellcheck']
"let g:neomake_sh_shellcheck_args = ["-x"] +  neomake#makers#ft#sh#shellcheck()['args']
let g:ale_sh_shellcheck_options = '-x'

let g:ale_ruby_rubocop_options = "-S" " Display style guide URLs in offense messages
let g:ale_fixers = {'ruby': ['rubocop']}

""" Plug 'nicwest/vim-http'
let g:vim_http_split_vertically = 1

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

""" Indenting source code
" http://vim.wikia.com/wiki/Indenting_source_code
set expandtab " pressing the <TAB> key will always insert 'softtabstop' amount of space characters
set shiftwidth=2 " affects what happens when you press >>, << or ==
set softtabstop=2
" copy the indentation from the previous line, when starting a new line. It can be useful for structured text files, or when you want to control
" most of the indentation manually, without Vim interfering.
set autoindent
" enable file type based indentation
filetype plugin indent on

" Allow backspacing everything in insert mode
set backspace=2

" shows partial off-screen results in a preview window for |:substitute|-like commands
" https://www.youtube.com/watch?v=dY9dME3l-iQ
set inccommand=split

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
"autocmd! BufWritePost,BufEnter * Neomake

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
autocmd! BufNewFile,BufRead *.tfstate set filetype=json

" vault configuration
autocmd! BufNewFile,BufRead */vault_config/*.hcl set filetype=terraform

""" openstack
autocmd! BufNewFile,BufRead *.hot set filetype=yaml

""" nginx
autocmd! BufNewFile,BufRead */*nginx/*.conf set filetype=nginx
autocmd! BufNewFile,BufRead */*nginx/*.inc set filetype=nginx
autocmd FileType nginx set foldmethod=marker

" Clear highlighting on escape in normal mode
nnoremap <silent><esc> :noh<return><esc>

" Shows the effects of a command incrementally, as you type
" https://github.com/neovim/neovim/pull/5561/files
if has('nvim')
  set inccommand=nosplit
endif
