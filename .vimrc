syntax on
"colorscheme 0x7A69_dark

:set tabstop=4
:set shiftwidth=4
:set expandtab
:set softtabstop=4

autocmd FileType make setlocal noexpandtab
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab| set ai

" set ruler -- will show ln, cn (line numba, column numba) in the status bar
" set colorcolumn will show a red line as indication where we need to break
" lines.
:set ruler
":set colorcolumn=81
""highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/
""match OverLength /\%>80v.\+/
"highlight Normal ctermfg=grey ctermbg=darkblue

