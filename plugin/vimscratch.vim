"Simple emacs scratch buffer implementation for vim.

let s:save_cpo = &cpo

" Let the cpo option to default vim values :h set-option
set cpo&vim

if exists('g:loaded_vimscratch')
    finish
endif

let g:loaded_vimscratch = 1
let s:default_buffer_name = '__Scratch__'

" Create a buffer
function! CreateScratchBuffer(name)
    " `` executes a shell command and assigns the output is assigned. The '='
    " prefix executes a vim variable or command
    badd `=a:name`
endfunction

function! OpenScratchBuffer()
    let name = s:default_buffer_name
    if empty(bufname(name))
        call CreateScratchBuffer(name)
    endif

    if bufwinnr(name) == -1
        exe "new " . name
        call MarkCurrentBufferAsScratch()
    endif
endfunction

function! s:MarkCurrentBufferAsScratch()
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
endfunction
