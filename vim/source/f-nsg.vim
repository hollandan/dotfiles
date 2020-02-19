let s:host = system("echo $HOSTNAME")

function NewWorklogEntry()
    nnoremap  vip<esc><esc>`<"xyy`>o<esc>p$

    execute  "normal! vip"
    " get time in reg x
    execute 'normal! `<"xyyj'
    let duration = str2float(expand('<cWORD>'))

    let divider = 0.25
    let multiplier = duration/divider*15
    execute 'normal! `>op$'

    " Not using this, but it's interesting.
    " Basically: get the integer by striping the last two chars of the float (.0)
    " let smultiplier = strpart(string(multiplier), -2, strlen(string(multiplier)))
    " execute 'normal ' . smultiplier . ""

     let c = 1
     let total = 0
     while c <= multiplier
       let total += c
       let c += 1
       " this relies on tpope's speeddating... therefore, not normal!
       execute "normal "
     endwhile

endfunction

function! LogTimeInNSGDatabase()
    normal! vipoV
    normal! mz
    :.!pbcopy
    normal! u
    normal! j0W"zy$
    execute "!nsg w " . tolower(getreg('z'))
    " normal! <cr><cr>
    " normal! }
    " normal! 'z
endfunction

function SeeCorrespondingPHPFile(...)
    " This of course assumes nsgweb file structure
    let current = expand('%:p:h')
    let splt = split(current, "/")
    let file = expand('%:t')
    let path = "/" . splt[0] . "/" . splt[1] . "/" . splt[2] . "/"

    let dash = stridx(file, "-")
    let dot  = stridx(file, "\.")

    let filename = ""
    if (dash > 0)
        let filename = strpart(file, 0, dash)
    else
        let filename = strpart(file, 0, dot)
    endif

    " is there a better way to do this? Almost certainly.
    " But does this do what I want?
    " Sure does
    if a:1 == "m"
        execute ":aboveleft split" . path . "modules/" . tolower(filename) . ".php"
    elseif a:1 == "M"
        execute ":tabedit" . path . "modules/" . tolower(filename) . ".php"
    elseif a:1 == "t"
        execute ":split" . path . "templates/" . tolower(filename) . ".php"
    elseif a:1 == "T"
        execute ":tabedit" . path . "templates/" . tolower(filename) . ".php"
    elseif a:1 == "c"
        let @x = "vertical split " . path . "classes/" . toupper(file[0]) . strpart(filename, 1, strlen(filename)) . ".php"
    elseif a:1 == "C"
        let @x = ":tabedit " . path . "classes/" . toupper(file[0]) . strpart(filename, 1, strlen(filename)) . ".php"
    elseif a:1 == "s"
        execute ":45vsp" . path . "css/" . tolower(strpart(file, 0, strlen(filename)-3)) . ".css"
    elseif a:1 == "S"
        execute ":tabedit" . path . "css/" . tolower(strpart(file, 0, strlen(filename)-3)) . ".css"
    endif
endfunction

function ViewNSGErrorLog(...)

    let l:current = expand('%:p:h')
    if !a:0
        let splt = split(current, "/")

        if s:host =~ "9"
            let l:dir = splt[2]
            let l:log = "/error_log"
        elseif s:host =~ "10"
            let l:dir = splt[3]
            let l:log = "/error_log"
        elseif s:host =~ "bde" || s:host =~ "12" || s:host =~ "13"
            let l:dir = splt[3]
            let l:log = "/error.log"
        else
            echom "Wrong server numnuts"
            return
        endif

        let l:errorlog = "/var/log/web/" . l:dir . l:log

    else
        let l:errorlog = a:1
    endif

    let l:tempname = l:errorlog . "TEMP"

    execute "silent! bw " . fnameescape(l:tempname)

    execute ":bot sp " . fnameescape(l:tempname)
    execute ":read !tail -n 800 " . fnameescape(l:errorlog)
    execute "normal! ggddG"
    execute ":res4"

    " ditch common erros we don't need to see
    execute "silent! :g/provided via SNI/d"
    execute "silent! :g/Missing argument 1 for EmailLogs/d"
    execute "silent! :g/Undefined variable: metakeywords/d"
    execute "silent! :g/Undefined variable: metadescription/d"
    execute "silent! :g/Undefined variable: pagetitle/d"
    execute "silent! :g/Undefined property: Photo::$origtime/d"

    execute "normal! zb"

    execute ":set filetype=nsglog"
endfunction
if s:host =~ "9" || s:host =~ "10" || s:host =~ "bde"
    nnoremap ,x :call ViewNSGErrorLog()<cr>G
    nnoremap ,X :call ViewNSGErrorLog("/var/log/web//error_log")<left><left><left><left><left><left><left><left><left><left><left><left>
endif
if s:host =~ "12" || s:host =~ "13"
    nnoremap ,x :call ViewNSGErrorLog()<cr>G
    nnoremap ,X :call ViewNSGErrorLog("/var/log/web//error.log")<left><left><left><left><left><left><left><left><left><left><left><left>
endif

function ViewNSGAccessLog(...)
    let current = expand('%:p:h')
    if !a:0
        let splt = split(current, "/")

        if s:host =~ "bde" || s:host =~ "9"
            let l:dir = splt[2]
            let l:log = "/access_log"
        elseif s:host =~ "10"
            let l:dir = splt[3]
            let l:log = "/access_log"
        elseif s:host =~ "12" || s:host =~ "13"
            let l:dir = splt[3]
            let l:log = "/access.log"
        else
            echom "Wrong server numnuts"
            return
        endif
    else
        let l:errorlog = a:1
    endif

    let l:errorlog = "/var/log/web/" . l:dir . l:log
    " let l:errorlog = "/var/log/web/" . splt[2] . "/access_log"

    let l:tempname = l:errorlog . "TEMP"

    execute "silent! bw " . fnameescape(l:tempname)

    execute ":bot sp " . fnameescape(l:tempname)
    execute ":read !tail -n 3000 " . fnameescape(l:errorlog)
    execute "normal! ggddG"
    execute ":res10"
    execute ":set filetype=nsglog"
    execute "normal! zb"
endfunction
if s:host =~ "9" || s:host =~ "10"
    nnoremap ,a :call ViewNSGAccessLog()<cr>G
    nnoremap ,A :call ViewNSGErrorLog("/var/log/web//access_log")<left><left><left><left><left><left><left><left><left><left><left><left><left>
endif
if s:host =~ "12" || s:host =~ "13"
    nnoremap ,a :call ViewNSGAccessLog()<cr>G
    nnoremap ,A :call ViewNSGErrorLog("/var/log/web//access.log")<left><left><left><left><left><left><left><left><left><left><left><left><left>
endif

function SeeCorrespondingEntry()
    let current = expand('%:p:h')
    let splt = split(current, "/")
    let l:thislog = expand('%:t')

    if l:thislog == "access_log"
        " convert the timestamp to the error_log timestamp, and place it in register x
        execute 'normal! 0df[dwea plr ldwEa p0xf:x0"x4yE'
        let l:correspondinglog = "/var/log/web/" . splt[3] . "/error_log"
    else
        " convert the timestamp to the access_log timestamp, and place it in register x
        execute 'normal! 0xdwdwea\/pcw\/ElxdwF/pa:f]x0"xyiW'
        let l:correspondinglog = "/var/log/web/" . splt[3] . "/access_log"
    endif

    " if the errorlog is already open, force kill it
    if bufwinnr(g:thislog) > 0
        execute ":bd! " . fnameescape(g:thislog)
    endif

    execute ":sp" . fnameescape(g:correspondinglog)
    execute ":res10"
    execute ":set filetype=nsglog"
    execute 'normal! /x'
endfunction
nnoremap ,c :call SeeCorrespondingEntry()<cr>
" if we didn't find an entry, we can try to remove the last two chars (the
" seconds) and search for the hour & minute
nnoremap ,C /x<bs><bs><cr>

function ToggleNSGErrorLogEntry()
    execute 'normal! $'
    execute 'normal! ?['
    let line=getline('.')
    if strlen(line) > 60
        execute ':call OpenNSGErrorLogEntry()'
    else
        execute ':call CloseNSGErrorLogEntry()'
    endif
endfunction

function OpenNSGErrorLogEntry()
    let g:thislog = expand('%:t')

    if g:thislog == "access_log"
        execute 'normal! 0f]ll'
        execute 'normal! i    '
        execute 'normal! 4f"ll'
        execute 'normal! i'
        execute 'normal! f)ll'
        execute 'normal! i'
        execute 'normal! kkk0'
    else
        " execute 'normal! $'
        " execute 'normal! ?[\'
        " let line=getline('.')
        " if strlen(line) > 60

        " separate line
        execute 'normal! Ojok'


        "move the error to the next line
        execute 'normal! 0'
        execute 'normal! 3f]l'
        execute 'normal! i    '

        " replace all 
        execute 'silent! :s/ in / in    '
        execute 'silent! :s/ on line /:'

        " replace all newlines w/ newline and tab
        execute 'silent! :s/\\n/	/g'


        execute 'normal! f,l'
        execute 'normal! i'
        execute 'normal! kk0'

        " go to the top of the entry
        execute 'normal! vipo'
        execute 'normal! zt'
        " endif
    endif
endfunction
function CloseNSGErrorLogEntry()
    let g:thislog = expand('%:t')

    if g:thislog == "access_log"
        execute 'normal! $'
        execute 'normal! ?\(\d\+\.\)\{3\}\d\{1,3\}'
        execute ':join'
        execute ':join'
        execute ':join'
        execute 'normal! 0'
    else
        execute "normal! vip"
        execute "silent! :'<,'>s/	/\\n/g"
        execute "normal! vip"
        execute ":'<,'>join"
        execute ':normal! j"_ddk"_dd'

        execute 'silent! :s/ in    / in '
        " execute 'silent! :s/:/ on line '

    endif
endfunction

" View all styles (common nsg styles)
function! Vas()
    let current = expand('%:p:h')
    let splt = split(current, "/")

    if s:host =~ "9"
        let l:dir = splt[2]
    elseif  s:host =~ "bde" || s:host =~ "13"
        let l:dir = "sites/" . splt[3]
    else
        echom "Wrong server numnuts"
        return
    endif

    let path = "/var/www/" . l:dir . "/css/"

    execute ":tabedit" . fnameescape(path."styles.css")

    if filereadable(fnameescape(path."biggest.css"))
        execute ":vsp" . fnameescape(path."biggest.css")
    endif
    if filereadable(fnameescape(path."mobile.css"))
        execute ":vsp" . fnameescape(path."mobile.css")
    endif
    if filereadable(fnameescape(path."cssmenu.css"))
        execute ":vsp" . fnameescape(path."cssmenu.css")
    endif

    execute ":wincmd ="

endfunction
cabbr vas call Vas()<cr>

" View module/template in a split
command! -nargs=1 VMT call VMT(<q-args>)
function VMT(file)
    let current = expand('%:p:h')
    let splt = split(current, "/")
    let g:path = "/var/www/" . splt[2]
    execute ":tabedit" . fnameescape(g:path."/modules/".a:file.".php")
    execute ":sp"  . fnameescape(g:path."/templates/".a:file.".php")
    execute ":resize 35"
endfunction


function FillClassFromConstructor()
    execute ':call PopulatePrivates()'
    " set a mark, then reverse lines
    execute 'normal! mz('
    execute ":silent 'z,.g/^/m 'z"
    " execute ":noh"
    execute ":'<,'>call ConvertToGetFunction()"
    " set a mark, then reverse lines back
    execute 'normal! jmz('
    execute ":silent 'z,.g/^/m 'z"
endfunction
function PopulatePrivates()
    " a: move columns into bind result
    execute 'normal! yypdti/fromhdf;v^"xddd/bind_result/el"xp'
    " b: add $this-> to each variable
    execute 'normal! T(i$this->'
    execute 'normal! vt):s/, /, \$this\-\>/g'
    " d: add private variables for each column
    execute 'normal! ?construct'
    execute 'normal! Ok"xpIprivate $'
    execute 'normal! v$:s/, /;\rprivate \$/gA;'
    execute "normal! vip='>"
endfunction
function ConvertToGetFunction()
    " q: convert to get function
    execute 'normal! mx"xyy/{%o'
    execute 'normal! pdf$"xywipublic function getl~$s() {'
    " Fill in the get function the 'get/e' is there to add a position to the
    " jumplist, in case we want to quickly jump back and change the name of
    " the function
    execute 'normal! Oreturn $this->"xpa;==o}kk0/get/e\l'
    " Now, jump back to the previous private variable and go up one line to repeat
    execute "normal! 'xk"
endfunction
