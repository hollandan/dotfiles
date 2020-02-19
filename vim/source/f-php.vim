nnoremap ,hh :set filetype=php<cr>

function! PHPInlineForeach()
    let ft  = &filetype
    execute ":set filetype=html"

    execute "normal! mzo<?php endforeach ?>"
    execute "normal! O+=+a"
    execute "normal! my"
    execute "normal! 'zcc<?php foreach (+=+i as +=+i): ?>"
    execute "normal! hmx"
    execute "normal! ='y"

    execute ":set filetype=" . ft
endfunction
nnoremap ,pf :call PHPInlineForeach()<cr>`x0 \| :set ft=php<cr>
" vnoremap ,pf :call PHPInlineForeach()<cr>`xi
" nnoremap ,pf :call PHPInlineForeach()<cr>`xJ"_xJ"_x`xi
" vnoremap ,pf :call PHPInlineForeach()<cr>`xJ"_xJ"_x`xi
