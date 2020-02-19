function! PadMe()
    execute ":leftabove vsp padddd"
    execute ":vertical resize 40"

    execute "normal! l"
    execute ":set wrap"
    execute ":set nonumber"

    execute ":rightbelow vsp padddd"
    execute ":vertical resize 40"
    setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile

    execute "normal! h"
endfunction

function! ToggleColorScheme()
    if g:colors_name == "badwolf"
        execute ":colorscheme dues"
        execute "set background=dark"
        " set statusline=%F%m%r%h%w%y%={%04v\|%04l/%L:%p%%}
    elseif g:colors_name == "dues"
        execute ":colorscheme djhiii"
    else
        execute ":colorscheme badwolf"
        " set statusline=%F%m%r%h%w%y%={%04v\|%04l/%L:%p%%}
    endif
endfunction
nnoremap ,<tab> :call ToggleColorScheme()<cr>

" Shamelessly stolen from https://stackoverflow.com/questions/2075276/longest-line-in-vim and modifed to do my bidding
function! ResizeBufferToLongestLineWidth()
    execute "normal! mz"
    let maxlength   = 0
    let linenumber  = 1
    while linenumber <= line("$")
        exe ":".linenumber
        let linelength  = virtcol("$")
        if maxlength < linelength
            let maxlength = linelength + 5
        endif
        let linenumber  = linenumber+1
    endwhile
    execute ":vertical resize " . maxlength
    execute "normal! `z"
endfunction
" nnoremap  <c-s> :call ResizeBufferToLongestLineWidth()<cr>

function DeleteBufferSmartly(...)
    if !a:0
        if winnr("$") > 1
            execute ":bp|bd #"
        else
            execute ":bd"
        endif
    else
        if winnr("$") > 1
            execute ":bp|bd! #"
        else
            execute ":bd!"
        endif
    endif
endfunction

"http://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]
    return join(lines, "\n")
    " return lines
endfunction

" SplitSelectedHorizontal()    split selection below
" SplitSelectedHorizontal(1)   split selection above
" SplitSelectedHorizontal(2)   horizontally resize pane buffer height
function SplitSelectedHorizontal(...)
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = lnum2 - lnum1 +1

    if !a:0
        execute ":rightbelow " . lines . " split"
    elseif a:1 == 1
        execute ":leftabove " . lines . " split"
    else
        execute ":resize " . lines
    endif

    execute "'<"
    execute "normal! zt"

    if !a:0
        execute "normal! k"
    elseif a:1 == 1
        execute "normal! j"
    endif
endfunction
vnoremap ,sj <esc>:call SplitSelectedHorizontal()<cr>
nnoremap ,sj vip<esc>:call SplitSelectedHorizontal()<cr>
vnoremap ,sk <esc>:call SplitSelectedHorizontal(1)<cr>
nnoremap ,sk vip<esc>:call SplitSelectedHorizontal(1)<cr>
vnoremap ,si <esc>:call SplitSelectedHorizontal(2)<cr>
nnoremap ,si vip<esc>:call SplitSelectedHorizontal(2)<cr>

" SplitSelectedVertical()      split selection vertical right
" SplitSelectedVertical(1)     split selection vertical left
" SplitSelectedVertical(2)     vertical resize pane to column width
function SplitSelectedVertical(...)
    let l:linelength  = virtcol("$")

    let l:widestline = max(map(range(line("'<"), line("'>")), "col([v:val, '$'])")) + 5
    if l:widestline > &columns/2
        let l:widestline = &columns/2
    endif

    if !a:0
        execute ":" . l:widestline . "vsplit "
    elseif a:1 == 1
        execute ":leftabove " . l:widestline . "vsplit"
        echom ":leftabove " . l:widestline . "vsplit"
    else
        let l:widestline = l:widestline - 5
        execute ":vertical resize " . l:widestline
    endif

    if !a:0
        execute "normal! h"
    elseif a:1 == 1
        execute "normal! l"
    endif
endfunction
vnoremap ,sl <esc>:call SplitSelectedVertical()<cr>
nnoremap ,sl mzvipo<esc>:call SplitSelectedVertical()<cr>'z
vnoremap ,sh <esc>:call SplitSelectedVertical(1)<cr>
nnoremap ,sh mzvipo<esc>:call SplitSelectedVertical(1)<cr>'z
vnoremap ,s; <esc>:call SplitSelectedVertical(2)<cr>
nnoremap ,s; mzvipo<esc>:call SplitSelectedVertical(2)<cr>'z

" Resize pane to height & width
vnoremap ,sx <esc>:call SplitSelectedVertical(2)<cr>:call SplitSelectedHorizontal(2)<cr>
nnoremap ,sx mzvipo<esc>:call SplitSelectedVertical(2)<cr>:call SplitSelectedHorizontal(2)<cr>'z
