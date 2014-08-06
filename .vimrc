" setup NERDTree
nnoremap <F2> :NERDTreeToggle<CR>

" setup tagslist
:set tags=~/mytags

" preview window... to get it to open vert right, or horiz as desired
function PreviewTag(top)
  "by MW
  set previewheight=25
  exe "silent! pclose"
  if &previewwindow " don't do this in the preview window
    return
  endif
  let w = expand("<cword>") " get the word under cursor
  exe "ptjump " . w
  " if any non False arg, open in simple horiz window so simply return
  if a:top
    return
  endif
  " otherwise, make it vertical
  exe "silent! wincmd P"
  if &previewwindow " if we really get there...
    if has("folding")
      silent! .foldopen " don't want a closed fold
    endif
    wincmd L " move preview window to the left
    wincmd p " back to caller
    if !&previewwindow " got back
      wincmd _
      " make caller full size (I use minibufexplorer and for some reason
      " the window is altered by the preview window split and manipulation
      " so wincmd _ sets it back... your mileage may vary
    endif
  endif
endfunction

" right hand window full height preview window
inoremap <F3> <Esc>:call PreviewTag(0)<CR>
nnoremap <F3> :call PreviewTag(0)<CR>
" <A-..> not work, ignore them
" simple "above the caller" preview window,
"nnoremap <A-]> :call PreviewTag(1)<CR>
"inoremap <A-]> <Esc>:call PreviewTag(1)<CR>
" close preview
"noremap <A-[> <Esc>:pc<CR>
noremap <F4> <Esc>:pc<CR>

" add auto completion
filetype plugin on
set omnifunc=syntaxcomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete

" set autoindent
filetype plugin indent on

" set foldmethod to indent for python
autocmd FileType python set foldmethod=indent
autocmd FileType python set foldnestmax=2

" remove all trailing spaces automatically for python
autocmd FileType python autocmd BufWritePre <buffer> :%s/\s\+$//e

" setting for go
" Some Linux distributions set filetype in /etc/vimrc.
" Clear filetype flags before changing runtimepath to force Vim to reload them.
if exists("g:did_load_filetypes")
  filetype off
  filetype plugin indent off
endif
set runtimepath+=/home/sam/opt/go/misc/vim " replace $GOROOT with the output of: go env GOROOT
filetype plugin indent on
syntax on
autocmd FileType go autocmd BufWritePre <buffer> Fmt
