function! SourceIfExists(f)
  if filereadable(expand(a:f))
     let file = expand(a:f)
     exec 'source ' . file
  endif
endfunction

call SourceIfExists("~/.company/.vimrc")

function! BuildYCM(info)
  if a:info.status ==# 'installed' || a:info.force
    !./install.py --cs-completer --go-completer --js-completer --java-completer
  endif
endfunction

call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'                                 " better? tabular
Plug 'sbdchd/neoformat'                                        " autoformatter
Plug 'wesQ3/vim-windowswap'                                    " swap panes w/ \ww
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
Plug 'w0rp/ale'                                                " like syntastic / neomake

Plug 'christoomey/vim-tmux-navigator' " C-[hjkl] pane/tmux split navigation
Plug 'keith/tmux.vim'                 " simplifies some tmux/vim interactions

Plug 'PeterRincker/vim-argumentative' " allows navigating and modifying comma separated lists
Plug 'tpope/vim-commentary'           " gcc/gc to comment a line/lines
Plug 'tpope/vim-abolish'              " makes S a more powerful s
Plug 'tpope/vim-repeat'               " allows using `.` for repeating Tim Pope's things
Plug 'tpope/vim-speeddating'          " date and time autoincrementer with <C-A>
Plug 'tpope/vim-surround'             " surround with brackets, braces, or anything
Plug 'tpope/vim-unimpaired'           " [<command> and ]<command> commands
Plug 'tpope/vim-fugitive'             " Git happiness
Plug 'tpope/vim-dispatch'             " Async fire off terminal commands!
" Plug 'tpope/vim-fireplace'          " Clojure repl
" Plug 'tpope/vim-classpath'          " Fixes find and gf in Java
" Plug 'tpope/vim-salve'              " makes vim-fireplace better

Plug 'airblade/vim-gitgutter' " Provides branch changes in the gutter

" =============== Syntax ===============
Plug 'elzr/vim-json'          " makes jsons more readable
""
Plug 'ElmCast/elm-vim'        " Elm
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
""
Plug 'shime/vim-livedown' " Markdown support

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
set cursorline
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

function! GetTypescriptProject(buffer) abort
  let l:file = ale#path#FindNearestFile(a:buffer, 'tsconfig.json')
  return !empty(l:file) ? '--project ' . l:file : ''
endfunction

augroup filetype_typescript
  au!
  au FileType typescript nnoremap yt :YcmCompleter GetType <CR>
  au FileType typescript nnoremap yd :YcmCompleter GoToDefinition <CR>
  au FileType typescript let b:dispatch = 'ts-node ' . GetTypescriptProject('%') . ' --strict false %'
  au FileType typescript nnoremap <leader>go :w<bar>Dispatch<CR>
augroup END

" augroup filetype_golang
"   au!
"   au FileType go nmap <leader>i <Plug>(go-info)
" augroup END
" Update time before we get CursorHold, etc
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

" coc.nvim, CoC, language server
set hidden " Required for TextEdit (rename, effectively)

" These two fix watchers for certain backends. This is the
" `filename.ext~` files, so not too concerned
set nobackup
set nowritebackup

set cmdheight=2

" Really not certain what this is
set shortmess+=c

" Tab completes completions
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" ============= UNTESTED ===============

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" ============= END UNTESTED ===============

" Ale
"" To turn off always linting:
" let g:ale_lint_on_text_changed = 'never'

let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['json'] = ['prettier']
let g:ale_fixers['yaml'] = ['prettier']
let g:ale_fixers['typescript'] = ['prettier']
let g:ale_fixers['markdown'] = ['prettier']
let g:ale_fixers['elm'] = ['format']
let g:ale_fixers['scala'] = ['scalafmt']
let g:ale_fixers['sh'] = ['shfmt']
let g:ale_fixers['haskell'] = ['brittany']

let g:ale_linters = {}
" Remove stack-ghc, ghc-mod since they don't maintain cabal relative pathing
" note: we install hlint using stack install. Alas.
let g:ale_linters['haskell'] =
      \ [ 'hlint'
      \ , 'hdevtools'
      \ , 'hfmt'
      \ , 'stack-build'
      \ ]
     " \ , 'stack-ghc'
let g:ale_linters['elixir'] = ['credo']
let g:ale_linters['go'] = ['gofmt', 'goimports', 'go vet', 'gotype', 'go build', 'gosimple']

let g:ale_set_loc_list = 1
let g:ale_set_quickfix = 0
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
let g:elm_detailed_complete = 1
let g:elm_format_autosave = 1
let g:elm_format_fail_silently = 1
let g:elm_setup_keybindings = 1
"
" NERDTree
nnoremap <leader>ne :NERDTreeToggle<CR>
nnoremap <leader>no :NERDTreeFocus<CR>
nnoremap <leader>nf :NERDTreeFind<CR>

" CtrlP, ctrl-p
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

" Ag
nnoremap <leader>ag :Ag<Space>

" Livedown, markdown
let g:livedown_autorun = 1
" let g:livedown_open = 1
" let g:livedown_port = 1337
let g:livedown_browser = 'google chrome'

" colorschemes
set t_Co=256 " Required for colorschemes
colorscheme brogrammer
