function! s:Test()
python << EOF
import vim
import commands
cur_buf = vim.current.buffer
print("cur_buf {}".format(cur_buf))
print "Lines: {0}".format(len(cur_buf))
print "Contents: {0}".format(cur_buf[-1])

print("cur_line {}".format(vim.current.line ))
print( vim.current.buffer )
print( vim.current.window )
print( vim.current.tabpage )
print( vim.current.range )

s, msg = commands.getstatusoutput('ls')
print(msg)



EOF
endfunction

" command! -nargs=0 HelloWorld call HelloWorld()
" command! -nargs=0 Hpy exec('py hello("ls")')
" command! -nargs=0 Test call Test()
" command! -nargs=0 Gv call Get_visual_selection()
" command! -nargs=0 GV call GetVisualSelection()
" call s:Test()
