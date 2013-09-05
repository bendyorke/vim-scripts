function! CompileSelectors (input)
  let element=ParseElement(a:input)
  return '<'.element.'>'.CloseTag(element)
endfunction

function! ParseElement (input)
  let escapedInput=escape(a:input, '^$.*\/~[]')
  let elementWithClass=substitute(escapedInput, '\\\.\([^\.#]*\)', ' class="\1"', 'g') 
  let elementWithId=substitute(elementWithClass, '#\([^\.#]*\)', ' id="\1"', 'g') 
  return substitute(elementWithId, '\\\([\^\$\.\*\\\/\~\[\]\)', '\1', 'g')
endfunction

function! CloseTag (input)
  return '</'.matchstr(a:input, '\S\+', 0, 1).'>'
endfunction

imap <Leader><Tab> <Esc>vBdi
  \<C-R>=CompileSelectors('<C-r>"')<CR>
  \<Esc><<F<i

imap <Leader><Return> <Esc>vBdi
  \<C-R>=CompileSelectors('<C-r>"')<CR>
  \<Esc><<F<i<Return><Esc>O
