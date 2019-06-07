function! readonly#after() abort
    let &l:modifiable = !&readonly
endfunction
