" Vim-instead 0.3.0
" Fast & dirty hack for executing instead directly from vim
" FIX:
"   * Currently pid is binded to buffer (many files in one directory = many
"   insteads)
" TODO:
"   * Separate from main plugin file
"   * Maybe windows version?

let s:InsteadScriptPath = expand("<sfile>:p:h:h") . "/script/runinstead.sh"

function! InsteadRun()
  " RunInstead()
  " Save file and
  " Run shellscript
  silent! w!
  if !exists("b:insteadProcess")
    let b:insteadProcess = ""
  endif
  let b:insteadProcess = system(s:InsteadScriptPath . ' ' . expand("%:p:h") . " " . b:insteadProcess)
  echo
endfunction

command! InsteadRun :call InsteadRun()
