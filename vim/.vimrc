for f in split(glob('~/dotfiles/vim/source/*.vim'), '\n')
    exe 'source' f
endfor

set nocompatible
" https://lwn.net/Vulnerabilities/20249/
set nomodeline
set fileformats=unix,dos,mac
" Brief jump to matching parens on insert, time in 1/10 sec
set showmatch
set matchtime=3

set autoindent
" set smartindent
" Turn on filetype-specifc indenting
filetype indent on

set history=100
set viminfo='200,\"500
set formatoptions+=2nj
set formatoptions-=or
" Number formats to recognize for C-A and C-X math
set nrformats=hex
set noexpandtab
set nobackup
" set swap file directory
" set directory=~/vimswap
set noswapfile

set hidden
set mouse=a
set shiftwidth=4
set tabstop=4
set showcmd
set ruler
set laststatus=2

set wildmode=longest,list
set wildmenu
set cursorline
set showmatch
set incsearch
set wildignorecase
set nrformats=hex

syntax enable
" set hlsearch

" Backspace over everything
set backspace=indent,eol,start

set lazyredraw          " redraw only when we need to (speeds up macros)
set nowrap
set ignorecase
set smarttab
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set copyindent    " copy the previous indentation on autoindenting
set virtualedit=
set list
set listchars=tab:\|\ⵧ,trail:·,extends:❯,precedes:❮
set splitbelow
set splitright
set showbreak=
set t_Co=256
set background=dark

colorscheme djhiii
" colorscheme dues
" colorscheme badwolf
" Make the tab line darker than the background.
let g:badwolf_tabline = 0
    " Turn off HTML link underlining
    let g:badwolf_html_link_underline = 0
    " Turn on CSS properties highlighting
    let g:badwolf_css_props_highlight = 1


set sidescroll=30
set whichwrap=<,>,h,l,[,],b,s

autocmd BufNewFile,BufRead pico.* set noautoindent
set thesaurus+=~/dotfiles/thesaurus.txt
" set dictionary+=~/dotfiles/dictionary.txt
set complete=.,w,b,u,t,i,kspell
set completeopt=longest,menuone,preview
set path=.,**
set spellfile=~/dotfiles/vim/bundle/spell/en.utf-8.add

runtime macros/matchit.vim
" let b:match_words .= '\<foo\>:\<bar\>'

:let g:html_indent_script1 = "inc"
:let g:html_indent_style1 = "inc"

let g:snipMate = {}
let g:snipMate.scope_aliases = {}
let g:snipMate.scope_aliases.phtml = 'php'
:smap <c-j> <Plug>snipMateNextOrTrigger
:imap <c-j> <Plug>snipMateNextOrTrigger
:smap <c-l> <Plug>snipMateBack
:imap <c-l> <Plug>snipMateBack

let g:switch_custom_definitions =
    \ [
    \   ['TRUE', 'FALSE'],
    \   ['width', 'height'],
    \   ['id', 'class', 'style'],
    \   ['png', 'jpg'],
    \   ['-', '='],
    \   ['    ', '	'],
    \   ['templates', 'modules']
    \ ]
autocmd FileType css let b:switch_custom_definitions =
    \ [
    \   ['padding', 'margin'],
    \   ['top', 'right', 'bottom', 'left'],
    \   ['relative', 'absolute', 'fixed'],
    \   ['max', 'min'],
    \   [';', ' !important;'],
    \   [';', ':'],
    \   ['#', '.'],
    \   ['px', '%']
    \ ]

autocmd FileType txt let b:switch_custom_definitions =
    \ [
    \   ['which', 'that']
    \ ]

let g:sparkupNextMapping = "<c-f>"

autocmd FileType netrw setl bufhidden=wipe
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4

let php_sql_query = 1
let php_htmlInStrings = 1

let g:sql_type_default = 'mysql'
let g:ftplugin_sql_omni_key = '<c-c>'

let php_htmlInStrings = 1

let g:qf_mapping_ack_style = 1
