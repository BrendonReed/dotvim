function! ExecuteSQL()
    let g:sqlquery = @q
    let g:sqltempfile = $HOME . '\vimfiles\vim.sql'

    if g:sqlquery == ""
        echo "The register q does not have query"
        return 0
    endif
    call writefile(split(g:sqlquery, "\n"), g:sqltempfile)

    if exists("g:my_run_buffer")
        " go to buffer
        set swb=usetab
        set nowrap
        exec ":rightbelow sbuf " . g:my_run_buffer
    else 
        bo new
        set buftype=nofile
        set nowrap
        let g:my_run_buffer = bufnr("%")
        let g:mydb = "tempdb"
        let g:mydbserver = "localhost"
    endif
    let mycommand = '%!sqlcmd -S' . g:mydbserver . ' -d' . g:mydb . ' -Y 30 -i ' . g:sqltempfile

    exec mycommand
endfunction
