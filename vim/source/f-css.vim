" See this for a regex that {contains this} but {not that}
" https://vi.stackexchange.com/questions/4902/search-for-lines-which-contain-a-pattern-but-do-not-contain-a-second-pattern

" The following is almost right... but it still adds ; after commented lines
" ... though that's not improper syntax so... do we care?

" function LintCSSNSG
" function CleanCSS()
"     execute "normal! mz"
"
"     " make sure all appropriate lines end in a single emicolon
"     silent! v/.*:.*;$/norm A;
"
"     "clean up last command...
"     silent! %s/^;$//g
"     silent! %s/{;/{/g
"     silent! %s/};/}/g
"
"     silent! %s/^3/#/g
"     silent! %s/;;/;/g
"
"     silent! g/\a0\a/norm 0f0r-
"     silent! g/\a=\a/norm 0f=r-
"
"     "" this curently breaks pseudo elements
"     "" we need to call this on lines that don't contain a {
"     "" or... gg=G, then all it on every line that isn't indeted or starts with a tab
"     "" silent! g/\w:\S/norm 0f:a 
"
"     " for all lines that have a property/attribute not separated by a space AND don't have a {
"     " put a space between them
"     " ... wanna guess how many beers it took to figure that bitch out?
"     silent! g/\(.*\w:\S\)\&\(.*{\)\@!/norm 0f:a 
"
"     silent! %s/  / /g
"
"     execute "normal! gg=G"
"     execute "normal! `z"
" endfunction

function CleanCSS()
    execute "normal! mz"

    " make sure all appropriate lines end in a single emicolon
    normal! A;
    silent! s/;/;/g

    "clean up last command...
    silent! %s/^;$//g
    silent! %s/{;/{/g
    silent! %s/};/}/g

    silent! s/^3/#/
    silent! s/^4/\$/

    silent! g/\a0\a/norm 0f0r-
    silent! g/\a=\a/norm 0f=r-

    "" this curently breaks pseudo elements
    "" we need to call this on lines that don't contain a {
    "" or... gg=G, then all it on every line that isn't indeted or starts with a tab
    "" silent! g/\w:\S/norm 0f:a 

    " for all lines that have a property/attribute not separated by a space AND don't have a {
    " put a space between them
    " ... wanna guess how many beers it took to figure that bitch out?
    silent! g/\(.*\w:\S\)\&\(.*{\)\@!/norm 0f:a 

    silent! %s/  / /g

    execute "normal! gg=G"
    execute "normal! `z"
endfunction
