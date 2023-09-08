" makes vnew and new behave normally
set splitright
set splitbelow

" Fix undofiles
set undofile
set undodir=~/.vim/undos

" Tabbing
" Make tabbing intuitive
set autoindent
set expandtab
" Tab sizes
set tabstop=4
set shiftwidth=2
set softtabstop=2
set backspace=2

" utility
inoremap jk <ESC>

command! W w
cmap w!! w !sudo tee > /dev/null %
command! Wq wq
command! Wqa wqa
command! Q q

" Allow mouse
set mouse+=a
" Clipboard goes into paste
set clipboard^=unnamed,unnamedplus
" let g:clipboard = {
"           \   'name': 'WslClipboard',
"           \   'copy': {
"           \      '+': 'clip.exe',
"           \      '*': 'clip.exe',
"           \    },
"           \   'paste': {
"           \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
"           \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
"           \   },
"           \   'cache_enabled': 0,
"           \ }


" Line numbers
set number
set ruler

" Always show command bar
set laststatus=2
set showtabline=2
set cursorline
" Tab autocomplete in command bar will show options in a line
set wildmenu
" Highlights matching brace
set showmatch

" Makes diffs look nicer
set diffopt=filler,vertical

" convenience files for editing configs
nnoremap <leader>virc :botright vnew $MYVIMRC<CR>
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
set wildignorecase
" Search as you type
set incsearch
" Highlight all matches
set hlsearch
nnoremap <leader>8 :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
" clear searches with <leader>=
nnoremap <leader>= :nohlsearch <bar> :redraw! <CR>
" don't scroll to the bottom of the screen
set scrolloff=10

" Tmux style zoom with <leader>z, q/wq to return
nnoremap <leader>z :tabnew % <CR>

" autocommands
augroup local
  autocmd!
  " source vimrc on changes
  au BufWritePost ~/.vimrc,~/.vim/config/*.vim,~/.company/.vimrc,~/company/vimrc so $MYVIMRC
  au BufWritePost ~/.config/nvim/*.vim,~/.config/nvim/plugins/*.vim so $MYVIMRC " source vimrc on changes

  " source .tmux.conf on changes
  au BufWritePost ~/.tmux.conf silent! :!tmux source ~/.tmux.conf

  au CursorHold,CursorHoldI * silent! checktime " update files when they're just sitting around
  au BufWritePre * %s/\s\+$//e " Trim trailing spaces
  au BufWinEnter * silent! :%foldopen!
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
  execute 'normal mt'
  execute '%s/\v\s+\[/ [/g'
  execute 'g/^participant/m0'
  execute 'g/^participant/m0'
  execute '0,?participant?EasyAlign/\bas\b/'

  execute 'g/^[tT]itle/m0'

  execute '0,?participant?EasyAlign/[/'
  execute '?participant?+1,$EasyAlign/[/'
  execute '%s/\s*]/ ]/'
  execute '%s/[\s*/[ /'
  execute '%s/\s*=\s*/=/g'
  execute 'normal `t'
endfunction


augroup filetype_sequence
  au!
  au BufWritePre *.sequence,*.seq silent! call SequenceFormatter()
augroup end

augroup filetype_textproto
  au!
  au BufWritePost *.textproto,*.pbtxt,*.textpb set foldmethod=syntax

  au FileType textpb setlocal commentstring=#\ %s
  au FileType textpb set iskeyword-=.
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
