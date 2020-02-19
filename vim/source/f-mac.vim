function Spotlight(search)
    execute ":tabnew spotlight"
    " execute "resize 20"
    execute "normal! V"
    "open selection in new tab
    nnoremap <buffer> t V<c-w>gf
    "open selection
    nnoremap <buffer>  Vgf
    "open selection in new split
    nnoremap <buffer> s V<c-w><c-f>:resize 45<cr>
    " d => Browse directory of selected file
    nnoremap <buffer> d 0<c-v>$F/<c-w><c-f>:resize 45<cr>
    " D => Open a new tab an Browse directory of selected file
    nnoremap <buffer> D 0<c-v>$F/"xy:tabnew \| :Vex x<cr>
    setlocal buftype=nowrite bufhidden=hide noswapfile nobuflisted
    " perhaps we can extend this to include mail searches if we want...
    execute ":read !mdfind kind:document " . a:search . " | grep -v \/Users\/dan\/Library\/"
    " execute ":read !mdfind kind:document " . a:search . " | grep -v \/Users\/dan\/Library\/Mail\/ | grep -v mail\/Data\/Library\/Mail"
    execute "normal! gg_dd"
endfunction
nnoremap ,q :call Spotlight("")<left><left>

function Locate(search)
    execute ":tabnew spotlight"
    " execute "resize 20"
    execute "normal! V"
    "open selection in new tab
    nnoremap <buffer> t V<c-w>gf
    "open selection
    nnoremap <buffer>  Vgf
    "open selection in new split
    nnoremap <buffer> s V<c-w><c-f>:resize 45<cr>
    " d => Browse directory of selected file
    nnoremap <buffer> d 0<c-v>$F/<c-w><c-f>:resize 45<cr>
    " D => Open a new tab an Browse directory of selected file
    nnoremap <buffer> D 0<c-v>$F/"xy:tabnew \| :Vex x<cr>
    setlocal buftype=nowrite bufhidden=hide noswapfile nobuflisted
    " perhaps we can extend this to include mail searches if we want...
    execute ":read !locate kind:document " . a:search . " | grep -v \/Users\/dan\/Library\/"
    " execute ":read !locate kind:document " . a:search . " | grep -v \/Users\/dan\/Library\/Mail\/ | grep -v mail\/Data\/Library\/Mail"
    execute "normal! gg_dd"
    " apparently, locate retuns results in resverse order relative to mdfind,
    " so let's auto-jump to the end of the file
    execute "normal! G"
endfunction
nnoremap ,Q :call Locate("")<left><left>
" Probably worth it to figure out how to update the loacte database more often
" than one week if we plan to use this regularly.
