" VIM Configuration File
"
" fwfwefw
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

if (has("python") || has("python3")) && exists('g:spf13_use_powerline') && !exists('g:spf13_use_old_powerline')
    Plugin 'Lokaltog/powerline', {'rtp':'/powerline/bindings/vim'}
elseif exists('g:spf13_use_powerline') && exists('g:spf13_use_old_powerline')
    Plugin 'Lokaltog/vim-powerline'
else
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
endif
Plugin 'powerline/fonts'

" Git plugins
Plugin 'tpope/vim-fugitive'
Plugin 'mhinz/vim-signify'

" Python plugins
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'integralist/vim-mypy'

" Color plugins
Plugin 'altercation/vim-colors-solarized'
Plugin 'spf13/vim-colors'

if executable('ctags')
    Plugin 'majutsushi/tagbar'
endif

" All of your Plugins must be added before the following line
call vundle#end()            " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLORS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark

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

if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
    let g:solarized_contrast="normal"
    let g:solarized_visibility="normal"
    color solarized        " Load a colorscheme
endif

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

set wildmode=longest,list,full " filename auto-completion works bash-like
set wildmenu " when hits to complete full name, shows list of filenames

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

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

" Switch to current file directory when new buffer is opened
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

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

if has('statusline')
    set laststatus=2

    " Broken down into easily includeable segments
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    set statusline+=%{fugitive#statusline()} " Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set configuration options for the statusline plugin vim-airline.
" Use the powerline theme and optionally enable powerline symbols.
" To use the symbols , , , , , , and .in the statusline
" segments add the following to your .vimrc.before.local file:
"   let g:airline_powerline_fonts=1
" If the previous symbols do not render for you then install a
" powerline enabled font.

" See `:echo g:airline_theme_map` for some more choices
" Default in terminal vim is 'dark'
if isdirectory(expand("~/.vim/bundle/vim-airline-themes/"))
    if !exists('g:airline_theme')
        let g:airline_theme = 'solarized'
    endif
    if !exists('g:airline_powerline_fonts')
        " Use the default set of separators with a few customizations
        let g:airline_left_sep='›'  " Slightly fancier than '>'
        let g:airline_right_sep='‹' " Slightly fancier than '<'
    endif
endif

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

set backup                  " Backups are nice ...
if has('persistent_undo')
    set undofile            " So is persistent undo ...
    set undolevels=1000     " Maximum number of changes that can be undone
    set undoreload=10000    " Maximum number lines to save for undo on a buffer reload
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-FUGITIVE CONFIGURATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/vim-fugitive/"))
    nnoremap <silent> <leader>gs :Gstatus<CR>
    nnoremap <silent> <leader>gd :Gdiff<CR>
    nnoremap <silent> <leader>gc :Gcommit<CR>
    nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>gl :Glog<CR>
    nnoremap <silent> <leader>gp :Git push<CR>
    nnoremap <silent> <leader>gr :Gread<CR>
    nnoremap <silent> <leader>gw :Gwrite<CR>
    nnoremap <silent> <leader>ge :Gedit<CR>
    " Mnemonic _i_nteractive
    nnoremap <silent> <leader>gi :Git add -p %<CR>
    nnoremap <silent> <leader>gg :SignifyToggle<CR>
endif

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
" TAGBAR
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if isdirectory(expand("~/.vim/bundle/tagbar/"))
    nnoremap <silent> <leader>tt :TagbarToggle<CR>
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SET INDENT QUICKLY
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <F6>2 :set tabstop=2 softtabstop=2 shiftwidth=2<CR>
nnoremap <F6>4 :set tabstop=4 softtabstop=4 shiftwidth=4<CR>
nnoremap <F6>8 :set tabstop=8 softtabstop=8 shiftwidth=8<CR>
