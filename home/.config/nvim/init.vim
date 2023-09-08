function! SourceIfExists(f)
  if filereadable(expand(a:f))
     let file = expand(a:f)
     exec 'source ' . file
  endif
endfunction

call plug#begin()
call SourceIfExists("~/.config/nvim/plugins.vim")
" call SourceIfExists("~/company/plugins.vim")
call plug#end()
call SourceIfExists("~/.config/nvim/settings.vim")
call SourceIfExists("~/company/vimrc")

set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
set termencoding=utf-8

set t_Co=256 " Required for colorschemes
colorscheme brogrammer
