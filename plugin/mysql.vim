python << EOF
import os
import json
import vim
import commands
def run(env, sql):
    cur_buf = vim.current.buffer
    if 'prod' in str(cur_buf):
        env = 'prod'

    sql = sql.strip("'")
    sql = sql.replace('`', '\`')
    sql = sql.replace("'\''", "'")
    cmd = 'mysql_run {} "{}"'.format(env, sql)
    s, msg = commands.getstatusoutput(cmd)
    
    show_list = msg.split('\n')[15:-3]
    show_msg = '\n'.join(show_list)

    def _fmt(o):
        o = o.strip()
        item = dict(text=o)
        return item
    show_list = [_fmt(o) for o in show_list]
    vim.command('call setqflist({}, "r")'.format(json.dumps(show_list)))
    vim.command(':copen 35')
EOF

function! s:GetVisualSelection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    echo line_start
    echo column_start
    echo line_end
    echo column_end
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction


function! RunSql(env)
    let l:vm = visualmode()
    let b:db_name = g:mysql_local_db_name
    if a:env ==# 'prod'
        echo 'use prod'
        let b:db_name = g:mysql_prod_db_name
        echo 'use ' . b:db_name
    endif
    if l:vm ==# 'V' || l:vm ==# 'v'
        normal! `<v`>y
        let b:sql = shellescape(@")
        exec('py run(' . b:sql . ')')
    else
        " let b:sql = shellescape(getline(line('.')))
        let b:sql = getline(line('.'))
        exec('py run("'. a:env . '","' . b:db_name .
            \'","' . getline(line('.')) . '")')
    endif
endfunction

function! RunSqlVisual(env)
    " echo s:GetVisualSelection()
    let l:vm = visualmode()
    normal! `<v`>y
    let b:sql = @@
    let b:sql = shellescape(b:sql)
    silent exec('py run("'. a:env . '","' . b:sql . '")')
endfunction

function! RunSqlLine(env)
    let b:sql = getline(line('.'))
    exec('py run("'. a:env . '","' . b:sql . '")')
endfunction


" command! -nargs=0 Rs call RunSql()

" vnoremap <buffer> <leader>r <delete><delete><delete><delete><delete>:call RunVisual()<cr>
" autocmd FileType sql nnoremap <buffer> <leader>r :call RunLine()<cr>

vnoremap <leader>rs :<c-u>call RunSqlVisual('local')<cr>
vnoremap <leader>rsp :<c-u>call RunSqlVisual('prod')<cr>
nnoremap <leader>rs :call RunSqlLine('local')<cr>
nnoremap <leader>rsp :call RunSqlLine('prod')<cr>


