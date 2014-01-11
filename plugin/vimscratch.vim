"Simple emacs scratch buffer implementation for vim.

let s:save_cpo = &cpo

" Let the cpo option to default vim values :h set-option
set cpo&vim

if exists('g:loaded_vimscratch')
    finish
endif

let g:loaded_vimscratch = 1
let s:default_buffer_name = '__Scratch__'
let s:buffer_created = 0
let s:buffer_currently_open = 0

" Create a buffer
function! CreateScratchBuffer(name)
    " `` executes a shell command and assigns the output is assigned. The '='
    " prefix executes a vim variable or command
    badd `=a:name`
endfunction

function! OpenScratchBuffer()
    let name = s:default_buffer_name
    if s:buffer_created == 0
        call CreateScratchBuffer(name)
        let s:buffer_created = 1
    endif

    if s:buffer_currently_open == 0
        exe "new " . name
        0 put='Scratch Buffer'
        put='---------------'
        exe "normal o\e"
        call MarkCurrentBufferAsScratch()
        let s:buffer_currently_open = 1
    endif
endfunction

function! MarkCurrentBufferAsScratch()
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
endfunction
