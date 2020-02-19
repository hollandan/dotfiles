function SortGws()
    " This assumes, of course, that the document adheres to a specific format
    silent! :%s/\n	/ zzzz/g
    silent! :sort u
    silent! :%s/ zzzz/\r	/g
    silent! :g/^\w/norm O
    execute "normal! ggdd"
    execute "normal! ggdd"
endfunction
nnoremap ,yy :call SortGws()<cr>

function Wp()
    setlocal ft=txt
    " source ~/dotfiles/vim/source/autocorrect.vim

    :SoftPencil
    :Goyo 50%x80%
    :Limelight

    " Color name (:help cterm-colors) or ANSI code
    let g:limelight_conceal_ctermfg = 'gray'
    let g:limelight_conceal_ctermfg = 240

    " Color name (:help gui-colors) or RGB color
    let g:limelight_conceal_guifg = 'DarkGray'
    let g:limelight_conceal_guifg = '#777777'

    " Default: 0.5
    let g:limelight_default_coefficient = 0.7

    " Number of preceding/following paragraphs to include (default: 0)
    let g:limelight_paragraph_span = 0

    " Beginning/end of paragraph
    "   When there's no empty line between the paragraphs
    "   and each paragraph starts with indentation
    " let g:limelight_bop = '^\s'
    " let g:limelight_eop = '\ze\n^\s'

    " Highlighting priority (default: 10)
    "   Set it to -1 not to overrule hlsearch
    let g:limelight_priority = -1
endfunction
