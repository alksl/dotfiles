" set up pathogen, https://github.com/tpope/vim-pathogen
filetype off
call pathogen#infect()
filetype plugin indent on

" disable compability with vi
set nocompatible

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" show a navigable menu for tab completion
" set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu
set wildmode=longest,list,full

" smart autoindentaiton
set backspace=indent,eol,start
set autoindent
set smartindent
set cinkeys=0{,0},0):,0#,!^I,o,O,e

" display incomplete command
set showcmd

" display ruler
set ruler

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

" dark background
set background=dark

" color dependent settings
if &t_Co > 1 || has("gui_running")
  syntax enable " enable syntax high
  set hlsearch " higlight search items
  nnoremap <F3> :set hlsearch!<CR>
endif

colorscheme vibrantink

" display linenumbers
set relativenumber

function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

" Functions for running c++ make tests
function! SetLastCxxTest(test)
  let s:last_cxx_test = a:test
endfunction

function! RunCxxTest(test)
  exec substitute("!build/{test}", "{test}", a:test, "g")
endfunction

function! RunLastCxxTest()
  if(exists("s:last_cxx_test"))
    call RunCxxTest(s:last_cxx_test)
  endif
endfunction

function! InCxxTestFile()
  return match(expand("%"), "_test.cc$") != -1
endfunction

function! RunCurrentCxxTestFile()
  if InCxxTestFile()
    let l:test = expand("%:t:r")
    call SetLastCxxTest(l:test)
    call RunCxxTest(l:test)
  else
    call RunLastCxxTest()
  endif
endfunction

function! RunCurrentTest()
  if(&filetype == "cpp")
    call RunCurrentCxxTestFile()
  else
    call RunCurrentSpecFile()
  endif
endfunction

function! RunLastTest()
  if(&filetype == "cpp")
    call RunLastCxxTest()
  else
    call RunLastSpec()
  endif
endfunction

" map Ctrl-A and Ctrl-E to emacs mode. map! makes
" the mapping work in all vim modes

let mapleader=","

map  <C-A> <Home>
map  <C-E> <End>
map! <C-A> <Home>
map! <C-E> <End>

map   <C-H>
map!  <C-H>

" Leader commands

" edit Leader commands
map <Leader>el    :e ~/.vimrc<cr>/\<Leader\><cr>GN
map <Leader>src   :source ~/.vimrc<cr>

" Symbol hash to string hash
map <Leader>sts   i"wwxi" =>

" cmake and make commands
map <Leader>cm    :!cmake build 2>&1 \| less<cr>
map <Leader>m     :!pushd build; make 2>&1 \| less; popd<cr>
map <Leader>mt    :!pushd build; make test 2>&1 \| less; popd<cr>

" set textwraping
map <Leader>w     :set tw=79<cr>:set formatoptions+=t<cr>

" RSpec.vim mappings
map <Leader>s     :w<CR>:call RunNearestSpec()<CR>
map <Leader>a     :w<CR>:call RunAllSpecs()<CR>

" Common bindings for Cxx and Rspec tests
map <Leader>t     :w<CR>:call RunCurrentTest()<CR>
map <Leader>l     :w<CR>:call RunLastTest()<CR>

map <Leader>gw    :!git add . && git ci -m "WIP"<CR>
map <Leader>gwm   :!git add . && git ci<CR>

" Search in dash
map <Leader>d     :!open dash://<C-r><C-w><CR><CR>


" plugin settings
let g:ctrlp_match_window = 'order:ttb,max:20'
let g:NERDSpaceDelims=1
let g:gitgutter_enabled = 0

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  let g:ackprg = 'ag --nogroup --column'

  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif


" Configure Gist plugin
let g:gist_open_browser_after_post = 1
let g:gist_detect_filetype = 1
let g:gist_clip_command = 'pbcopy'

" Configure rpec command to use bundle exec
let g:rspec_command = "!bundle exec rspec {spec}"

" set status line information
set statusline=%<%F%h%m%r%h%w%y\ %{&ff}\ %{strftime(\"%c\",getftime(expand(\"%:p\")))}%=\ lin:%l\,%L\ col:%c%V\ pos:%o\ ascii:%b\ %P
