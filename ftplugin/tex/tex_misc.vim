if filereadable(expand("%:p:h") . "/Makefile") || filereadable(expand("<afile>:p:h") . "/Makefile") 
    setlocal makeprg=make
else
    if filereadable(expand("%:p:h") . "/../Makefile") || filereadable(expand("<afile>:p:h") . "/../Makefile") 
        setlocal makeprg=make\ \-C\ \.\.
    else "make the pdf file, suppress uneeded output, halt on errors
        setlocal makeprg=pdflatex\ \-shell\-escape\ \-file\-line\-error\ \-interaction=nonstopmode\ %\\\|\ grep\ \-E\ '\\w+:[0-9]{1,4}:\\\ ' 
    endif
endif
" set make error format
setlocal efm:%f:%l\ %m
" add wrapping that is aware of delimiters
fun! TeX_par()
        if (getline(".") != "")
                let op_wrapscan = &wrapscan
                set nowrapscan
                let par_begin = '^$\|^\s*\\begin{\|^\s*\\\['
                let par_end = '^$\|^\s*\\end{\|^\s*\\\]'
                exe '?'.par_end.'?+'
                norm V
                exe '/'.par_begin.'/-'
                norm gq
                let &wrapscan = op_wrapscan
        endif
endfun

nnoremap <buffer> gw :call TeX_par()<CR> 
