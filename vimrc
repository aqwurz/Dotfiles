
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Jan 26
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" plug
call plug#begin('~/.vim/plugged')

Plug 'dylanaraps/wal.vim'

call plug#end()

colorscheme wal

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
if v:progname == "vim"
  source $VIMRUNTIME/defaults.vim
endif

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" autopairs fly mode
let g:AutoPairsFlyMode = 1

" LaTeX
filetype plugin indent on
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after

cabbrev tabv tab sview +setlocal\ nomodifiable

" change tabs to 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
autocmd FileType norg :setlocal sw=2 ts=2 sts=2 " Two spaces for Neorg files "

" colors
" highlight Function ctermfg=White
" highlight String ctermfg=Magenta
" highlight Statement ctermfg=Green

" custom keybinds
nmap <leader>\ :%s/[.!?]\_s\+/&\E/g<cr>

let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

let g:ultisnips_python_style='google'

let Tlist_Compact_Format = 1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_Close_On_Select = 1
nnoremap <C-l> :TlistToggle<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" mouse in vim
set mouse=a

" fix autopairs å issue
let g:AutoPairsShortcutFastWrap = '<C-e>'

" adds linebreak
set linebreak
set breakindent

" wild
set wildignore=*.class,*.pdf,*.jpg,*.png,*.JPG,*.PNG,*.HEIC

" intelligent case searching
set ignorecase
set smartcase

