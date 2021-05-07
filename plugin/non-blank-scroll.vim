" Vim global plugin for scrolling to non-blank characters

if exists("g:loaded_non_blank_scroll") || &cp
  finish
endif
let g:loaded_non_blank_scroll = 1

function! s:scroll(step)
    if a:step != 1 && a:step != -1
        echoerr "non-blanl-scroll: argument must be 1 or -1"
    endif

    let pos = getcurpos()
    let cur_lnum = pos[1]
    let cur_col = pos[2]

    let last_lnum = a:step > 0 ? getpos('$')[1] + 1 : 0
    let distance = 0

    let cur_lnum += a:step
    while cur_lnum != last_lnum
        let cur_char = getline(cur_lnum)[cur_col-1]
        if match(cur_char, '\S') == 0
            call setpos('.', [0, cur_lnum, cur_col, 0])
            return v:true
        endif
        let cur_lnum += a:step
    endwhile
    echoerr "non-blanl-scroll: No valid line found"
endfunction

nnoremap <silent> <Plug>non-blan-scroll-down  :<C-U>call <SID>scroll(1)<CR>
nnoremap <silent> <Plug>non-blan-scroll-up  :<C-U>call <SID>scroll(-1)<CR>

nmap <space>j  <Plug>non-blan-scroll-down
nmap <space>k  <Plug>non-blan-scroll-up

omap <space>j  <Plug>non-blan-scroll-down
omap <space>k  <Plug>non-blan-scroll-up
