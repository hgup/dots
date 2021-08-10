call plug#begin(stdpath('data'))

Plug 'jiangmiao/auto-pairs'
Plug 'navarasu/onedark.nvim'
Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
Plug 'neovim/nvim-lspconfig'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'unblevable/quick-scope'
Plug 'nvim-lua/completion-nvim'

call plug#end()

filetype plugin on

let mapleader = " "
let maplocalleader = "\\"

"split navigations
nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
nnoremap <leader>l <C-W><C-L>
nnoremap <leader>h <C-W><C-H>

set splitbelow
set splitright

" Enable folding
set foldmethod=indent
set foldlevel=99
"Enable folding with the spacebar
nnoremap <space> za

let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ }

au BufNewFile,BufRead *.py,*.java,*.cpp,*.c,*.cs,*.rkt,*.h,*.html
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=120 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

set encoding=utf-8
syntax on
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:onedark_style = 'darker'
"highlight Comment cterm=italic gui=italic

" true colours
set background=dark
if !has('gui_running')
  set t_Co=256
endif

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif


" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

colorscheme onedark

"hi Pmenu guibg=#2F343D guifg=#DCDFE4
"hi PmenuSel guibg=#98C379 guifg=#282C34
"hi PmenuThumb guibg=#373C47 guifg=#DCDFE4
"hi PmenuSbar guibg=#23272E

set nu "rnu " relative line numbering
set clipboard=unnamedplus " public copy/paste register
set cursorline
set ruler
set nowrap
set showcmd
set noswapfile " doesn't create swap files
set noshowmode
set shortmess+=c
set omnifunc=syntaxcomplete#Complete
set shell=cmd
set hidden

set backspace=indent,eol,start " let backspace delete over lines
set autoindent " enable auto indentation of lines
set smartindent " allow vim to best-effort guess the indentation
set pastetoggle=<F1> " enable paste mode

set smartcase
set ignorecase
set wildmenu "graphical auto complete menu
set lazyredraw "redraws the screne when it needs to
set showmatch "highlights matching brackets
set incsearch "search as characters are entered
set hlsearch "highlights matching searches

"clears highlights
nnoremap <leader><leader> :noh<return>
" moves current line down or up
nnoremap <leader>- ddp
nnoremap <leader>_ ddkP
" open vimrc in vertical split
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" update changes into current buffer
nnoremap <leader>sv :source $MYVIMRC<cr>
" enable or disable line wrapping in current buffer
nnoremap <buffer> <localleader>w :set wrap!<cr>
" custom remaps
nnoremap <s-tab> :bp<return>
nnoremap <tab> :bn<return>
nnoremap <leader>q :q<return>
nnoremap <leader>1 :b1<return>
nnoremap <leader>2 :b2<return>
nnoremap <leader>3 :b3<return>
nnoremap <leader>4 :b4<return>
nnoremap <leader>5 :b5<return>
nnoremap <leader>6 :b6<return>
nnoremap <leader>7 :b7<return>
nnoremap <leader>8 :b8<return>
nnoremap <leader>9 :b9<return>
" primeagen remaps
nnoremap Y y$
" keeping it centered
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJz`v
" c++11 support in syntastic
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'


nnoremap <leader>c :so $VIMRUNTIME/syntax/hitest.vim<return>
" run code
augroup compileandrun
    autocmd!
    autocmd filetype python nnoremap <f5> :w <bar> :!python3 % <cr>
    autocmd filetype cpp nnoremap <f2> :w <bar> !g++ -std=c++17 % <cr>
    autocmd filetype cpp nnoremap <f3> :vnew <bar> :te "a.exe" <cr>
    autocmd filetype cpp nnoremap <f4> :w <bar> !g++ -std=c++17 % <cr> :vnew <bar> :te "a.exe" <cr>
    autocmd filetype c nnoremap <f5> :w <bar> !make %:r && ./%:r <cr>
    autocmd filetype java nnoremap <f5> :w <bar> !javac % && java %:r <cr>
augroup END

set completeopt=menuone,noinsert,noselect
let g:completion_matching_stratergy_list = ['exact', 'substring', 'fuzzy']
lua << EOF
require'lspconfig'.pylsp.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.tsserver.setup{}
EOF
"COC
nmap <space>f :CocCommand explorer<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif
