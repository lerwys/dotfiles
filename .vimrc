" VIM Configuration File
" Based on the dotfile by João Sampaio <jpmelos@gmail.com> from
" https://github.com/jpmelos/dotfiles/blob/master/dotfiles/vimrc
"
" F mappings already used:
" F2: Remove trailing spaces
" F3: Close current buffer and close window
" F4: Close current buffer but keep window
" F5: Search
" F6<2,4,8>: Set tabs to 2, 4, or 8.
" F7: Open file in GitHub
" F8: Toggle paste mode
" F9: Toggle NERDTree
" F12: Toggle cursor centered in screen

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VUNDLE SETUP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, this is required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle
" instead of Plugin)

" Vim plugins
Plugin 'vim-scripts/SyntaxAttr.vim'

" File navigation plugins
Plugin 'scrooloose/nerdtree'
Plugin 'preservim/nerdcommenter'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tyru/open-browser.vim'
Plugin 'tyru/open-browser-github.vim'

" Editing plugins
Plugin 'mbbill/undotree'
Plugin 'tpope/vim-surround'
Plugin 'vim-syntastic/syntastic'
Plugin 'spf13/vim-autoclose'
Plugin 'Shougo/deoplete.nvim'

if !has('nvim')
  Plugin 'roxma/nvim-yarp'
  Plugin 'roxma/vim-hug-neovim-rpc'
endif

Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'

" Git plugins
Plugin 'tpope/vim-fugitive'

" Python plugins
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLORS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" popup menu with clearer colors
" hi Pmenu ctermfg=Black ctermbg=White
" hi PmenuSel ctermfg=Black ctermbg=LightGray

" Write things in more readable colors against dark backgrounds
" hi String ctermfg=Yellow
" hi pythonNumber ctermfg=Green
" hi makeCommands ctermfg=Green
" hi javaBoolean ctermfg=14 cterm=bold

" enable syntax highlighting
syntax on

" for .sh files, always presume bash
let g:is_bash=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" enable filetype detection and use of plugins
filetype plugin indent on

" mappings default leader
let mapleader = ','

" set UFT-8 encoding
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

" wrap lines to fit in window
set wrap

" break words intelligently
set linebreak

" do not show white chars like tabs and end-of-lines
set nolist

" highlight matching braces
set showmatch

" configure searching
set incsearch  " incremental searching
set ignorecase " ignore case when searching...
set smartcase  " unless it contais uppercase
set hls        " highlight search results

" show line numbers
set number

" allow backspacing over everything
set backspace=eol,start,indent

" define line feeds and carrige returns
set fileformats=unix,dos,mac

" show details about commands (like how many chars are selected in visual
" mode)
set showcmd

set visualbell        " no bell

" keeps cursor in the middle of the screen (unless you have a 2,000 lines high
" screen, in such case call me because I want to see that)
set scrolloff=999

set autoindent        " enable indentation of previous line on next
set tabstop=4         " tab stops are 4 spaces
set softtabstop=4     " tab stops are 4 spaces
set shiftwidth=4      " tab stops are 4 spaces
set expandtab         " tab stops become spaces

" always displays file name, current line and column number
set laststatus=2

set wildmode=longest,list,full " filename auto-completion works bash-like
set wildmenu " when hits to complete full name, shows list of filenames

" turn paste mode on and off with F8
set pastetoggle=<F8>

" new splits goes to the right and below
set splitright
set splitbelow

" ignore __pycache__ and .pyc files
set wildignore+=*/__pycache__/*,*.pyc,*/.git/*

" look for tags in current directory and all the way up to the root
set tags=tags;/

" save temporary files to a default directory
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" set fold to start open
set foldlevelstart=20

" Map vim TABS
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

"marks the 80th column with red
set colorcolumn=80

" trailing whitespaces
highlight BadWhitespace ctermbg=red guibg=red
match BadWhitespace /\s\+$/       " make trailing whitespace be flagged
au BufWritePre *,*.* :%s/\s\+$//e " deletes trailing whites when saving files

" set default font
set guifont=Monospace\ 14

" Generate ctags
au BufWritePost *.c,*.cpp,*.h silent! !ctags -R &

" Associate .in files with texinfo
autocmd BufRead,BufNewFile *.in set filetype=texinfo

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" navigate through display lines
nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk

" navigate through splits
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

" move lines in a file
nnoremap - ddp
nnoremap _ ddkkp

" quickly navigate to start and end of lines
nnoremap H 0
nnoremap L $

" clear highlight when refreshing.
nnoremap <C-C> :nohls<CR><C-L>
inoremap <C-C> <C-O>:nohls<CR>

" allows for easily disabling this functionality
noremap <F12> :let &scrolloff=999-&scrolloff<CR>

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
	\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
	\gvy/<C-R><C-R>=substitute(
	\escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
	\gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
	\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
	\gvy?<C-R><C-R>=substitute(
	\escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
	\gV:call setreg('"', old_reg, old_regtype)<CR>

" fast fold toggle
nnoremap <Space> za

" uppercase current word
nnoremap <C-U> viwU<ESC>
inoremap <C-U> <ESC>viwU<ESC>ea

" allows quick editing and sourcing my .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>:nohls<CR>

" toggle search
nnoremap <F5> /\v

" close buffers
nnoremap <F3> :bw<CR>
nnoremap <F4> :BW<CR>

" navigate through "virtual tabs" by vim-buftabline
nnoremap <C-N> :bprev<CR>
nnoremap <C-M> :bnext<CR>

nnoremap <F7> :OpenGithubFile<CR>
vnoremap <F7> :OpenGithubFile<CR>

nnoremap <F2> :%s/\s\+$//e<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set statusline=\ %f\  " file name
set statusline+=-\  " separator
set statusline+=FileType:\  " label
set statusline+=%y\  "file type
set statusline+=%m%r\  " shows modified file or read-only
set statusline+=%= " change side
set statusline+=%3c,%5l/%L\  " show current column, current line/total lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTO COMMANDS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup python_syntax
    autocmd!

    " remove `file` keyword from syntax
    autocmd BufNewFile,BufRead *.py syn keyword noHi file

augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTREE CONFIGURATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

noremap <F9> :NERDTreeToggle<CR>

let NERDTreeShowHidden = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SYNTASTIC CONFIGURATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DEOPLETE CONFIGURATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:deoplete#enable_at_startup = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTOCLOSE CONFIGURATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:autoclose_vim_commentmode = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UNDOTREE CONFIGURATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <F5> :UndotreeToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TOGGLE ALL FOLDS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! ToggleAllFolds()
    if !exists("b:all_folds_collapsed")
        let b:all_folds_collapsed = 1
    endif

    if b:all_folds_collapsed
        execute ":normal! zR"
        let b:all_folds_collapsed = 0
    else
        execute ":normal! zM"
        let b:all_folds_collapsed = 1
    endif
endfunction

nnoremap <Leader><Space> :call ToggleAllFolds()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SYNTAXATTR
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <Leader>a :call SyntaxAttr()<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SET INDENT QUICKLY
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <F6>2 :set tabstop=2 softtabstop=2 shiftwidth=2<CR>
nnoremap <F6>4 :set tabstop=4 softtabstop=4 shiftwidth=4<CR>
nnoremap <F6>8 :set tabstop=8 softtabstop=8 shiftwidth=8<CR>
