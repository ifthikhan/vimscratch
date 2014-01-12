"Simple emacs scratch buffer implementation for vim.

let s:save_cpo = &cpo

" Let the cpo option to default vim values :h set-option
set cpo&vim

if exists('g:loaded_vimscratch')
    "finish
endif

let g:loaded_vimscratch = 1
let s:default_buffer_name = '__Scratch__'

" Create a buffer
function! CreateScratchBuffer(name)
    " `` executes a shell command and assigns the output is assigned. The '='
    " prefix executes a vim variable or command
    badd `=a:name`
endfunction

" Opens the scratch buffer. It creates the buffer if not created and loads it.
" The split position can be controlled by supplying the appropriate split
" modifiers specified by vim see :h :vert
function! s:OpenScratchBuffer(split_modifier)
    let name = s:default_buffer_name
    if empty(bufname(name))
        call CreateScratchBuffer(name)
    endif

    if bufwinnr(name) == -1
        if empty(bufname("%")) && !&modified
            exe 'edit ' . name
        else
            " KLUGY: Ideally control the positioning using vim positioning
            " modifiers eg: :h :vert
            exe a:split_modifier . ' split ' . name
        endif
        call s:MarkCurrentBufferAsScratch()
    endif
endfunction

function! s:MarkCurrentBufferAsScratch()
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
endfunction

" Command to edit the scratch buffer in the current window or split
" horizontally
command! -nargs=0 Scratch call s:OpenScratchBuffer("")

" Command to open the scratch buffer in the current window a vertical split
" window
command! -nargs=0 VScratch call s:OpenScratchBuffer("vertical")

