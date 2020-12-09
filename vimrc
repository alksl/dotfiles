call plug#begin('~/.vim/plugged')

Plug '/usr/local/opt/fzf'
Plug 'PeterRincker/vim-argumentative'
Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
Plug 'hashivim/vim-terraform'
Plug 'joker1007/vim-ruby-heredoc-syntax'
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-textobj-user'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rhysd/vim-textobj-ruby'
Plug 'rust-lang/rust.vim'
Plug 'shougo/context_filetype.vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-unimpaired'
Plug 'vim-ruby/vim-ruby'

" Initialize plugin system
call plug#end()

" disable compability with vi
set nocompatible

set hidden

set nobackup
set nowritebackup

set updatetime=300

set mouse=a

set shortmess+=c

set signcolumn=yes

set iskeyword+=?

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Enable spelling for texfiles and git commit messages
autocmd BufRead,BufNewFile *.tex setlocal spell
autocmd BufRead,BufNewFile *.tex set complete+=kspell
autocmd FileType tex setlocal spell
autocmd FileType tex set complete+=kspell
autocmd FileType gitcommit setlocal spell

" Close fugitive buffers automatically
autocmd BufReadPost fugitive://* set bufhidden=delete

autocmd BufWritePre *.tf :TerraformFmt

" show a navigable menu for tab completion
set wildignore=log/**,node_modules/**,target/**,tmp/**
set wildmenu
set wildmode=longest,list,full

" smart autoindentaiton
se backspace=indent,eol,start
set autoindent
set smartindent
set cinkeys=0{,0},0):,0#,!^I,o,O,e

" display incomplete command
set showcmd

" tab configuration
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" show trailing whitespace
set list
set listchars=tab:▸\ ,trail:▫

" Trim trailing whitespace
fun! <SID>StripWhite()
  %s/[ \t]\+$//ge
  %s!^\( \+\)\t!\=StrRepeat("\t", 1 + strlen(submatch(1)) / 8)!ge
endfun
autocmd BufWritePre * :call <SID>StripWhite()

" disable annoying sounds at error, blink instead
set noerrorbells
set visualbell
set t_vb=

" search while i type.
set incsearch

" color dependent settings
if &t_Co > 1 || has("gui_running")
  syntax enable " enable syntax high
  set hlsearch " higlight search items
  nnoremap <F3> :set hlsearch!<CR>
endif

filetype plugin indent on

function! ToggleAutoChDir()
  if(&autochdir == 1)
    set noautochdir
  else
    set autochdir
  endif
endfunction

function! s:git_log_handler(log_row)
  let words = split(a:log_row)
  let @c = words[0]
endfunction

command! -nargs=0 FZFcommit call fzf#run({
\ 'source': 'git log --oneline',
\ 'sink': function('<sid>git_log_handler'),
\ 'options': "--no-sort -d' ' --nth=2,3,4,5,6"
\ })

let mapleader=","

nmap <F8> :TagbarToggle<CR>

map  <C-P> :Files<CR>
map  <C-A> <Home>
map  <C-E> <End>
map! <C-A> <Home>
map! <C-E> <End>

map  <C-B> :Buffers<CR>

map   <C-H>
map!  <C-H>

map <Leader>ad :call ToggleAutoChDir()<cr>

map <Leader>gw :Gwrite<cr>
map <Leader>gs :Gstatus<cr>

map <Leader>w     :set tw=79<cr>:set formatoptions+=t<cr>

" Search for word in code base
map <Leader>sw    yiw:Rg <C-r>"<CR>

" Insert iso date
map <Leader>id    o<Esc>i<C-r>=substitute(system('date +\%F'),'[\r\n]*$','','')<cr><esc>

" Go to tag
map <Leader>gy    yiw:ta <C-r>"<CR>
map <Leader>gts   yiw<C-w>s<C-w>k:ta <C-r>"<CR>
map <Leader>gtv   yiw<C-w>v<C-w>k:ta <C-r>"<CR>

map <Leader>ct    :Cargo test<cr>

" Reload ~/.vimrc
map <Leader>r     :source ~/.vimrc<CR>

" Move to next and prev style error
map <Leader>n     :lnext<CR>
map <Leader>p     :lprev<CR>

" Drop down to shell
noremap <C-d>     :sh<cr>

" Open up commit in browser
map <Leader>b     yiw:Gbrowse <C-r>"<CR>

" Write with two newline padding
map <Leader>o     o<CR><CR>
map <Leader>O     O<Esc>O<Esc>O

" add frozen string literal
map <Leader>fz    ggO# frozen_string_literal: true<CR><Esc>x<Esc>

" Yank selected to system clipboard
vmap <C-c> :y *<CR>

" Paste system clipboard
imap <C-v> "+p

map <Leader>t    yiw:ta <C-r>"<CR>

map <Leader>c  :FZFcommit<CR>
map <Leader>cf :Gcommit --fixup=<C-r>c

" Configure Gist
let g:gist_open_browser_after_post = 1
let g:gist_detect_filetype = 1
let g:gist_clip_command = 'pbcopy'

" Configure Coc
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)

omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)

highlight GitGutterAdd      cterm=bold              ctermfg=2
highlight GitGutterChange   cterm=bold              ctermfg=3
highlight GitGutterDelete   cterm=bold              ctermfg=1

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)


map <silent> ac f,lxi<cr><esc>

" terminal mappings
" tnoremap <Esc> <C-\><C-N>

" Configure Rust plugin
let g:rust_clip_command = 'pbcopy'
let g:rustfmt_autosave = 1

" Configure FZF
set rtp+=/usr/local/opt/fzf
let g:fzf_action = {
 \ 'ctrl-t': 'tab split',
 \ 'ctrl-s': 'split',
 \ 'ctrl-v': 'vsplit'
 \ }

"" Visual settings
set background=dark
colorscheme monokai
set termguicolors

set number
set cursorline

set ruler
set rulerformat=%-14.(%l,%c%V%)\ %P

set laststatus=2
set statusline=
set statusline+=\ %f%m
set statusline+=\ %{FugitiveStatusline()}
set statusline+=%{coc#status()}%{get(b:,'coc_current_function','')}
set statusline+=%=%-14.(%l,%c%V%)

highlight StatusLine                   ctermbg=252  ctermfg=30
highlight StatusLineNC                 ctermbg=252  ctermfg=23
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignColumn                   ctermbg=none
highlight LineNr                       ctermbg=none ctermfg=243
highlight CursorLineNR      cterm=bold ctermbg=none ctermfg=255
highlight Pmenu                        ctermbg=0    ctermfg=15
highlight PmenuSel          cterm=bold ctermbg=8    ctermfg=15

highlight GitGutterAdd    gui=bold guifg=#009900 cterm=bold ctermfg=2
highlight GitGutterChange gui=bold guifg=#bbbb00 cterm=bold ctermfg=3
highlight GitGutterDelete gui=bold guifg=#ff2222 cterm=bold ctermfg=1

highlight link GitGutterChangeLine DiffText
highlight link GitGutterChangeLineNr Underlined

let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'ruby': [
\    'rubocop',
\    'standardrb',
\   ],
\   'javascript': [
\     'prettier',
\     'eslint',
\   ],
\   'python': [
\     'black',
\     'isort',
\   ],
\
\}
let g:ale_fix_on_save = 1
let g:ale_enabled = 1

let g:gitgutter_set_sign_backgrounds = 1
let g:gitgutter_diff_args = '-w'
let g:python_host_prog = expand("~/.pyenv/versions/2.7.17/bin/python2")
let g:node_host_prog = expand("~/.nvm/versions/node/v12.15.0/bin/neovim-node-host")
