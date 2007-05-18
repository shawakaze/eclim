" Author:  Eric Van Dewoestine
" Version: $Revision$
"
" Description: {{{
"
" License:
"
" Copyright (c) 2005 - 2006
"
" Licensed under the Apache License, Version 2.0 (the "License");
" you may not use this file except in compliance with the License.
" You may obtain a copy of the License at
"
"      http://www.apache.org/licenses/LICENSE-2.0
"
" Unless required by applicable law or agreed to in writing, software
" distributed under the License is distributed on an "AS IS" BASIS,
" WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
" See the License for the specific language governing permissions and
" limitations under the License.
"
" }}}

runtime ftplugin/html.vim

if !exists('g:HtmlDjangoUserBodyElements')
  let g:HtmlDjangoUserBodyElements = []
endif

let g:HtmlDjangoBodyElements = [
    \ ['block', 'endblock'],
    \ ['comment', 'endcomment'],
    \ ['filter', 'endfilter'],
    \ ['for', 'endfor'],
    \ ['\(if\|e_if\)', 'else', 'elif', 'endif'],
    \ ['ifchanged', 'endifchanged'],
    \ ['ifequal', 'endifequal'],
    \ ['ifnotequal', 'endifnotequal'],
    \ ['spaceless', 'endspaceless']
  \ ] + g:HtmlDjangoUserBodyElements

" add matchit.vim support for django tags
if exists("b:match_words")
  for element in g:HtmlDjangoBodyElements
    let pattern = ''
    for tag in element[:-2]
      if pattern != ''
        let pattern .= ':'
      endif
      let pattern .= '{%\s*\<' . tag . '\>.\{-}%}'
    endfor
    let pattern .= ':{%\s*\<' . element[-1:][0] . '\>\s*%}'
    let b:match_words .= ',' . pattern
  endfor
endif

" used by indent/htmldjango.vim
let g:HtmlDjangoIndentOpenElements = ''
let g:HtmlDjangoIndentMidElements = ''
for element in g:HtmlDjangoBodyElements
  if len(g:HtmlDjangoIndentOpenElements) > 0
    let g:HtmlDjangoIndentOpenElements .= '\|'
  endif
  let g:HtmlDjangoIndentOpenElements .= element[0]

  for tag in element[1:-2]
    if len(g:HtmlDjangoIndentMidElements) > 0
      let g:HtmlDjangoIndentMidElements .= '\|'
    endif
    let g:HtmlDjangoIndentMidElements .= tag
  endfor
endfor

" vim:ft=vim:fdm=marker
