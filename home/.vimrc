function! SourceIfExists(f)
  if filereadable(expand(a:f))
     let file = expand(a:f)
     exec 'source ' . file
  endif
endfunction

call SourceIfExists("~/.vim/config/plugins.vim")
call SourceIfExists("~/.vim/config/settings.vim")
call SourceIfExists("~/.company/.vimrc")


set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
set termencoding=utf-8

" colorschemes
set t_Co=256 " Required for colorschemes
colorscheme brogrammer
