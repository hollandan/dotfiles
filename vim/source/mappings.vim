"https://devhints.io/vimscript

" good things to map stuff to:
"   +
"   -
"   _
"   |
"<leader>
    "   <tab>
    "   i
    "   m
    "   o
    "   s

    " why not imap ;<letter> -- since you always have a space after a
    " semicolon in normal writing and code!

let mapleader = "\<Space>"
map <space> <leader>

" mac only:
if toupper(substitute(system('uname'), '\n', '', '')) =~ 'DARWIN'

    "copy visual seletion to mac clipboard
    vnoremap <silent> <leader>y :<CR>:let @a=@" \| execute "normal! vgvy" \| let res=system("pbcopy", @") \| let @"=@a<CR>
    " normal copy line to mac clipboard
    nnoremap <silent> <leader>y :<CR>:let @a=@" \| execute "normal! yy" \| let res=system("pbcopy", @") \| let @"=@a<CR>
    nnoremap <silent> <leader>Y mz:%!pbcopy<cr>u`z

    nnoremap ,tc :exec '!open -a Chrome  '.expand('<cWORD>')<cr><cr>
    nnoremap ,tf :exec '!open -a Firefox '.expand('<cWORD>')<cr><cr>
    nnoremap ,ts :exec '!open -a Safari  '.expand('<cWORD>')<cr><cr>

endif

" Use vim-matchup when we can
let s:host = system("echo $HOSTNAME")
if s:host =~ "g9" || s:host =~ "bde"
    nmap <tab> %
    nnoremap c<tab> c%
    nnoremap d<tab> d%
    vmap <tab> %
    nnoremap ci<tab> ci%
else
    nmap <tab> <plug>(matchup-%)
    nmap g<tab> <plug>(matchup-g%)
    nmap [<tab> <plug>(matchup-[%)
    nmap ]<tab> <plug>(matchup-]%)
    nmap z<tab> <plug>(matchup-z%)
    xmap a<tab> <plug>(matchup-%)
    xmap i<tab> <plug>(matchup-%)
    nmap ds<tab> <plug>(matchup-ds%)
    nmap cs<tab> <plug>(matchup-cs%)

    vmap <tab> <plug>(matchup-%)
    vmap g<tab> <plug>(matchup-g%)
    vmap [<tab> <plug>(matchup-[%)
    vmap ]<tab> <plug>(matchup-]%)
    vmap z<tab> <plug>(matchup-z%)
    vmap a<tab> <plug>(matchup-%)
    vmap i<tab> <plug>(matchup-%)
    " vmap ds<tab> <plug>(matchup-ds%)
    " vmap cs<tab> <plug>(matchup-cs%)
endif

" escaping normal mode
imap jj <c-c>
imap kj <c-c>
imap jk <c-c>
imap fj <c-c>
imap jf <c-c>

inoremap (<CR> (<CR>)<Esc>O
inoremap {<CR> {<CR>}<Esc>O
inoremap {; {<CR>};<Esc>O
inoremap {, {<CR>},<Esc>O
inoremap [<CR> [<CR>]<Esc>O
inoremap [; [<CR>];<Esc>O
inoremap [, [<CR>],<Esc>O

inoremap (( ()mz<left>a
inoremap {{ {}mz<left>a
inoremap [[ []mz<left>a
inoremap << <>mz<left>a
inoremap "" ""mz<left>a
inoremap '' ''mz<left>a


" Play nicely with my Hammerspoon config and quit inserting <S-F5> !!
inoremap <S-F5> <nop>

" View registers, and put from them
nnoremap Q :registers<CR>:echo '>' . getline('.')<CR>:normal! "p<left>
inoremap <c-x><c-r> <esc>:registers<CR>:echo '>' . getline('.')<CR>:normal! "p<left>
vnoremap <c-x><c-r> c<esc>:registers<CR>:echo '>' . getline('.')<CR>:normal! "p<left>

snoremap cc <esc>'<C

" Only show cursorline in the current window and in normal mode.
au!
    augroup cline
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

augroup filetype_note
    autocmd!
    " au BufEnter * set nonumber
    setlocal ft=txt
    autocmd FileType note nnoremap <Leader><space> z=1<cr><cr>
    autocmd FileType note nnoremap ,; A.<esc>
augroup END

" augroup filetype_sql
    " let g:omni_sql_no_default_maps = 1
    " let g:loaded_sql_completion = 1
    " see :he sql
" augroup END

augroup filetype_nsglog
    autocmd!
    au CursorHold * checktime
augroup END

augroup filetype_worklog
    autocmd!
    setlocal spell
    setlocal wrap
augroup END

nnoremap : ;
nnoremap ; :
nnoremap K ,
vnoremap : ;
vnoremap ; :

nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
vnoremap <expr> k v:count == 0 ? 'gk' : 'k'
vnoremap <expr> j v:count == 0 ? 'gj' : 'j'

nnoremap ' `
nnoremap ` '


" Gos
noremap gh H
noremap g<space> M
noremap gl L
" move to last change
" gi already moves to "last place you exited insert mode", so we'll map gI to
nnoremap gI `.

"""" Jump to first character or column
" http://jezenthomas.com/moving-to-the-beginning-of-the-line/
function! FirstCharOrFirstCol()
  let current_col = virtcol('.')
  normal ^
  let first_char = virtcol('.')
  if current_col == first_char
    normal 0
  endif
endfunction
nnoremap <silent> H :call FirstCharOrFirstCol()<cr>
" """"""
nnoremap L $
vnoremap L $
vnoremap H ^

" because it makes more sense
nnoremap Y y$

nnoremap dh d0
nnoremap dl d$

"select last pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
" When deleting from a Visual Block, the block will stay selected
" vnoremap x xgv
" **********

" backspace
" nnoremap  :noh<cr>
:nnoremap <silent><expr>  (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"

" It would be cool to haver leader-tab do <c-^> ... but if i do,
" pressing leader alone will execute <c-^> after a short delay
" nnoremap <leader>	 <c-^>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"nnoremap <Leader><space> ggVG=<esc>``
nnoremap <Leader>W :wa<cr>
nnoremap <Leader>` :q!<cr>

nnoremap <Leader>~ :qall!<cr>

" append style
nnoremap <leader>as 0/style<cr>/['"]<cr>n:noh<cr>i
" append class
nnoremap <leader>ac 0/class<cr>/['"]<cr>n:noh<cr>i
" append id
nnoremap <leader>ai 0/id<cr>/['"]<cr>n:noh<cr>i
" append to next " or '
nnoremap <leader>a' /['"]<cr>n:noh<cr>i
" append to tag
nnoremap <leader>att "xdith"xpa
" delete around html attribute
nnoremap dha viWd"_x
" nnoremap dha viwf"f"ld

nnoremap <Leader>tt :read !date "+\%Y-\%m-\%d \%H:\%M"<cr>
nnoremap <Leader>td :read !date "+\%Y-\%m-\%d"<cr>
nnoremap <Leader>tn :read !date "+\%Y-\%m-\%d"<cr>
nnoremap <Leader>b :b <c-d>

" duplicate selected text
vnoremap <leader>cd "xy`>a<cr><esc>"xp`[' . strpart(getregtype(), 0, 1) . '`]
" You have to paste register x after calling, else it pates register x foreach line selected.
vnoremap <leader>cc "xygv \| :TComment<cr> \| `>o<esc>0D"xp`[' . strpart(getregtype(), 0, 1) . '`]
nnoremap <leader>cc mxyy \| :TComment<cr> \| p \| `xj

nnoremap <Leader>d :call DeleteBufferSmartly()<cr>
nnoremap <Leader>D :call DeleteBufferSmartly(1)<cr>

" expressions
nnoremap <Leader>xl :g//laddexpr expand("%") . ":" . line(".") .  ":" . getline(".")<home><right><right>
vnoremap <Leader>xl :g/<c-r>=expand("<cword>")<cr>/laddexpr expand("%") . ":" . line(".") .  ":" . getline(".")<c-left><c-left><c-left><c-left><c-left><c-left><left><left><left><left><left><left><left><left><left><left><left>

nnoremap <leader>xq :g//caddexpr expand("%") . ":" . line(".") .  ":" . getline(".")<home><right><right>

"file types
nnoremap <leader>fb :set ft=phtml<cr>
nnoremap <leader>fc :set ft=css<cr>
nnoremap <leader>fh :set ft=html<cr>
nnoremap <leader>fj :set ft=javascript<cr>
nnoremap <leader>fp :set ft=php<cr>
nnoremap <leader>ft :set ft=txt<cr>
nnoremap <leader>fn :set ft=note<cr>
nnoremap <leader>fm :set ft=mysql<cr>
nnoremap <leader>fz :set ft=codescraps<cr>
" fold methods
nnoremap <leader>fi :set foldmethod=indent<cr>
nnoremap <leader>fs :set foldmethod=syntax<cr>
nnoremap <leader>f0 :set foldlevel=0<cr>
nnoremap <leader>f1 :set foldlevel=1<cr>
nnoremap <leader>f2 :set foldlevel=2<cr>
nnoremap <leader>f3 :set foldlevel=3<cr>
nnoremap <leader>f4 :set foldlevel=4<cr>
nnoremap <leader>f5 :set foldlevel=5<cr>
nnoremap <leader>f6 :set foldlevel=6<cr>
nnoremap <leader>f7 :set foldlevel=7<cr>
nnoremap <leader>f8 :set foldlevel=8<cr>
nnoremap <leader>f9 :set foldlevel=9<cr>


" use ,, to jump when done
inoremap ,, `z<left>%a
nnoremap ,, `z<left>%

nnoremap ,m :Goyo 30%x40%<cr>
nnoremap ,, :Goyo 50%x50%<cr>
nnoremap ,. :Goyo 60%x70%<cr>

nnoremap <Leader>q :q<cr>
" nnoremap <Leader>v :vsp 
nnoremap <Leader>w :w<cr>

nnoremap <Leader>= mzgg=G`z

"html comment
nnoremap <Leader>ch i<!--   --><esc>hhhhi
" normalize blank lines
nnoremap <leader>cl :%!cat -s<cr>
"Clean trailing whitespace (from Steve Losh)
nnoremap <leader>cw mz:%s/\s\+$//<cr>:let @/=''<cr>`z

"jump to first > in line
nnoremap <Leader>. ^f>
"jump to next start/end tag
nnoremap <Leader>/ /><<cr>l:noh<cr>
"jump to next start/end tag
nnoremap <Leader>? h?><<cr>l:noh<cr>

" add space before char / word
nnoremap <Leader>h i <esc>
" nnoremap <Leader>H bi <esc>
nnoremap <Leader>H gv`<<esc>i <esc>
" add space after char / word
nnoremap <Leader>l a <esc>
" add space after pasted char / word
nnoremap <Leader>L gv`><esc>a <esc>
" nnoremap <Leader>L ea <esc>
" add space before and after char /word
nnoremap <Leader>j i <right> <left><esc>
nnoremap <Leader>J bi <esc>ea <esc>

" single out line
nnoremap <Leader>[ mzO<esc>jo<esc>`z
" single out selection
vnoremap <Leader>[ <esc>o<esc>'<O<esc>j

" remove empty lines before & after line or group
nnoremap <Leader>] mz(k"_dd)"_dd`z

"capitalize each word
vnoremap <leader>U :s/\%V\<./\u&/g<cr>'':noh<cr>
nnoremap <leader>U :s/\<./\u&/g<cr>:noh<cr>
" capitalize this word
nnoremap <leader>u mzguiw~`z

let g:switch_mapping = ""
nnoremap <Leader>, :Switch<cr>

nnoremap <c-p> :<up>
vnoremap <c-p> :<up>
"focus on the current fold
nnoremap <leader>z zMzvzz
nnoremap ,  i <esc>
nnoremap ,/ $i /<esc>
nnoremap ,3 bi#<esc>e
nnoremap ,4 bi$<esc>e
nnoremap ,; A;<esc>
inoremap ,; <esc>A;<esc>
nnoremap , : ea;<esc>
nnoremap ,d "_d

" Note Taking
"nnoremap ,\ v)k^<c-v>I\| <esc>r.<esc>gv<esc>r.
nnoremap ,\ v)k^<c-v>I\| <esc>r.'>r.


" Navigation
"================================= {
    cmap cd. lcd %:p:h<cr>

"ls
    nnoremap ,L :call FileExplore("")<left><left>
    nnoremap ,l. :call FileExplore(expand("%:p:h"))<cr>

    nnoremap ,lB :call FileExplore("~/Dropbox/")<cr>
    nnoremap ,lC :call FileExplore("/Volumes/nsg/nsg/clients")<cr>
    nnoremap ,lD :call FileExplore("~/Dropbox/note/do")<cr>
    nnoremap ,lH :call FileExplore("/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/")<cr>
    nnoremap ,lL :call FileExplore("..//")<cr>
    nnoremap ,lS :call FileExplore("~/dotfiles/vim/bundle/vim-snippets/")<cr>
    nnoremap ,lT :call FileExplore("~/Downloads")<cr>
    nnoremap ,lV :call FileExplore("~/dotfiles/vim/source/")<cr>
    nnoremap ,lW :call FileExplore("~/Dropbox/_hours/suino_hours/")<cr>
    nnoremap ,la :call FileExplore("~/Library/")<cr />
    nnoremap ,lb :call FileExplore("~/book/")<cr>
    nnoremap ,lc :call FileExplore("~")<cr>

    nnoremap ,ld :call FileExplore("~/dotfiles/")<cr>
    nnoremap ,ldd :call FileExplore("~/dotfiles/")<cr>
    nnoremap ,ldc :call FileExplore("~/dotfiles/config")<cr>
    nnoremap ,ldl :call FileExplore("~/dotfiles/linux/")<cr>
    nnoremap ,ldm :call FileExplore("~/dotfiles/mac/")<cr>
    nnoremap ,ldn :call FileExplore("~/dotfiles/nsg/")<cr>
    nnoremap ,ldp :call FileExplore("~/dotfiles/personal/")<cr>

    nnoremap ,le :call FileExplore("~/.editinvim")<cr>

    nnoremap ,lvb :call FileExplore("~/dotfiles/vim/bundle/")<cr>
    nnoremap ,lvm :call FileExplore("~/dotfiles/vim/bundle/mine/")<cr>
    nnoremap ,lv :call FileExplore("~/dotfiles/vim/")<cr>
    nnoremap ,lvv :call FileExplore("~/dotfiles/vim/")<cr>
    nnoremap ,lvp :call FileExplore("~/dotfiles/vim/bundle/mine/ftplugin/")<cr>
    nnoremap ,lvs :call FileExplore("~/dotfiles/vim/source/")<cr>
    nnoremap ,lvS :call FileExplore("~/dotfiles/vim/bundle/mysnippets/snippets")<cr>

    nnoremap ,lg :call FileExplore("~/Google Drive")<cr>
    nnoremap ,lh :call FileExplore("~/.hammerspoon")<cr>
    nnoremap ,lk :call FileExplore("~/.config/karabiner")<cr>
    nnoremap ,ll :call FileExplore("./")<cr>
    nnoremap ,lm :call FileExplore("~/dotfiles/vim/bundle/mine")<cr>
    nnoremap ,ln :call FileExplore("~/Dropbox/note")<cr>
    nnoremap ,lnt :call FileExplore("~/Dropbox/note/todo")<cr>
    nnoremap ,lr :call FileExplore("~/.config/ranger")<cr>
    nnoremap ,ls :call FileExplore("~/dotfiles/vim/bundle/mysnippets")<cr>
    nnoremap ,lt :call FileExplore("~/Desktop")<cr>
    nnoremap ,lv :call FileExplore("~/dotfiles/vim/")<cr>
    nnoremap ,lw :call FileExplore("~/Dropbox/_hours/nsg-worklog")<cr>

    cmap ,lB ~/book/
    cmap ,lC /Volumes/nsg/nsg/clients/
    cmap ,lD ~/Dropbox/note/do
    cmap ,lH /Applications/Hammerspoon.app/Contents/Resources/extensions/hs/
    cmap ,lL ..//
    cmap ,lT ~/Downloads
    cmap ,lW ~/Dropbox/_hours/suino_hours/
    cmap ,la ~/Library/
    cmap ,lb ~/Dropbox/
    cmap ,lc ~
    cmap ,ld ~/dotfiles/
    cmap ,le ~/.editinvim/
    cmap ,lg ~/Google\ Drive/
    cmap ,lh ~/.hammerspoon/
    cmap ,lk ~/.config/karabiner/
    cmap ,ll ./
    cmap ,ln ~/Dropbox/note/
    cmap ,lnt ~/Dropbox/note/todo/
    cmap ,lr ~/.config/ranger/
    cmap ,lt ~/desktop
    cmap ,lw ~/Dropbox/_hours/nsg-worklog/

    cmap ,ld  ~/dotfiles/
    cmap ,ldd ~/dotfiles/
    cmap ,ldl ~/dotfiles/linux/
    cmap ,ldm ~/dotfiles/mac/
    cmap ,ldn ~/dotfiles/nsg/
    cmap ,ldp ~/dotfiles/personal/
    cmap ,lvb ~/dotfiles/vim/bundle/
    cmap ,lvm ~/dotfiles/vim/bundle/mine/
    cmap ,lvp ~/dotfiles/vim/bundle/mine/ftplugin/
    cmap ,lv  ~/dotfiles/vim/
    cmap ,lvv ~/dotfiles/vim/
    cmap ,lvs ~/dotfiles/vim/source/
    cmap ,lvS ~/dotfiles/vim/bundle/mysnippets/snippets/

    nnoremap ,tw :exec '!w3m  '.expand('<cWORD>')<cr><cr>

"execute
    vnoremap ,e :norm! 
    nnoremap ,ep vip \| :norm! 
    nnoremap ,es vis \| :norm! 
    nnoremap ,e" vi" \| :norm! 
    nnoremap ,e' vi' \| :norm! 

    nnoremap ,i{ vi{o<esc>i
    nnoremap ,a} vi{<esc>a
    nnoremap ,iw vi{o<esc>i
    nnoremap ,aw vi{<esc>a

    nnoremap ,is vi[o<esc>i
    nnoremap ,as vi[<esc>a

    nnoremap ,i( vi(o<esc>i
    nnoremap ,a) vi(<esc>a
    nnoremap ,i9 vi(o<esc>i
    nnoremap ,a9 vi(<esc>a
    nnoremap ,i0 vi(o<esc>i
    nnoremap ,a0 vi(<esc>a

    nnoremap ,i" vi"o<esc>i
    nnoremap ,a" vi"<esc>a

    nnoremap ,e[ vi[ \| :norm! 
    nnoremap ,e] vi] \| :norm! 

    nnoremap ,ip vipvI
    nnoremap ,ap vip \| :norm! A

    " prepend to sentence and lowercase first word
    nnoremap ,is viso<esc>guiwi <left>
    " append to sentence
    nnoremap ,as vis<esc>a
    " prepend to ""
    nnoremap ,i" vi"o<esc>i
    " append to ""
    nnoremap ,a" vi"<esc>a

    " prepend to block
    nnoremap ,ib vibo<esc>i
    " append to block
    nnoremap ,ab vib<esc>a

    nnoremap ,Ip vip \| :norm! I
    nnoremap ,Ap vip \| :norm! A

    " nnoremap ,ip vip \| :@q<cr>
    " nnoremap ,ip :undo<cr> \| :normal vip<cr> :normal @qa<cr>

    " nnoremap ,ip :undo \| :norm! vip \|  \@q
        " store it as a macro in a register
        " Do it
        " undo it
        " recall from macro

    if !empty(glob("~/dotfiles/vim/bundle/fzf.vim/"))
        nnoremap ,ff :FZF<cr>
        nnoremap ,ft :tabnew \| :FZF<cr>
        nnoremap ,fs :sp \| :FZF<cr>
        nnoremap ,fv :vsp \| :FZF<cr>
        imap <c-x><c-k> <plug>(fzf-complete-word)
        imap <c-x><c-f> <plug>(fzf-complete-path)
        imap <c-x><c-j> <plug>(fzf-complete-file-ag)
        " Hm... I like builtin better. Just use :Lines for this
        " imap <c-x><c-l> <plug>(fzf-complete-line)
    else
        " find recursively
        nnoremap ,ff :find 
        nnoremap ,ft :tabnew \| :find 
        nnoremap ,fs :sp\| :find 
        nnoremap ,fv :vsp\| :find 
    endif

" source
    " From https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc
    vnoremap ,ss y:@"<CR>:echo 'Sourced Last Selection.'<cr>
    " nnoremap <leader>0 ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>
    nnoremap ,ss ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

" substitute
    " nnoremap ,sp :,'}s/
    nnoremap ,sp vip \| :s/

" tabs
    nnoremap ta :tabfirst<CR>
    nnoremap tl :tabnext<CR>
    nnoremap th :tabprev<CR>
    nnoremap t; :tablast<CR>
    nnoremap tt :tabedit<Space>
    nnoremap tn :tabnext<Space>
    nnoremap tm :tabm<Space>
    nnoremap td :tabclose<CR>
    nnoremap t. mz \| :tabedit %<CR> \| 'z
    " nnoremap t0 1gt
    " nnoremap t1 1gt
    " nnoremap t2 2gt
    " nnoremap t3 3gt
    " nnoremap t4 4gt
    " nnoremap t5 5gt
    " nnoremap t6 6gt

" Jumps
    nnoremap <c-u> <c-o>
    nnoremap <c-o> <c-i>


" Underline headers
    nnoremap ,-j :t.<cr>^v$r-
    nnoremap ,-k :t.-1<cr>^v$r-
    nnoremap ,=j :t.<cr>^v$r=
    nnoremap ,=k :t.-1<cr>^v$r=


"================================= {


" reload syntax (for large files where sytax gets confused...
nnoremap ,sr :syntax sync fromstart<cr>
" nnoremap ,sr :syn off<cr> \| :syn on<cr>

nnoremap ,o o<cr><up><cr>
nnoremap ,O O<cr><up><cr>

" Split line with tab awareness
nnoremap <cr> i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" nnoremap <silent>,, :call NextMarker()<cr>
" inoremap <silent>,, <esc>:call NextMarker()<cr>

" inoremap ,, <C-x><C-o><C-r>=pumvisible() ? "\<lt>Down>\<lt>C-p>\<lt>Down>" : ""<CR>


" ==================================================================================
" NSG specific
" ==================================================================================

nnoremap ,nn :tabnew \| Vex /usr/local/nsgweb/4.0/<cr>
nnoremap ,nc :tabnew \| Vex /usr/local/nsgweb/4.0/classes/<cr>
nnoremap ,nm :tabnew \| Vex /usr/local/nsgweb/4.0/module/<cr>
nnoremap ,nt :tabnew \| Vex /usr/local/nsgweb/4.0/templates/<cr>
    " get module | template | class | style
    " Yo! It appears that vim does not distinguish between capital letters...
    " so you'll have to use a different selection method
nnoremap ,ngm :call SeeCorrespondingPHPFile("m")<cr>
nnoremap ,ngM :call SeeCorrespondingPHPFile("M")<cr>
nnoremap ,ngt :call SeeCorrespondingPHPFile("t")<cr>
nnoremap ,ngT :call SeeCorrespondingPHPFile("T")<cr>
nnoremap ,ngc :call SeeCorrespondingPHPFile("c")<cr> \| :x<left><left><left><left>
nnoremap ,ngC :call SeeCorrespondingPHPFile("C")<cr> \| :x<left><left><left><left>
nnoremap ,ngs :call SeeCorrespondingPHPFile("s")<cr>
nnoremap ,ngS :call SeeCorrespondingPHPFile("S")<cr>

" Mnemonic: Remote to ...
nnoremap <leader>rn :tabe sftp://dan@nsg9.nsgroupllc.com//var/www/
nnoremap <leader>rw :tabe sftp://dan@webdev.nsgroupllc.com//var/www/
nnoremap <leader>rN :e sftp://dan@nsg9.nsgroupllc.com//var/www/
nnoremap <leader>rW :e sftp://dan@webdev.nsgroupllc.com//var/www/

" gt: Go To  -- For loading filepaths
" This assumes that the line with the filename *only* contains the filename
" (for use with )
    " note that when we use these mappings, we only want there to be 2 splits
    " so for future functionality:
    "   if there is only 1 split, use the current mappings
    "   if there is more than one split
    "       quit the buffer that's not listing the file paths
    "       then, use the current mappings

" open path in split to the right
nnoremap gtl VvVgf \| :vertical resize 25<cr> \| 
" open path in split to the left
nnoremap gth VvVgf<c-w>H \| :vertical resize 25<cr> \| 
" open path in split below
nnoremap gtj VsVgfgg \| :resize 10<cr> \| 
" open path in split above
nnoremap gtk VsVgf<c-w>Kgg \| :resize 10<cr> \| 
" open path in new tab
nnoremap gtt Vgf
" Enter also: open path in new tab
nnoremap gt<cr> Vgf



" ==================================================================================
" Smart Set FileType
" ==================================================================================

" inoremap <? <esc>:set filetype=phpi<?php\?><esc>O<esc>cc
" inoremap <? i<?php?><esc>O<esc>:set filetype=phpi
" inoremap <script cc<script type="javascript"></script><esc>O<esc>:set filetype=javascripti

" add for:
" <style

" nnoremap grp :set filetype=php \| cc<?php\?><esc>Occ

" ==================================================================================
" Plugins
" ==================================================================================

"Surround
    "Surround text in line (not including tabbed space)
    nnoremap S ^v$h
    " Whenever I'm in visual, I don't need s to substitute -- c takes care of the same functionality anway.
    " Instead, I want s to Surround
    xmap s   <Plug>VSurround
    "Surround selection with tag -- mnemonic: wrap
    vnoremap <leader>w :norm yss

" Tabularize
    " if exists(":Tabularize")
    nnoremap ,t/ :Tabularize /
    vnoremap ,t/ :Tabularize /

    " endif

" Interesting Words Plugin
    let g:interestingWordsRandomiseColors = 1

    nnoremap <silent> <leader>k :call InterestingWords('n')<cr>
    nnoremap <silent> <leader>K :call UncolorAllWords()<cr>

    nnoremap <silent> n :call WordNavigation('forward')<cr>zz
    nnoremap <silent> N :call WordNavigation('backward')<cr>

" ==================================================================================
" Word Processing
" ==================================================================================

" Auto-correct spelling of last mispelled word
    nnoremap <c-s> mz[sz=1<cr><cr>``
"   You can jump to the last change with <esc><c-o>
"   The <c-g>u is necessary to set a new undo point. See :he i_CTRL-G_u
    inoremap <c-s> <c-g>u<esc>mz[sz=1<cr><cr>``a

" Get suggestions for last mispelled word
    inoremap <c-z> <esc>mz[sz=

" Just correct the misspelled word
    nnoremap ,z z=1<cr><cr>

nnoremap <leader>' 0^:call Zm()<cr>zhzhh
"scroll current char to left buffer
nnoremap <leader>" :call Zm()<cr>zhzhh
" scroll to col 0 but keep cursor position
nnoremap <leader>] :call ZM()<cr>


" ==================================================================================
" Split Remaps
" ==================================================================================

" Resize Split
    nnoremap <up> <c-w>-
    nnoremap <down> <c-w>+
    nnoremap <left> <c-w><
    nnoremap <right> <c-w>>

    nnoremap <s-up> 10<c-w>-
    nnoremap <s-down> 10<c-w>+
    nnoremap <s-left> 10<c-w><
    nnoremap <s-right> 10<c-w>>

" Change Split Directionally
    nnoremap <c-j> <c-w>j
    nnoremap <c-k> <c-w>k
    nnoremap <c-h> <c-w>h
    nnoremap <c-l> <c-w>l

" Move Split Directionally
    nnoremap <c-up> <c-w>K
    nnoremap <c-down> <c-w>J
    nnoremap <c-left> <c-w>H
    nnoremap <c-right> <c-w>L

" Move & Resize Split Directionally
    nnoremap <c-w><c-h> <c-w>H :vertical res 40<cr>
    nnoremap <c-w><c-l> <c-w>L :vertical res 40<cr>
    nnoremap <c-w><c-m> <c-w>J :res 10<cr>
    nnoremap <c-w><c-u> <c-w>K :res 10<cr>

    nnoremap <c-w><c->= <c-w>=

" Navigate among splits; assumes at max 4 vertical layouts


nnoremap v <C-V>
nnoremap <C-V> v
vnoremap v <C-V>
vnoremap <C-V> v



" ==================================================================================
" Change/Toggle Options
" ==================================================================================

" coa
" coc
" coe
" cof
" cog
" coj
" cok
" com
" coo
nnoremap cop :call ToggleForCopy()<cr>
function! ToggleForCopy()
  if &mouse == 'a'
    set mouse=
    set number!
    set paste
  else
    set mouse=a
    set number
    set nopaste
  endif
endfunction
" coq
" cot
nnoremap cow :call ToggleMyWrap()<cr>
function! ToggleMyWrap()
    if &wrap
        :echo "Wrap Off"
        set nowrap
        set formatoptions-=l
        set list
        nnoremap <silent> H :call FirstCharOrFirstCol()<cr>
        vnoremap H ^
        nnoremap L $
        vnoremap L $
    else
        :echo "Wrap On"
        set wrap
        set formatoptions+=l
        set lbr
        set nolist
        nnoremap H g0
        vnoremap H g0
        nnoremap L g$
        vnoremap L g$
    endif
endfunction
" coy
" coz


" Highlight duplicate lines
" http://stackoverflow.com/questions/1268032/marking-duplicate-lines
" nnoremap ,K :syn clear Repeat | g/^\(.*\)\n\ze\%(.*\n\)*\1$/exe 'syn match Repeat "^' . escape(getline('.'), '".\^$*[]') . '$"' | nohlsearch)'"'<cr />


" " Use clever tab completion in insert mode
" if exists("*CleverTab")
"   inoremap <Tab> <C-R>=CleverTab()<CR>
"   " nnoremap <Tab> <C-R>=CleverTab()<CR>
" endif


nnoremap ,gw :!open dict:///<cword><cr><cr>;
nnoremap ,gd :g/<c-r>=expand("<cword>")<cr>/d<left><left>
" vnoremap ,gd :g/<c-r>=expand("<cword>")<cr>/d<left><left>
nnoremap ,gv :v/<c-r>=expand("<cword>")<cr>/d<left><left>
" vnoremap ,gv :v/<c-r>=expand("<cword>")<cr>/d<left><left>
nnoremap ,gg :g/<c-r>=expand("<cword>")<cr>/
" vnoremap ,gg :g/<c-r>=expand("<cword>")<cr>/


if hostname() == "webdev" || hostname() == "nsg9"
    au BufRead,BufNewFile */templates/*.php set filetype=phtml
endif
