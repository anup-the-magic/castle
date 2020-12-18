" makes vnew and new behave normally
set splitright
set splitbelow

" Tabbing
" Make tabbing intuitive
set expandtab
" Tab sizes
set tabstop=4
set shiftwidth=2
set softtabstop=2

" utility
inoremap jk <ESC>

command! W w
command! Wq wq
command! Wqa wqa
command! Q q

" Allow mouse
set mouse+=a

" Clipboard goes into paste
set clipboard^=unnamed,unnamedplus

" Line numbers
set number

" Always show tab bar
set showtabline=2
set cursorline

" Highlights matching brace
set showmatch

" Makes diffs look nicer
set diffopt=filler,vertical

" convenience files for editing configs
nnoremap <leader>virc :botright vnew ~/.config/nvim/init.vim<CR>
nnoremap <leader>mux :botright vnew ~/.tmux.conf<CR>
nnoremap <leader>zsh  :botright vnew ~/.oh-my-zsh/custom<CR>
nnoremap <leader>brc  :botright vnew ~/.bashrc<CR>
nnoremap <leader>pro :botright vnew ~/.bash_profile<CR>

" Convenience for dealing with similar folders
" edit file in the current buffer's folder
nnoremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
" read from current folder
nnoremap <Leader>r :r <C-R>=expand("%:p:h") . "/" <CR>
" copy into current folder
nnoremap <Leader>w :w <C-R>=expand("%:p:h") . "/" <CR>

" reindent the entire file
nnoremap <leader>; mcgg=G`c

" Fix searching
set ignorecase
set smartcase
" Highlight all matches
nnoremap <leader>8 :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
" clear searches with <leader>=
nnoremap <leader>= :nohlsearch <bar> :redraw! <CR>

" Tmux style zoom with <leader>z, q/wq to return
nnoremap <leader>z :tabnew % <CR>

" autocommands
augroup local
  autocmd!
  au BufWritePost ~/.vimrc,~/.vim/config/*.vim so $MYVIMRC " source vimrc on changes
  au BufWritePost ~/.config/nvim/*.vim,~/.config/nvim/plugins/*.vim so $MYVIMRC " source vimrc on changes

  " source .tmux.conf on changes
  au BufWritePost ~/.tmux.conf silent! :!tmux source ~/.tmux.conf

  au CursorHold,CursorHoldI * silent! checktime " update files when they're just sitting around
  au BufWritePre * %s/\s\+$//e " Trim trailing spaces
augroup END

augroup filetype_json
  au!
  au FileType json setlocal foldmethod=syntax
  au FileType json setlocal foldlevelstart=4
augroup END

augroup filetype_markdown
  au!
  au FileType markdown setlocal wrap
  au FileType markdown setlocal linebreak
  au FileType markdown setlocal nolist
augroup END

function! SequenceFormatter()
  execute 'g/^participant/m0'
  execute 'g/^participant/m0'
  execute '0,?participant?EasyAlign/\bas\b/'

  execute 'g/^[tT]itle/m0'

  execute '?participant?,$EasyAlign/[/'
endfunction


augroup filetype_sequence
  au!
  au BufWritePre *.sequence,*.seq silent! call SequenceFormatter()
augroup end

" Save folds automagically
augroup myFoldGroup
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent! loadview
augroup END

" Update time before we get CursorHold, etc
let g:go_auto_type_info=1
set updatetime=800
