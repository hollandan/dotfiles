" http://vim.wikia.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
" Get syntax highlight under cursor
nnoremap ,Y :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

if has("autocmd") && exists("+omnifunc")
autocmd Filetype *
        \	if &omnifunc == "" |
        \		setlocal omnifunc=syntaxcomplete#Complete |
        \	endif
endif

" vim-mucomplete
" needed to not conflict with other/older versions of vim...
if has("completeopt")
    set completeopt+=menuone
    set completeopt+=noselect
    set completeopt+=noinsert
    set shortmess+=c   " Shut off completion messages
    set belloff+=ctrlg " If Vim beeps during completion
endif

let g:mucomplete#chains = {}
let g:mucomplete#chains.default  = ['incl', 'path', 'omni', 'keyn', 'dict', 'uspl']


nnoremap gs yiw:s/<C-r>"//g<Left><Left>
nnoremap gS yiw:%s/<C-r>"//g<Left><Left>
xnoremap gs y:s/<C-r>"//g<Left><Left>
xnoremap gS y:%s/<C-r>"//g<Left><Left>

" { and } land on text instead of whitespace
:nnoremap <expr> { len(getline(line('.')-1)) > 0 ? '{+' : '{-'
:nnoremap <expr> } len(getline(line('.')+1)) > 0 ? '}-' : '}+'

" ********************************************************************************

autocmd BufReadPost *.doc,*.docx,*.rtf,*.odp,*.odt silent %!pandoc "%" -tplain -o /dev/stdout
autocmd BufReadPost *.pdf silent %!pdftotext -l 10 -nopgbrk -q "%"

" ********************************************************************************

nmap <Plug>TransposeCharacters xp
\:call repeat#set("\<Plug>TransposeCharacters")<CR>
nmap cp <Plug>TransposeCharacters

" ********************************************************************************

vnoremap <silent> <leader>Y :'<,'>!markdown \| textutil -stdin -format html -convert rtf -stdout \| pbcopy<cr> \| :undo


"******************************
nnoremap <silent> <Plug>TransposeCharacters xp :call repeat#set("\<Plug>TransposeCharacters")<CR>
nmap cp <Plug>TransposeCharacters
"******************************


" if !empty(glob("~/dotfiles/vim/bundle/fzf.vim/"))
   " if we have fzf, venture forth without fear

   " Seemed like a good idea at the time, but actually, a huge pain in the ass
   " cmap ls Buffers
   " cmap old History
   " cmap marks Marks

" else
" endif

" Originally from romainl
"     https://gist.github.com/Konfekt/d8ce5626a48f4e56ecab31a89449f1f0
" Forked for better ui by Konfekt
"     https://gist.github.com/Konfekt/d8ce5626a48f4e56ecab31a89449f1f0
function! <sid>CCR()
    if getcmdtype() isnot# ':'
    return "\<CR>"
    endif
    let cmdline = getcmdline()
    if cmdline =~# '\v^\s*(ls|files|buffers)!?\s*(\s[+\-=auhx%#]+)?$'
        " like :ls but prompts for a buffer command
        return "\<CR>:b"
    elseif cmdline =~# '\v/(#|nu%[mber])$'
        " like :g//# but prompts for a command
        return "\<CR>:"
    elseif cmdline =~# '\v^\s*(dli%[st]|il%[ist])!?\s+\S'
        " like :dlist or :ilist but prompts for a count for :djump or :ijump
        return "\<CR>:" . cmdline[0] . "j  " . split(cmdline, " ")[1] . "\<S-Left>\<Left>"
    elseif cmdline =~# '\v^\s*(cli|lli)%[st]!?\s*(\s\d+(,\s*\d+)?)?$'
        " like :clist or :llist but prompts for an error/location number
        return "\<CR>:sil " . repeat(cmdline[0], 2) . "\<Space>"
    elseif cmdline =~# '\v^\s*ol%[dfiles]\s*$'
        " like :oldfiles but prompts for an old file to edit
        set nomore
        return "\<CR>:sil se more|e #<"
    elseif cmdline =~# '^\s*changes\s*$'
        " like :changes but prompts for a change to jump to
        set nomore
        return "\<CR>:sil se more|norm! g;\<S-Left>"
    elseif cmdline =~# '\v^\s*ju%[mps]'
        " like :jumps but prompts for a position to jump to
        set nomore
        return "\<CR>:sil se more|norm! \<C-o>\<S-Left>"
    elseif cmdline =~ '\v^\s*marks\s*(\s\w+)?$'
        " like :marks but prompts for a mark to jump to
        return "\<CR>:norm! `"
    elseif cmdline =~# '\v^\s*undol%[ist]'
        " like :undolist but prompts for a change to undo
        return "\<CR>:u "
    else
        " " This line breaks older version of vim... it ads c-] verbatim when
        " hitting enter on the vim commandline
        " return "\<c-]>\<CR>"
        return "\<CR>"
    endif
endfunction
cnoremap <expr> <CR> <sid>CCR()

