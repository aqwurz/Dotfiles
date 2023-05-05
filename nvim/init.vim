scriptencoding utf8

" Arch defaults
runtime! archlinux.vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.config/vimrc

call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-neorg/neorg' | Plug 'nvim-lua/plenary.nvim' 
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clangd-completer' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'lervag/vimtex'
Plug 'dylanaraps/wal.vim'
call plug#end()

" vimtex
" This is necessary for VimTeX to load properly. The "indent" is optional.
" Note that most plugin managers will do this automatically.
filetype plugin indent on

" This enables Vim's and neovim's syntax-related features. Without this, some
" VimTeX features will not work (see ":help vimtex-requirements" for more
" info).
syntax enable

" Viewer options: One may configure the viewer either by specifying a built-in
" viewer method:
let g:vimtex_view_method = 'zathura'

" Or with a generic interface:
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
" let g:vimtex_compiler_method = 'latexrun'
let g:vimtex_compiler_engine = 'luatex'
" Most VimTeX mappings rely on localleader and this can be changed with the
" following line. The default is usually fine and is the symbol "\".
" let maplocalleader = ","

set conceallevel=2

lua << EOF
require('neorg').setup {
    load = {
        ["core.defaults"] = {},
        ["core.dirman"] = {
            config = {
                workspaces = {
                    bujo = "/Media/argent import/personal/bujo",
                    study = "/Media/argent import/export/uio"
                }
            }
        },
        ["core.concealer"] = {},
        -- ["core.norg.completion"] = {},
        ["core.qol.toc"] = {},
        ["core.export"] = {},
        ["core.journal"] = {
            config  = {
                workspace = "bujo",
                journal_folder = "norg",
                strategy = "nested"
            }
        }
    }
}
require('nvim-treesitter.configs').setup {
    ensure_installed = { "norg", --[[ other parsers you would wish to have ]] },
    highlight = { -- Be sure to enable highlights if you haven't!
        enable = true,
    }
}
EOF
