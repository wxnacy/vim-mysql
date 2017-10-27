
vnoremap <leader>rs :<c-u>call mysql#RunSqlVisual('local')<cr>
vnoremap <leader>rsp :<c-u>call mysql#RunSqlVisual('prod')<cr>
nnoremap <leader>rs :call mysql#RunSqlLine('local')<cr>
nnoremap <leader>rsp :call mysql#RunSqlLine('prod')<cr>


