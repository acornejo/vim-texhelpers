" Vim Tex / LaTeX ftplugin to automatically insert environments.
" Maintainor:	Alex Cornejo <acornejo@gmail.com>
" Created:	Mon 23 Feb 2004 04:47:53 PM CST
" Last Changed:	Thu 08 Apr 2004 04:07:24 PM CDT
" Version:	1.0
"
" Description:
"   By default pressing "^g" in insert mode when the cursor is at the end of a
"   environment it will automatically generate a "\begin{environment}"
"   "\end{enviroment}".
"   It will leave the cursor at the end of the "\begin{environment}" (in
"   insert mode), so that the user can enter arguments [if any].
"
" provide load control
if exists('b:loaded_tex_insertenv')
    finish
endif
let b:loaded_tex_insertenv = 1

if !hasmapto("TexInsertEnv()", "ni")
    inoremap <buffer> <silent>	<C-g> <Esc>:call TexInsertEnv()<CR>
endif

" Only define the function if it has not been defined before.
if !exists('*TexInsertEnv()')
    " Function to automatically insert environments
    function TexInsertEnv()
	let line = getline('.')
	let linestart = strpart( line, 0, col('.'))

	let env = matchstr( linestart, '\v%(\s*)@<=[a-zA-Z0-9*]+$')
    let spaces = strpart( line, 0, col('.')-strlen(env))
	if env != ''
        call setline('.', spaces."\\begin{".env."}")
        call append('.', spaces."\\end{".env."}")
	    startinsert!
	else
	    " Not a begin tag. Resume insert mode as if nothing had happened
	    if col('.') < strlen(line)
		normal! l
		startinsert
	    else
		startinsert!
	    endif
	endif
    endfunction
endif
