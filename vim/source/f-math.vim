let g:totalreg = 0
let g:sumreg = 0

function! Sum(number)
  let g:sumreg  = g:sumreg + a:number
  return a:number
endfunction

function! SumLine()
    let g:sumreg = 0
    silent! :s/\d\+/\=Sum(submatch(0))/g
    let @x = g:sumreg
endfunction

function! SumSelection()
    let g:sumreg = 0
    silent! :'<,'>s/\d\+/\=Sum(submatch(0))/g
    let @x = g:sumreg
endfunction


""sum next line
" nnoremap ,s= 0/\d<cr> \| :call SumLine()<cr>
" vnoremap ,s= :call SumSelection()<cr>
