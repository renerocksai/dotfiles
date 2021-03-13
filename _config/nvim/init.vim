set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
:set laststatus=2
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'machakann/vim-highlightedyank'
Plugin 'tomasiser/vim-code-dark'
"Plugin 'ludovicchabant/vim-gutentags'
Plugin 'Tagbar'
Plugin 'qpkorr/vim-bufkill'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'

Plugin 'fatih/vim-go'
Plugin 'jremmen/vim-ripgrep'
Plugin 'lambdalisue/gina.vim'
"
" dart plus lsp
Plugin 'dart-lang/dart-vim-plugin'
" we replace it by coc Plugin 'natebosch/vim-lsc'
" we replace it by coc  Plugin 'natebosch/vim-lsc-dart'
Plugin 'neoclide/coc.nvim'

" tmux integration
Plugin 'benmills/vimux'
Plugin 'roxma/vim-tmux-clipboard'

" pandoc
"Plugin 'vim-pandoc/vim-pandoc'
"lugin 'vim-pandoc/vim-pandoc-syntax' 

Plugin 'habamax/vim-godot'
Plugin 'ziglang/zig.vim'

"Firenvim
"Plugin 'glacambre/firenvim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax on

:set tabstop=4
:set shiftwidth=4
:set expandtab
:set softtabstop=4

autocmd FileType make setlocal noexpandtab
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab| set ai
autocmd FileType vhdl set tabstop=4|set shiftwidth=4|set expandtab| set ai
autocmd FileType pov set tabstop=4|set shiftwidth=4|set expandtab| set ai
autocmd FileType dart set tabstop=2|set shiftwidth=2|set expandtab| set ai

autocmd FileType pov set syntax=rrisc 
autocmd FileType asm set syntax=rrisc 

""""""""""""""""""""""""""""""""""""""""""
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
""""""""""""""""""""""""""""""""""""""""""
set mouse=a

if !has('nvim')
  set ttymouse=xterm2
  set clipboard+=unnamedplus
endif

let g:highlightedyank_highlight_duration = 100
if !exists('##TextYankPost')
    map y <Plug>(highlightedyank)
endif

if &term =~ '256color'
    " Disable Background Color Erase (BCE) so that color schemes
    " work properly when Vim is used inside tmux and GNU screen.
    set t_ut=
endif

let g:airline_theme='coderene'
:colorscheme codedark

command Term :term ++curwin
command Vterm :vertical term

set splitright
set splitbelow
set bs=2

let mapleader = ","

set autowrite
map <C-n> :cnext<CR>
map <C-b> :cprevious<CR>
nnoremap <leader>c :cclose<CR>
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <Leader>i <Plug>(go-info)

let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1
set completeopt-=preview

" fzf stuff
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
command! ProjectFiles execute 'Files' s:find_git_root()
nnoremap <c-p> :ProjectFiles <CR>

let g:rg_command = '/usr/bin/rg --vimgrep -S'
if executable('/snap/bin/rg')
  let g:ctrlp_user_command = '/snap/bin/rg %s --files --hidden --color=never --glob ""'
endif
map <leader>F :Rg 

" resize windows via wasd keys if mouse cannot dig it 
nnoremap <silent> <Leader>w :exe "resize +5" <CR>
nnoremap <silent> <Leader>s :exe "resize -5" <CR>
nnoremap <silent> <Leader>a :exe "vertical resize +5" <CR>
nnoremap <silent> <Leader>d :exe "vertical resize -5" <CR>

"Gina status in a new vertical split
nnoremap <leader>g :vsplit<bar>Gina<Space>status<CR>
"nnoremap <leader>G :vsplit<bar>Gina<Space>commit<CR>
nnoremap <leader>G :Gina<Space>commit<CR>
nnoremap <leader>P :Gina<Space>push<CR>

"enable visual bell
:set vb
:set t_vb=

:set cursorline
:hi CursorLine   cterm=NONE ctermbg=236 ctermfg=NONE guibg=grey18
:set guifont=Consolas:h16
" on laptop display:
":set guifont=Consolas:h11


" Dart
let g:lsc_auto_map = { 'defaults': v:true, 'PreviousReference': '<leader>p' }
let g:dart_style_guide = 2

" VIM's built-in netrw (explorer: VExplore / SExplore)

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END
nmap <leader>e :Vexplore <CR>

" Vimux
nmap <leader>T :VimuxPromptCommand <CR>
nmap <leader>t :VimuxRunLastCommand<CR>

"givm
set guifont=Consolas

" vim RC editing
nnoremap <leader>E :vsplit $MYVIMRC<CR>
nnoremap <leader>S :source $MYVIMRC<CR>
inoremap jk <esc>

"""""""""""""""""""""""""""""""""""""""
" COC
"""""""""""""""""""""""""""""""""""""""
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


:nmap <space>E :CocCommand explorer<CR>
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

nmap <up> <nop>
nmap <down> <nop>
nmap <left> <nop>
nmap <right> <nop>

"set relativenumber

set number
set hlsearch
hi Search ctermfg=192 ctermbg=199

" close all buffers but this one
command! BufOnly silent! execute "%bd|e#|bd#"

:set exrc

