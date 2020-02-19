" Complete keywords intelligently in insert mode
function! CleverTab()
  " Act like regular tab when preceeded by non-keywordish char
  if strpart(getline('.'), col('.')-2, 1) =~ '^[^@A-Za-z0-9._-]*$'
    return "\<Tab>"
  " Else do keyword completion
  else
    return "\<C-N>"
  endif
endfunction
