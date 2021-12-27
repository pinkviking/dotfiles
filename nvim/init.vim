" -------------------------------------------------------------------
" Options
" -------------------------------------------------------------------
set nocompatible            " disable compatibility to old-time vi
set hidden
set showmatch               " show matching
set ignorecase              " case insensitive
set mouse=v                 " middle-click paste with
set hlsearch                " highlight search
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=80                   " set an 80 column border for good coding style
filetype plugin indent on   " allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.

set splitright
set splitbelow

" -------------------------------------------------------------------
" Plugins
" -------------------------------------------------------------------
call plug#begin("~/.vim/plugged")
 source ~/.config/nvim/plugins/dracula.vim
 source ~/.config/nvim/plugins/nerdcommenter.vim
 source ~/.config/nvim/plugins/vim-startify.vim
 source ~/.config/nvim/plugins/vim-fugitive.vim
 source ~/.config/nvim/plugins/nerdtree.vim
 source ~/.config/nvim/plugins/vim-airline.vim
 source ~/.config/nvim/plugins/fzf.vim
 source ~/.config/nvim/plugins/vim-devicons
call plug#end()

" -------------------------------------------------------------------
" Mappings
" -------------------------------------------------------------------
let mapleader = ' '

noremap <Leader>gf :e <cfile><CR>

map <Leader>nt :NERDTreeToggle<CR>
map <Leader>nf :NERDTreeFocus<CR>

noremap <Leader>ff :Files<CR>
noremap <Leader>fw :Windows<CR>
noremap <Leader>fb :Buffers<CR>

map <Leader>j :tabr<CR>
map <Leader>k :tabl<CR>
map <Leader>h :tabp<CR>
map <Leader>l :tabn<CR>

