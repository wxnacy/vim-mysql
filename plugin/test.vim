function! HelloWorld()
    echo "hello world"
endfunction

python << EOF
import os
def helloworld(sql):
    print('hello')
EOF

function! Test()
python << EOF
import vim
cur_buf = vim.current.buffer
print("cur_buf {}".format(cur_buf))
print "Lines: {0}".format(len(cur_buf))
print "Contents: {0}".format(cur_buf[-1])

print( vim.current.line )
print( vim.current.buffer )
print( vim.current.window )
print( vim.current.tabpage )
print( vim.current.range )

EOF
endfunction

" function! GetVisualSelection()
    " " Why is this not a built-in Vim script function?!
    " let [line_start, column_start] = getpos("'<")[1:2]
    " let [line_end, column_end] = getpos("'>")[1:2]
    " echo line_start
    " echo column_start
    " echo line_end
    " echo column_end
    " let lines = getline(line_start, line_end)
    " if len(lines) == 0
        " return ''
    " endif
    " let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    " let lines[0] = lines[0][column_start - 1:]
    " echo join(lines, "\n")
    " return join(lines, "\n")
" endfunction

function! Bar() abort
    bar
endfunction

function! Foo()
    try
        call Bar()
    catch /.*/
        let bt = lh#exception#callstack(v:throwpoint)
        let data = map(copy(bt), '{"filename": v:val.script, "text": "called from here", "lnum": v:val.pos}')
        let data[0].text = v:exception
        call setqflist(data)
    endtry
endfunction

" command! -nargs=0 HelloWorld call HelloWorld()
" command! -nargs=0 Hpy exec('py hello("ls")')
" command! -nargs=0 Test call Test()
" command! -nargs=0 Gv call Get_visual_selection()
" command! -nargs=0 GV call GetVisualSelection()

