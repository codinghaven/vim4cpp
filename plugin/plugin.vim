" Entry point for the plugin

let s:file_name = expand("%:t") 

function! FileNotEmpty(name)
	if(!filereadable(a:name))
		return 0
	endif

	let l:data = readfile(a:name) 
	for d in data
		if(d == '')
			continue
		endif
		return 1
	endfor

	return 0
endfunction

function! TryHeaderInsertion() 
	if(FileNotEmpty(s:file_name))
		return 
	endif
	let l:file_parts = split(s:file_name, "[.]")
	if(len(l:file_parts) > 1 && file_parts[len(l:file_parts)-1][0] == 'h')
		call append(0,"#ifndef " . toupper(l:file_parts[0]) . "_H_DEFINE")
		call append(1,"#define " . toupper(l:file_parts[0]) . "_H_DEFINE")
		call append(3,"#endif")
	endif
endfunction

function! MakeMain()
	call setline('.', ["#include <iostream>", "","using namespace std;","","int main(int argc, char** argv) {", "", ""])
	execute "normal! 7Gi\<tab>return 0;"
	call append(line('$'), "}")
endfunction
	
function TryMainInsertion()
	if(FileNotEmpty(s:file_name))
		return
	endif
	if(tolower(s:file_name) == "main.cpp") 
		call MakeMain()
	endif
endfunction

call TryHeaderInsertion() 
call TryMainInsertion()
