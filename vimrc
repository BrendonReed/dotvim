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

colorscheme pencil
"colorscheme github
"colorscheme desert
"vimdiff colorscheme
"highlight DiffAdd cterm=none ctermfg=green ctermbg=black
"highlight DiffDelete cterm=none ctermfg=darkred ctermbg=black
"highlight DiffChange cterm=none ctermfg=none ctermbg=black
"highlight DiffText cterm=none ctermfg=black ctermbg=darkyellow

set encoding=utf-8
setglobal fileencoding=utf-8
set listchars=tab:▸\ ,eol:¬
set list
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
set nu


let mapleader = ","
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set hlsearch
nnoremap <tab> %
vnoremap <tab> %

set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

inoremap jj <ESC>

if has("win32") || has("win64")
    set directory=$TMP
    set backupdir=$TMP
else
    set directory=/tmp
    set backupdir=/tmp
end
filetype plugin on
set noshowmatch
set splitbelow

nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>a :Ack 

set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
cnoremap <expr> %% expand('%:h').'/'
map <leader>e :edit %%
map <leader>v :view %%

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END
autocmd BufRead,BufNew *.md set filetype=markdown

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:fsharp_only_check_errors_on_write = 1
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <C-w>E :SyntasticCheck<CR> :SyntasticToggleMode<CR>

let g:ctrlp_working_path_mode = 'rc'
let g:ctrlp_user_command = 'ag -i --nocolor --nogroup --hidden --ignore .git --ignore .svn --ignore .hg --ignore .DS_Store --ignore "**/*.pyc" --ignore "**/*.dll" --ignore "**/*.pdb --ignore build/*.pdb --ignore build/*.dll" -g "" %s'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$',
  \ 'file': '\.exe$\|\.so$\|\.dat$'
  \ }
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
let g:ackprg = 'ag --nogroup --nocolor --column --ignore-case'

so $HOME/.vim/executesql.vim
map <Leader>sq "qy:call ExecuteSQL()<CR>
