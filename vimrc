execute pathogen#infect()
syntax on
set nocompatible
set modelines=0
set clipboard=unnamed

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set guifont=Consolas:h10,Monaco:h12,Inconsolata:h10
colorscheme solarized
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber

let mapleader = ","
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

inoremap jj <ESC>

silent execute '!mkdir "'.$VIMRUNTIME.'/temp"'
silent execute '!del "'.$VIMRUNTIME.'/temp/*~"'
set backupdir=$VIMRUNTIME/temp//
set directory=$VIMRUNTIME/temp//

filetype plugin on
set noshowmatch
set splitbelow

nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>a :Ack 
au BufRead,BufNewFile *.fs set filetype=fs
au BufRead,BufNewFile *.fsx set filetype=fs
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
let g:ctrlp_user_command = 'ag -i --nocolor --nogroup --hidden --ignore .git --ignore .svn --ignore .hg --ignore .DS_Store --ignore "**/*.pyc" --ignore "**/*.dll" --ignore "**/*.pdb" -g "" %s'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$',
  \ 'file': '\.exe$\|\.so$\|\.dat$'
  \ }
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ackprg = 'ag --nogroup --nocolor --column --ignore-case'
