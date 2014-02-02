vimscratch
==========

Is a bit more than a simple scratch buffer implementation for Vim. In addition to jotting down throw away notes it can be used to execute shell commands. It's as simple as typing the intended command in the scratch buffer and executing the :ExecShRangeToScratch command or <leader>e.

## Commands

- `:Scratch` Opens the scratch buffer in a horizontal split window.
- `:ScratchVertical` Opens the scratch buffer in a vertical split window.

Note: The above commands will replace the current buffer if it's unnamed and not modified. 

- `:ExecShToScratch` Provide a shell command to this command and the output of the shell command will be directed to the scratch buffer. Eg: `:ExecShToScratch ls -l`. File completion is enabled when using this command.
- `:ExecShRangeToScratch` This command enables to type a shell command in the scratch buffer and execute it using this command. When it's executed the current line is retreived from the buffer and executed. By default `<leader>e` is mapped to this command.
