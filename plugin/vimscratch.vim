"Simple emacs scratch buffer implementation for vim.

if exists('g:loaded_vimscratch')
    finish
endif

let s:save_cpo = &cpo

" Let the cpo option to default vim values :h set-option
set cpo&vim

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

    let window_num = bufwinnr(name)
    if window_num == -1
        if empty(bufname("%")) && !&modified
            exe 'edit ' . name
        else
            " KLUGY: Ideally control the positioning using vim positioning
            " modifiers eg: :h :vert
            exe a:split_modifier . ' split ' . name
        endif
        call s:MarkCurrentBufferAsScratch()
    else
        " Focus the open window
        exec window_num . " wincmd w"
    endif
endfunction

function! s:MarkCurrentBufferAsScratch()
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    setlocal tw=0
    setlocal colorcolumn=0
endfunction

function! s:ExecShellToScratch(...)
    Scratch
    exec 'r ! ' . join(a:000, ' ')
endfunction

function! s:ExecShellRangeToScratch(from, to)
    let cur_line = join(getline(a:from, a:to), ' ')
    Scratch
    exec 'r ! ' . cur_line
endfunction

" Command to edit the scratch buffer in the current window or split
" horizontally
command! -nargs=0 Scratch call s:OpenScratchBuffer("")

" Command to open the scratch buffer in the current window a vertical split
" window
command! -nargs=0 ScratchVertical call s:OpenScratchBuffer("vertical")

" Run a shell command and write it to the scratch buffer
command! -complete=file -nargs=* ExecShToScratch call s:ExecShellToScratch(<f-args>)

" Executes a visually selected text in the buffer
command! -range ExecShRangeToScratch call s:ExecShellRangeToScratch(<line1>, <line2>)

nmap <silent> <leader>e :ExecShRangeToScratch<cr>
