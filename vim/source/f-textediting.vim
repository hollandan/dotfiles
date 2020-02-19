function ChangeBetweenWrapper(twochars)
    let first = strpart(a:twochars, 0, 1)
    let last = strpart(a:twochars, strlen(a:twochars)-1, 1)
    :call ChangeBetween(first, last)
endfunction

function ChangeBetween(first, last)
    execute "normal! F" . a:first
    execute "normal! lct" . a:last
    execute "normal! l"
    execute "startinsert"
endfunction
nnoremap c= :call ChangeBetweenWrapper("")<left><left>

function DeleteBetweenWrapper(twochars)
    let first = strpart(a:twochars, 0, 1)
    let last = strpart(a:twochars, strlen(a:twochars)-1, 1)
    :call DeleteBetween(first, last)
endfunction
function DeleteBetween(first, last)
    execute "normal! F" . a:first
    execute "normal! ldt" . a:last
endfunction
nnoremap d= :call DeleteBetweenWrapper("")<left><left>

function BreakApart()
    execute "normal! "
    execute "normal! mz"
    execute "normal! vip"
    execute "normal! 10<<"

    " tab commas forward
    execute ":'<,'>s/,/\r	,/g"

    " . ! ?     go to a new line
    silent! :'<,'>g/\./normal f.li<<
    silent! :'<,'>g/\!/normal f!li<<
    silent! :'<,'>g/?/normal f?li<<

    execute "normal! `z"

endfunction

function PutTogether()

    execute "normal! "
    execute "normal! mz"
    execute "normal! vipJ"

    " put commas back
    silent! :'<,'>s/ ,/,/g

    " get rid of two spaces
    silent! :'<,'>s/  / /g

    execute "normal! `z"
    execute "normal! =="

endfunction

function Zm()
    let first_col = virtcol('.')
    execute 'normal! ' . first_col . 'zl'
endfunction

function ZM()
    let first_col = virtcol('.')
    execute 'normal! ' . first_col . 'zh'
endfunction

function ConvertFromWord()
    silent! :%s/…/\.\.\./g
    silent! :%s/–/\&mdash;/g
    silent! :%s/“/"/g
    silent! :%s/”/"/g
    silent! :%s/’/'/g
    silent! :%s/‘/'/g
endfunction


function! StripXMLSitemap()
    execute 'silent! :v/<loc>/d'
    execute 'silent! :%s/<loc>//g'
    execute 'silent! :%s/<\/loc>//g'
    execute 'normal! gg<G.'
endfunction

function! FilterCrawlErrors()

    silent! :g/^\W/d
    silent! /Rows per page:
    normal! dG
    silent! /Last Crawled
    normal! dgg

    " " filter
    silent! :g,contentfiledata,d
    silent! :g,contentimagedata,d
    silent! :g,contentblockfile,d
    silent! :g,contentblockphotos,d
    silent! :g,dbphotos,d
    silent! :g,=hootsuite,d
    silent! :g,utm_source=,d
    silent! :g,/feed/,d

endfunction

function! StripTrailingWhite()
    let l:winview = winsaveview()
    silent! %s/\s\+$//
    call winrestview(l:winview)
endfunction

function ShowSpaces(...)
    let @/='\v(\s+$)|( +\ze\t)'
    let oldhlsearch=&hlsearch
    if !a:0
        let &hlsearch=!&hlsearch
    else
        let &hlsearch=a:1
    end
    return oldhlsearch
endfunction

" This works... but it pollutes the bufferlist with hidden buffers every time
" you call it
function FileExplore(place)

    for i in range(1, bufnr("$"))
        if getbufvar(i, '&filetype') == "netrw"
            " silent exe 'bwipeout ' . i
            silent! exe 'bd ' . i
        endif
    endfor

    execute ":20vsp " . fnameescape(a:place)
endfunction

" function FileExplore(place)
"
"     if bufwinnr("explorer") > 0
"         execute ":bd! " . fnameescape("explorer")
"     endif
"
"     " for i in range(1, bufnr("$"))
"     "     if buflisted(i)
"     "         if getbufvar(i, '&filetype') == "netrw"
"     "             silent exe 'bwipeout ' . i
"     "         endif
"     "     endif
"     " endfor
"
"     execute ":Lexplore! " . fnameescape(a:place)
"     " execute ":silent file explorer"
"     execute ":vertical resize 20"
" endfunction

" make markers that look like this
"   +=+=       <- jump here, normal mode
" or this
"   +=+i       <- jump here, insert mode
" ※	:X	203B	8251	REFERENCE MARK
" ₀	0s	2080	8320	SUBSCRIPT ZERO
"⊥	-T	22A5	8869	UP TACK
" ≪	<*	226A	8810	MUCH LESS-THAN
" ≫	*>	226B	8811	MUCH GREATER-THAN
" function NextMarker()
"     execute 'normal! /+=+\3"_x'
"     let char = matchstr(getline('.'), '\%' . col('.') . 'c.')
"     echom char
"     if char == "i"
"         execute 'normal! "_x'
"         execute "startinsert"
"     elseif char == "a"
"         execute 'normal! "_x'
"         execute "startinsert"
"         " this moves the cursor one char right -- effectively, startappend
"         call cursor( line('.'), col('.') + 1)
"     endif
" endfunction
" function NextMarker()
"     execute 'normal! /⊥\"_x'
"     let char = matchstr(getline('.'), '\%' . col('.') . 'c.')
"     echom char
"     if char == "≪"
"         execute 'normal! "_x'
"         execute "startinsert"
"     elseif char == "≫"
"         execute 'normal! "_x'
"         execute "startinsert"
"         " this moves the cursor one char right -- effectively, startappend
"         call cursor( line('.'), col('.') + 1)
"     endif
" endfunction

