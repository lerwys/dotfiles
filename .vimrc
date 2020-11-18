" Map vim TABS
map <C-t><up> :tabr<cr>
map <C-t><down> :tabl<cr>
map <C-t><left> :tabp<cr>
map <C-t><right> :tabn<cr>

"marks the 80th column with red
set colorcolumn=80

" wrap lines to window fit
set wrap
set nolist
set linebreak

" trailing whitespaces
highlight BadWhitespace ctermbg=red guibg=red
match BadWhitespace /\s\+$/       " make trailing whitespace be flagged
au BufWritePre *,*.* :%s/\s\+$//e " deletes trailing whites when saving files

" keeps cursor in the middle of the screen (unless you have a 2,000 lines high
" screen, in such case call me because I want to see that)
set scrolloff=999
" allows for easily disabling this functionality
map <F12> :let &scrolloff=999-&scrolloff<CR>

" set default font
set guifont=Monospace\ 14

" Generate ctags
au BufWritePost *.c,*.cpp,*.h silent! !ctags -R &

" Associate .in files with texinfo
autocmd BufRead,BufNewFile *.in set filetype=texinfo