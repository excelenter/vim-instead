
" INSTEAD functions

" instead#GrepInsteadObjects() {{{1
function! instead#GrepInsteadObjects(obj) 
  
  " GrepInsteadObjects(obj)
  " Create location list with obj

  " Clear old location list
  call setloclist(0, [])
  " Grep all the lines into location list
  silent! exe 'lvimgrep /^\s*\w\{1,}\s*=\s*' . a:obj . '/j %'
  " If location list is not empty
  if !empty(getloclist(0))
    echo ""
    lwindow
    " Close llist on WinLeave
    au WinLeave <buffer> exe 'close!'
    " Map <Esc> to close llist
    nmap <buffer> <Esc> :close!<CR>
    " Checking window position
    if exists("g:InsteadWindowPosition")
      if g:InsteadWindowPosition == 'left'
        wincmd H
        vertical resize 28
      endif
    endif
    " fixwidth, nowrap
    setlocal winfixwidth
    setlocal nowrap
    " Get rid of junk in llist
    setlocal modifiable
    silent! exe 'g/.*/s/.*|\s*\(\w\{1,}\)\s*=.*/\1/g'
    setlocal nomodifiable
    " Go to top
    normal! gg
  else
    echo "No " . a:obj . "s in file."
  endif
endfunction " 1}}}

" instead#Init() {{{1
function! instead#Init()

  if exists("g:InsteadRoomToken") 
    let s:rooms = g:InsteadRoomToken
  else
    let s:rooms = "room"
  endif

  if exists("g:InsteadObjToken")
    let s:objs = g:InsteadObjToken
  else
    let s:objs = "obj"
  endif

  if exists("g:InsteadDlgToken")
    let s:dlgs = g:InsteadDlgToken
  else
    let s:dlgs = "dlg"
  endif

  if exists("g:InsteadRoomsKey")
    let s:roomskey = g:InsteadRoomsKey
  else
    let s:roomskey = "<F5>"
  endif

  if exists("g:InsteadObjsKey")
    let s:objskey = g:InsteadObjsKey
  else
    let s:objskey = "<F6>"
  endif

  if exists("g:InsteadDlgsKey")
    let s:dlgskey = g:InsteadDlgsKey
  else
    let s:dlgskey = "<F7>"
  endif

  execute 'nnoremap ' . s:roomskey . ' :call instead#GrepInsteadObjects("' . s:rooms . '")<CR>'
  execute 'nnoremap ' . s:objskey . ' :call instead#GrepInsteadObjects("' . s:objs . '")<CR>'
  execute 'nnoremap ' . s:dlgskey . ' :call instead#GrepInsteadObjects("' . s:dlgs . '")<CR>'

endfunction
" 1}}}
"
