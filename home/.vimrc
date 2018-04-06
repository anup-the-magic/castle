function! BuildYCM(info)
  if a:info.status ==# 'installed' || a:info.force
    !./install.py --cs-completer --go-completer --js-completer --java-completer
  endif
endfunction

call plug#begin('~/.vim/plugged')
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') } " Autocomplete magic!
Plug 'junegunn/vim-easy-align'                                " better? tabular
Plug 'sbdchd/neoformat'                                       " autoformatter
Plug 'wesQ3/vim-windowswap'                                   " swap panes w/ \ww
Plug 'w0rp/ale'                                               " like syntastic / neomake

Plug 'christoomey/vim-tmux-navigator' " C-[hjkl] pane/tmux split navigation
Plug 'keith/tmux.vim'                 " simplifies some tmux/vim interactions

Plug 'tpope/vim-commentary'  " gcc/gc to comment a line/lines
Plug 'tpope/vim-abolish'     " makes S a more powerful s
Plug 'tpope/vim-repeat'      " allows using `.` for repeating Tim Pope's things
Plug 'tpope/vim-speeddating' " date and time autoincrementer with <C-A>
Plug 'tpope/vim-surround'    " surround with brackets, braces, or anything
Plug 'tpope/vim-unimpaired'  " [<command> and ]<command> commands
Plug 'tpope/vim-fugitive'    " Git happiness
Plug 'tpope/vim-dispatch'    " Async fire off terminal commands!
" Plug 'tpope/vim-fireplace' " Clojure repl
" Plug 'tpope/vim-classpath' " Fixes find and gf in Java
" Plug 'tpope/vim-salve'     " makes vim-fireplace better

Plug 'airblade/vim-gitgutter' " Provides branch changes in the gutter

" =============== Syntax ===============
Plug 'elzr/vim-json'          " makes jsons more readable
""
Plug 'elmcast/elm-vim'        " Elm
""
Plug 'itchyny/vim-haskell-indent' " Pre-indent code so hindent doesn't struggle so much
""
Plug 'pangloss/vim-javascript'    " adds ES6 highlighting, alongside vim-jsx
Plug 'leafgarland/typescript-vim' " typescript ft
Plug 'mxw/vim-jsx'                " jsx highlighting
""
Plug 'derekwyatt/vim-scala' " scala syntax
""
Plug 'elixir-lang/vim-elixir'    " elixir syntax
Plug 'avdgaag/vim-phoenix'       " Phoenix additions
" Plug 'slashmili/alchemist.vim' " elixir autocomplete (poorly done)
""
Plug 'wavded/vim-stylus'        " syntax for Stylus
Plug 'kchmck/vim-coffee-script' " Coffeescript
Plug 'digitaltoad/vim-pug'      " Jade/pug format
""
Plug 'fatih/vim-go' " Golang support

Plug 'ctrlpvim/ctrlp.vim'  " quick file search in base directory
Plug 'scrooloose/nerdtree' " directory tree file navigation
Plug 'mileszs/ack.vim'     " code search in Vim using ack. Required for Ag
Plug 'rking/ag.vim'        " Uses Ack, but faster

Plug 'altercation/vim-colors-solarized' " colorscheme -- solarized
Plug 'aliou/moriarty.vim'               " colorscheme -- moriarty
Plug 'tomsik68/vim-crystallite'         " colorscheme -- crystallite
Plug 'dracula/Vim'                      " colorscheme -- dracula
Plug 'marciomazza/vim-brogrammer-theme' " colorscheme -- brogrammer
call plug#end()

" ====================== VIM ======================
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
inoremap kj <ESC>
command! W w
command! Wq wq
command! Wqa wqa
command! Q q

" Allow mouse
set mouse+=a
" make mouse smoother, allow mouse in tmux
set ttymouse=sgr
" Clipboard goes into paste
set clipboard^=unnamed,unnamedplus

" Line numbers
set number
set ruler

" Always show command bar
set laststatus=2
set showtabline=2
" Tab autocomplete in command bar will show options in a line
set wildmenu
" Highlights matching brace
set showmatch

" Makes diffs look nicer
set diffopt=filler,vertical

" convenience files for editing configs
nnoremap <leader>virc :botright vnew ~/.vimrc<CR>
nnoremap <leader>mux :botright vnew ~/.tmux.conf<CR>
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
" Search as you type
set incsearch
" Highlight all matches
set hlsearch
nnoremap <leader>8 :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
" clear searches with <leader>=
nnoremap <leader>= :nohlsearch <bar> :redraw! <CR>

" Tmux style zoom with <leader>z, q/wq to return
nnoremap <leader>z :tabnew % <CR>

" autocommands
augroup local
  autocmd!
  au BufWritePost ~/.vimrc so $MYVIMRC " source vimrc on changes

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

" augroup filetype_golang
"   au!
"   au FileType go nmap <leader>i <Plug>(go-info)
" augroup END
let g:go_auto_type_info=1
set updatetime=800

" Save folds automagically
augroup myFoldGroup
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent! loadview
augroup END
" ====================== PLUGINS ======================
"" Neoformat
" let g:neoformat_only_msg_on_error = 1
" augroup neoformatGroup
"   autocmd!
"   autocmd BufWritePre,InsertLeave *.js Neoformat
"   autocmd BufWritePre,InsertLeave *.jsx Neoformat
"   autocmd BufWritePre,InsertLeave *.ts silent! Neoformat
"   autocmd BufWritePre,InsertLeave *.json silent! Neoformat
" augroup END

" Ale
"" To turn off always linting:
" let g:ale_lint_on_text_changed = 'never'

let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['json'] = ['prettier']
let g:ale_fixers['typescript'] = ['prettier']
let g:ale_fixers['elm'] = ['format']
let g:ale_fixers['scala'] = ['scalafmt']
let g:ale_fixers['haskell'] = ['hfmt']

let g:ale_linters = {}
" Remove stack-ghc, ghc-mod since they don't maintain cabal relative pathing
let g:ale_linters['haskell'] =
      \ [ 'hlint'
      \ , 'hdevtools'
      \ , 'hfmt'
      \ , 'stack-ghc'
      \ , 'stack-build'
      \ ]
let g:ale_linters['elixir'] = ['credo']
let g:ale_linters['go'] = ['gofmt', 'goimports', 'go vet', 'gotype', 'go build', 'gosimple']

let g:ale_javascript_prettier_use_local_config = 1
let g:ale_typescript_prettier_use_local_config = 1
let g:ale_json_prettier_use_local_config = 1

let g:ale_fix_on_save = 1
nnoremap <leader>d :ALEDetail<CR>

" augroup aleformatting
"   autocmd!
"   autocmd BufWritePre,InsertLeave *.js silent! ALEFix
"   autocmd BufWritePre,InsertLeave *.ts silent! ALEFix
"   autocmd BufWritePre,InsertLeave *.json silent! ALEFix
"   autocmd BufWritePre,InsertLeave *.elm silent! ALEFix
" augroup END

"" YCM
let g:ycm_autoclose_preview_window_after_completion = 1

let g:ycm_semantic_triggers = {}
let g:ycm_semantic_triggers['elm'] = ['.']

" Powerline
" NOTE: requires outside setup
let g:powerline_pycmd='py3'
set guifont=Droid\ Sans\ Mono\ for\ Powerline:h12

python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

set runtimepath+=/usr/local/lib/python3.6/site-packages/powerline/bindings/vim

let g:Powerline_symbols='fancy'
set encoding=utf-8
set fillchars+=stl:\ ,stlnc:\
set termencoding=utf-8

" Easy Align, vim-easy-align, Tabular, Tab
vmap gi <Plug>(LiveEasyAlign)
nmap gi <Plug>(LiveEasyAlign)
nmap ga <Plug>(EasyAlign)
vmap ga <Plug>(EasyAlign)

"" elm
let g:elm_jump_to_error = 0
let g:elm_make_output_file = 'elm.js'
let g:elm_make_show_warnings = 1
let g:elm_syntastic_show_warnings = 1
let g:elm_browser_command = ''
let g:elm_detailed_complete = 1
let g:elm_format_autosave = 1
let g:elm_format_fail_silently = 1
let g:elm_setup_keybindings = 1
"
" NERDTree
nnoremap <leader>ne :NERDTreeToggle<CR>
nnoremap <leader>no :NERDTreeFocus<CR>

" CtrlP, ctrl-p
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

" Ag
nnoremap <leader>ag :Ag<Space>

" colorschemes
set t_Co=256 " Required for colorschemes
colorscheme brogrammer
