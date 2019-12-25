" Entry point for the plugin

let s:file_name = expand("%:t") 

function! CheckIfEmpty(name)
	if(filereadable(a:name))
		let l:data = readfile(a:name) 
		for d in data
			if(d == '')
				continue
			else
				return 1
			endif
		endfor
	endif	

	return 0
endfunction

function! TryHeaderInsertion() 
	if(CheckIfEmpty(s:file_name))
		return 
	endif
	let l:file_parts = split(s:file_name, "[.]")
	if(len(l:file_parts) > 1 && file_parts[len(l:file_parts)-1][0] == 'h')
		call append(0,"#ifndef " . toupper(l:file_parts[0]) . "_H_DEFINE")
		call append(1,"#define " . toupper(l:file_parts[0]) . "_H_DEFINE")
		call append(3,"#endif")
	endif
endfunction

call TryHeaderInsertion() 
