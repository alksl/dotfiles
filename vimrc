call plug#begin('~/.vim/plugged')

Plug 'rking/ag.vim'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'tpope/vim-endwise'
Plug 'vim-syntastic/syntastic'
Plug 'hashivim/vim-terraform'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-unimpaired'
Plug 'vim-ruby/vim-ruby'
Plug 'rust-lang/rust.vim'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-projectionist'
Plug '/usr/local/opt/fzf'
Plug 'mhinz/vim-signify'

" Initialize plugin system
call plug#end()

" disable compability with vi
set nocompatible

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

let mapleader=","

nmap <F8> :TagbarToggle<CR>

map  <C-P> :FZF<CR>
map  <C-A> <Home>
map  <C-E> <End>
map! <C-A> <Home>
map! <C-E> <End>

map   <C-H>
map!  <C-H>

map <Leader>ad :call ToggleAutoChDir()<cr>

map <Leader>gw :Gwrite<cr>
map <Leader>gs :Gstatus<cr>

map <Leader>w     :set tw=79<cr>:set formatoptions+=t<cr>

" Search for word in code base
map <Leader>sw    yiw:Ag <C-r>"<CR>

" Insert iso date
map <Leader>id    o<Esc>i<C-r>=substitute(system('date +\%F'),'[\r\n]*$','','')<cr><esc>

" Go to tag
map <Leader>gt    yiw:ta <C-r>"<CR>
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

" Syntastic commands
map <Leader>st    :SyntasticToggleMode<CR>
map <Leader>sr    :SyntasticReset<CR>
map <Leader>sc    :SyntasticCheck<CR>

" Write with two newline padding
map <Leader>o     o<CR><CR>
map <Leader>O     O<Esc>O<Esc>O

" add frozen string literal
map <Leader>fz    ggO# frozen_string_literal: true<CR><Esc>x<Esc>


" Yank selected to system clipboard
vmap <C-c> :y *<CR>

" Paste system clipboard
imap <C-v> "+p


" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  let g:ackprg = 'ag --nogroup --column'

  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
endif


" Configure Gist
let g:gist_open_browser_after_post = 1
let g:gist_detect_filetype = 1
let g:gist_clip_command = 'pbcopy'

" Configure Systastic
let g:syntastic_python_python_exec = '/usr/local/bin/python3'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_quiet_messages = {}
let g:syntastic_sh_shellcheck_args = "-x"

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

" Configure signify
let g:signify_vcs_list = ['git']
let g:signify_realtime = 1


"" Visual settings
set background=dark
colorscheme vibrantink

set number
set cursorline

set ruler
set rulerformat=%-14.(%l,%c%V%)\ %P

set laststatus=2
set statusline=
set statusline+=\ %f%m
set statusline+=\ %{FugitiveStatusline()}
set statusline+=\ %{SyntasticStatuslineFlag()}
set statusline+=%=%-14.(%l,%c%V%)

highlight StatusLine                   ctermbg=252  ctermfg=30
highlight StatusLineNC                 ctermbg=252  ctermfg=23
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignColumn                   ctermbg=none
highlight LineNr                       ctermbg=none ctermfg=243
highlight CursorLineNR      cterm=bold ctermbg=none ctermfg=255
