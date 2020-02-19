nnoremap ,hh :set filetype=html<cr>

" Clearly there is a better way to do this
function HTMLWrapInA()
    let ft  = &filetype
    execute ":set filetype=html"

    " execute 'normal! ^v$"zy'

    execute "normal! mzo</a>"
    execute "normal! my"
    execute "normal! 'zO<a href=\"\">"
    execute "normal! hmx"
    execute "normal! ='y"

    execute ":set filetype=" . ft
endfunction
nnoremap ,ha :call HTMLWrapInA()<cr>`xi
vnoremap ,ha :call HTMLWrapInA()<cr>`xi
nnoremap ,hA :call HTMLWrapInA()<cr>`xJ"_xJ"_x`xi
vnoremap ,hA :call HTMLWrapInA()<cr>`xJ"_xJ"_x`xi

function HTMLWrapInDiv()
    let ft  = &filetype
    execute ":set filetype=html"

    execute "normal! mzo</div>"
    execute "normal! my"
    execute "normal! 'zO<div>"
    execute "normal! hmx"
    execute "normal! ='y"

    execute ":set filetype=" . ft
endfunction
nnoremap ,hd :call HTMLWrapInDiv()<cr>`x
vnoremap ,hd :call HTMLWrapInDiv()<cr>`x
nnoremap ,hD :call HTMLWrapInDiv()<cr>`xJ"_xJ"_x`x
vnoremap ,hD :call HTMLWrapInDiv()<cr>`xJ"_xJ"_x`x

function HTMLWrapInSpan()
    execute ":set filetype=html"
    execute "normal! mzo</span>"
    execute "normal! my"
    execute "normal! 'zO<span>"
    execute "normal! hmx"
    execute "normal! ='y"
    execute ":set filetype=" . &filetype
endfunction
nnoremap ,hs :call HTMLWrapInSpan()<cr>'z
vnoremap ,hs :call HTMLWrapInSpan()<cr>'z
nnoremap ,hS :call HTMLWrapInSpan()<cr>'xJ"_xJ"_x
vnoremap ,hS :call HTMLWrapInSpan()<cr>'xJ"_xJ"_x

function HTMLWrapInEm()
    execute ":set filetype=html"
    execute "normal! mzo</em>"
    execute "normal! my"
    execute "normal! 'zO<em>"
    execute "normal! hmx"
    execute "normal! ='y"
    execute ":set filetype=" . &filetype
endfunction
nnoremap ,hi :call HTMLWrapInEm()<cr>'z
vnoremap ,hi :call HTMLWrapInEm()<cr>'z
nnoremap ,hI :call HTMLWrapInEm()<cr>'xJ"_xJ"_x
vnoremap ,hI :call HTMLWrapInEm()<cr>'xJ"_xJ"_x

function HTMLWrapInStrong()
    execute ":set filetype=html"
    execute "normal! mzo</strong>"
    execute "normal! my"
    execute "normal! 'zO<strong>"
    execute "normal! hmx"
    execute "normal! ='y"
    execute ":set filetype=" . &filetype
endfunction
nnoremap ,hb :call HTMLWrapInStrong()<cr>'z
vnoremap ,hb :call HTMLWrapInStrong()<cr>'z
nnoremap ,hB :call HTMLWrapInStrong()<cr>'xJ"_xJ"_x
vnoremap ,hB :call HTMLWrapInStrong()<cr>'xJ"_xJ"_x

function HTMLWrapInP()
    execute ":set filetype=html"
    execute "normal! mzo</p>"
    execute "normal! my"
    execute "normal! 'zO<p>"
    execute "normal! hmx"
    execute "normal! ='y"
    execute ":set filetype=" . &filetype
endfunction
nnoremap ,hp :call HTMLWrapInP()<cr>'z
vnoremap ,hp :call HTMLWrapInP()<cr>'z
nnoremap ,hP :call HTMLWrapInP()<cr>'xJ"_xJ"_x
vnoremap ,hP :call HTMLWrapInP()<cr>'xJ"_xJ"_x

function HTMLWrapInH1()
    execute ":set filetype=html"
    execute "normal! mzo</h1>"
    execute "normal! my"
    execute "normal! 'zO<h1>"
    execute "normal! hmx"
    execute "normal! ='y"
    execute ":set filetype=" . &filetype
endfunction
nnoremap ,h1 :call HTMLWrapInH1()<cr>'z
vnoremap ,h1 :call HTMLWrapInH1()<cr>'z
nnoremap ,h! :call HTMLWrapInH1()<cr>'xJ"_xJ"_x
vnoremap ,h! :call HTMLWrapInH1()<cr>'xJ"_xJ"_x

function HTMLWrapInH2()
    execute ":set filetype=html"
    execute "normal! mzo</h2>"
    execute "normal! my"
    execute "normal! 'zO<h2>"
    execute "normal! hmx"
    execute "normal! ='y"
    execute ":set filetype=" . &filetype
endfunction
nnoremap ,h2 :call HTMLWrapInH2()<cr>'z
vnoremap ,h2 :call HTMLWrapInH2()<cr>'z
nnoremap ,h@ :call HTMLWrapInH2()<cr>'xJ"_xJ"_x"_x
vnoremap ,h@ :call HTMLWrapInH2()<cr>'xJ"_xJ"_x"_x

function HTMLWrapInH3()
    execute ":set filetype=html"
    execute "normal! mzo</h3>"
    execute "normal! my"
    execute "normal! 'zO<h3>"
    execute "normal! hmx"
    execute "normal! ='y"
    execute ":set filetype=" . &filetype
endfunction
nnoremap ,h3 :call HTMLWrapInH3()<cr>'z
vnoremap ,h3 :call HTMLWrapInH3()<cr>'z
nnoremap ,h# :call HTMLWrapInH3()<cr>'xJ"_xJ"_x"_x
vnoremap ,h# :call HTMLWrapInH3()<cr>'xJ"_xJ"_x"_x

function HTMLWrapInH4()
    execute ":set filetype=html"
    execute "normal! mzo</h4>"
    execute "normal! my"
    execute "normal! 'zO<h4>"
    execute "normal! hmx"
    execute "normal! ='y"
    execute ":set filetype=" . &filetype
endfunction
nnoremap ,h4 :call HTMLWrapInH4()<cr>'z
vnoremap ,h4 :call HTMLWrapInH4()<cr>'z
nnoremap ,h$ :call HTMLWrapInH4()<cr>'xJ"_xJ"_x"_x
vnoremap ,h$ :call HTMLWrapInH4()<cr>'xJ"_xJ"_x"_x

function HTMLWrapInH5()
    execute ":set filetype=html"
    execute "normal! mzo</h5>"
    execute "normal! my"
    execute "normal! 'zO<h5>"
    execute "normal! hmx"
    execute "normal! ='y"
    execute ":set filetype=" . &filetype
endfunction
nnoremap ,h5 :call HTMLWrapInH5()<cr>'z
vnoremap ,h5 :call HTMLWrapInH5()<cr>'z
nnoremap ,h% :call HTMLWrapInH5()<cr>'xJ"_xJ"_x"_x
vnoremap ,h% :call HTMLWrapInH5()<cr>'xJ"_xJ"_x"_x


function HTMLWrapInH6()
    execute ":set filetype=html"
    execute "normal! mzo</h6>"
    execute "normal! my"
    execute "normal! 'zO<h6>"
    execute "normal! hmx"
    execute "normal! ='y"
    execute ":set filetype=" . &filetype
endfunction
nnoremap ,h6 :call HTMLWrapInH6()<cr>'z
vnoremap ,h6 :call HTMLWrapInH6()<cr>'z
nnoremap ,h^ :call HTMLWrapInH5()<cr>'xJ"_xJ"_x
vnoremap ,h^ :call HTMLWrapInH5()<cr>'xJ"_xJ"_x


