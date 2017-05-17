call plug#begin('~/.vim/plugged')
" Plug 'Valloric/YouCompleteMe'                   " Autocomplete magic!
Plug 'Shougo/neocomplete.vim'                     " Autocomplete magic!
Plug 'Shougo/unite.vim'                           " better fuzzy finder, ish
Plug 'Shougo/denite.nvim'                         " better fuzzy finder, ish
Plug 'Shougo/vimproc.vim', { 'do' : 'make' }
Plug 'vim-airline/vim-airline', has('nvim') ? {} : {'on': []} " replaced by powerline because I use tmux
Plug 'vim-airline/vim-airline-themes', has('nvim') ? {} : {'on': []} " replaced by powerline because I use tmux
Plug 'airblade/vim-gitgutter'                     " Provides branch changes in the gutter
Plug 'ctrlpvim/ctrlp.vim'                         " quick file search in base directory
Plug 'elzr/vim-json'                              " makes jsons more readable Plug 'fatih/vim-go'                               " makes Go work
Plug 'gmarik/Vundle.vim'                          " make Vundle manage updating Vundle
Plug 'godlygeek/tabular'                          " allows aligning columns of text
Plug 'kchmck/vim-coffee-script'                   " makes coffeescript work
Plug 'keith/tmux.vim'                             " simplifies some tmux/vim interactions
Plug 'mileszs/ack.vim'                            " code search in Vim using ack. Required for Ag
Plug 'rking/ag.vim'                               " Uses Ack, but faster
Plug 'mtscout6/vim-cjsx'                          " makes cjsx files work
Plug 'nathanaelkane/vim-indent-guides'            " highlights indentation levels
Plug 'scrooloose/nerdtree'                        " directory tree file navigation
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'    " add custom icons and colors to NERDTree
" Plug 'scrooloose/syntastic'                      " makes syntax highlighting better
Plug 'neomake/neomake'                            " using neomake instead
Plug 'rizzatti/dash.vim'
Plug 'jaawerth/neomake-local-eslint-first'        " vimscript to use local eslint if it exists
Plug 'sjl/gundo.vim'                              " browse the undo tree
Plug 'tpope/vim-commentary'                       " gcc/gc to comment a line/lines
Plug 'tpope/vim-abolish'                          " makes S a more powerful s
Plug 'tpope/vim-repeat'                           " allows using `.` for repeating Tim Pope's things
Plug 'tpope/vim-speeddating'                      " date and time autoincrementer with <C-A>
Plug 'tpope/vim-surround'                         " surround with brackets, braces, or anything
Plug 'tpope/vim-unimpaired'                       " [<command> and ]<command> commands

" Filetypes
Plug 'wavded/vim-stylus'                          " syntax for Stylus
Plug 'pangloss/vim-javascript'                    " adds ES6 highlighting, alongside vim-jsx
Plug 'mxw/vim-jsx'                                " jsx highlighting
Plug 'digitaltoad/vim-pug'                        " Jade/Pug syntax highlighting
Plug 'zah/nim.vim'                                " nim syntax
Plug 'derekwyatt/vim-sbt'                         " .sbt (don't ask) syntax
Plug 'derekwyatt/vim-scala'                       " scala syntax
Plug 'elixir-lang/vim-elixir'                     " elixir syntax
Plug 'slashmili/alchemist.vim'                    " elixir autocomplete
Plug 'avdgaag/vim-phoenix'                        " Phoenix additions
Plug 'elmcast/elm-vim'                            " Elm
Plug 'alx741/vim-hindent'                         " Indent haskell code if hindent is installed
Plug 'vim-scripts/SQLUtilities'                   " hate u hate u hate u
Plug 'vim-scripts/Align'                          " needed for SQLFormatter
" the tpope god solves clojure
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-salve'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-classpath'
Plug 'guns/vim-clojure-static'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

"                                                 " other
Plug 'wesQ3/vim-windowswap'                       " swap panes w/ \ww
Plug 'tpope/vim-fugitive'                         " Git happiness
Plug 'easymotion/vim-easymotion'                  " Makes f and t and w nicer
Plug 'junegunn/rainbow_parentheses.vim'           " Paren matching
Plug 'junegunn/vim-easy-align'                    " better? tabular
Plug 'christoomey/vim-tmux-navigator'             " C-[hjkl] pane/tmux split navigation
                                                    " Colorschemes
Plug 'altercation/vim-colors-solarized'           " colorscheme -- solarized
Plug 'aliou/moriarty.vim'                         " colorscheme -- moriarty
Plug 'tomsik68/vim-crystallite'                   " colorscheme -- crystallite
Plug 'dracula/Vim'                                " colorscheme -- dracula
Plug 'marciomazza/vim-brogrammer-theme'                                " colorscheme -- brogrammer

" Plug 'ryanoasis/vim-devicons'                     " ICONS!
call plug#end()                         " required

" Turn on colors
syntax on
filetype plugin indent on
syntax enable

" " YouCompleteMe ycm
" nnoremap <leader>jd :YcmCompleter GoTo<CR>
" let g:ycm_autoclose_preview_window_after_insertion=1
" set shortmess+=c

" Neocomplete
let g:neocomplete#enable_at_startup = 1
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ neocomplete#start_manual_complete()
function! s:check_back_space() "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" Unite/Denite
" call unite#filters#matcher_default#use(['matcher_fuzzy'])
" noremap <leader>/ :<C-u>Denite line<CR>

" call unite#custom#profile('default', 'context', {
" \   'start_insert': 1,
" \   'winheight': 10,
" \   'direction': 'botright',
" \ })
" call denite#custom#profile('default', 'context', {
" \   'start_insert': 1,
" \   'winheight': 10,
" \   'direction': 'botright',
" \ })
" call denite#sources#rec#define()
" call denite#custom#source('file_rec/async,file_mru,file,buffer,grep', 'ignore_pattern', g:unite_source_rec_ignore_pattern . '\|node_modules\|tmp')

" Nim
fun! JumpToDef()
  if exists("*GotoDefinition_" . &filetype)
    call GotoDefinition_{&filetype}()
  else
    exe "norm! \<C-]>"
  endif
endf

" Jump to tag
nnoremap <M-g> :call JumpToDef()<cr>
inoremap <M-g> <esc>:call JumpToDef()<cr>i


" Use Ag for ack:
let g:ackprg = 'ag --nogroup --nocolor --column'

" Powerline
" NOTE:
" WARNING: this requires a lot of outside setup
" The devs have a very thorough wiki
if !has('nvim')
  let g:powerline_pycmd='py3'
  set guifont=Droid\ Sans\ Mono\ for\ Powerline:h12

  python3 from powerline.vim import setup as powerline_setup
  python3 powerline_setup()
  python3 del powerline_setup

  set rtp+=/usr/local/lib/python3.6/site-packages/powerline/bindings/vim

  let g:Powerline_symbols='fancy'
  set encoding=utf-8
  set fillchars+=stl:\ ,stlnc:\
  set termencoding=utf-8

  let g:airline_disabled = 1
else
" Airline
" NOTE: Airline works better if you aren't using tmux/powerline's
" prompt/anything like that. Again, refer to docs
  let g:airline_theme = 'powerlineish'
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1
endif

" ctrlp
set runtimepath^=~/.vim/bundle/ctrlp.vim
nnoremap <silent> <c-p> :ClearAllCtrlPCaches<cr>\|:CtrlP<cr>
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|\.git\|Godeps/_workspace\|target\|\.jar'
let g:ctrlp_working_path_mode = ''
let g:ctrlp_match_window = 'results:100'
let g:ctrlp_arg_map = 1 "Allows <C-o> to accept one more argument
let g:ctrlp_abbrev = {
      \ 'gmode': 't',
      \ 'abbrevs': [
      \ {
      \ 'pattern': '\(^@.\+\|\\\@<!:.\+\)\@<! ',
      \ 'expanded': '/',
      \ 'mode': 'pfrz',
      \ },
      \ ]
      \ }

" NERDTree
nnoremap <leader>ne :NERDTreeToggle<CR>
nnoremap <leader>no :NERDTreeFocus<CR>
" First two lines enable NERDTree on startup
augroup nerdtree
  au!
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTreeToggle | endif
augroup END
" Icons, devicons
" let g:NERDTreeSyntaxDisableDefaultExtensions = 1
" let g:NERDTreeFileExtensionHighlightFullName = 1
" let g:NERDTreeExactMatchHighlightFullName = 1
" let g:NERDTreePatthernMatchHighlightFullName = 1
" let g:NERDTreeHighlightFolders = 1
" let g:NERDTreeHighlightFoldersFullName = 1
" let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" let g:DevIconsEnableFolderExtensionPatternMatching = 1
" let g:DevIconsEnableFoldersOpenClose = 1


" Vim-go
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

" Gundo
nnoremap <leader>gu :GundoToggle<CR>

" Ag
nnoremap <leader>ag :Ag<Space>

" Sexpr + Clojure
let g:sexp_enable_insert_mode_mappings=0
nnoremap <leader><space>e :%Eval<CR>
nnoremap <leader><space>= :Eval<CR>

" Neomake
augroup neomake
  au!
  autocmd! BufWritePost * Neomake
augroup END
let g:neomake_warning_sign = {
      \ 'text': '>>',
      \ 'texthl': 'Statement',
      \ }
let g:neomake_error_sign = {
      \ 'text': '>>',
      \ 'texthl': 'Error',
      \ }
let g:neomake_elixir_enabled_makers = ['mix', 'mycredo']
function! NeomakeCredoErrorType(entry)
    if a:entry.type ==# 'F'      " Refactoring opportunities
        let type = 'W'
    elseif a:entry.type ==# 'D'  " Software design suggestions
        let type = 'W'
    elseif a:entry.type ==# 'W'  " Warnings
        let type = 'W'
    elseif a:entry.type ==# 'R'  " Readability suggestions
        let type = 'W'
    elseif a:entry.type ==# 'C'  " Convention violation
        let type = 'W'
    else
        let type = 'M'           " Everything else is a message
    endif
    let a:entry.type = type
endfunction
let g:neomake_elixir_mycredo_maker = {
      \ 'exe': 'mix',
      \ 'args': ['credo', 'list', '%:p', '--format=oneline'],
      \ 'errorformat': '[%t] %. %f:%l:%c %m,[%t] %. %f:%l %m',
      \ 'postprocess': function('NeomakeCredoErrorType')
      \ }

" let g:neomake_elixir_enabled_makers = ['mix', 'credo']

" Syntastic
" let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_scala_checkers = ['fsc', 'scalac', 'scalastyle']
" let g:syntastic_elixir_checkers = ['mix', 'credo', 'dogma']

" Tabular
nnoremap <leader>t  :Tabular /
vnoremap <leader>t  :Tabular /

let g:elm_jump_to_error = 0
let g:elm_make_output_file = "elm.js"
let g:elm_make_show_warnings = 1
let g:elm_syntastic_show_warnings = 1
let g:elm_browser_command = ""
let g:elm_detailed_complete = 1
let g:elm_format_autosave = 1
let g:elm_format_fail_silently = 1
let g:elm_setup_keybindings = 1

call neocomplete#util#set_default_dictionary(
  \ 'g:neocomplete#sources#omni#input_patterns',
  \ 'elm',
  \ '\.')

" Window swap
" let g:windowswap_map_keys = 0
" nnoremap <silent> <leader>yw :call WindowSwap#MarkWindowSwap()<CR>
" nnoremap <silent> <leader>pw :call WindowSwap#DoWindowSwap()<CR>
" nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>

" Filetype stuff
" SQUUtilities SQLFormatter
let g:sqlutil_align_where = 0
let g:sqlutil_align_comma = 1
let g:sqlutil_load_default_maps = 0
vmap <leader>sf   <Plug>SQLUFormatter<CR>
nmap <leader>scl  <Plug>SQLUCreateColumnList<CR>
nmap <leader>scd  <Plug>SQLUGetColumnDef<CR>
nmap <leader>scdt <Plug>SQLUGetColumnDataType<CR>
nmap <leader>scp  <Plug>SQLUCreateProcedure<CR>

" Rainbow parens
augroup rainbow_parens
  autocmd!
  autocmd FileType *[^eelixir] RainbowParentheses
  autocmd VimEnter *[^.html.eex] RainbowParentheses
  autocmd Syntax clojure RainbowParentheses
  autocmd BufEnter *.html.eex RainbowParentheses!
augroup END
let g:rainbow#max_level = 16
let g:rainbow#pairs = [['(',')'],['[',']'],['{','}']]

" vim-easy-align Easy Align
vmap gi <Plug>(LiveEasyAlign)
nmap gi <Plug>(LiveEasyAlign)
nmap ga <Plug>(EasyAlign)
vmap ga <Plug>(EasyAlign) 

" Search for word
nnoremap <leader>sw /\<\><left><left>

" edit file in the current buffer's folder
nnoremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
" read from current folder
nnoremap <Leader>r :r <C-R>=expand("%:p:h") . "/" <CR>
" copy into current folder
nnoremap <Leader>w :w <C-R>=expand("%:p:h") . "/" <CR>

" begin the line with a console.log
nnoremap <Leader>cl mt^iconsole.log( <ESC>A )<ESC>`t14l
inoremap jkcl <ESC>mt^iconsole.log( <ESC>A )<ESC>`t14li
nnoremap <Leader>f mk^iecho <ESC>`t5l

" I gave in
command! W w
command! Wq wq
command! Q q
command! Wqa wqa
inoremap jk <ESC>
inoremap kj <ESC>

" user autocmdgroup
augroup local
  autocmd!
  autocmd VimLeave * execute 'mksession! ~/.session.vim'
  " Recognize .coffee files
  autocmd BufNewFile,BufRead *.coffee set filetype=coffee
augroup END

set clipboard^=unnamed,unnamedplus

set diffopt=filler,vertical

" Make tabbing intuitive
set autoindent
set expandtab
" Tab sizes
set tabstop=4
set shiftwidth=2
set softtabstop=2
set backspace=2
" Highlight current line
set cursorline
set colorcolumn=100


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

" Sets the mouse for all modes...
set mouse+=a
" ups redraw speed, means better scrolling
set ttyfast
if !has('nvim')
  set ttymouse=sgr
endif

" These two make smart case searching a thing
set ignorecase
set smartcase   
" Search as you type
set incsearch
" Highlight all matches
set hlsearch
" clear searches with <leader>=
nnoremap <leader>= :nohlsearch <bar> :redraw! <CR>

" reindent code:
nnoremap <leader>; mcgg=G`c
" Tmux style zoom with <leader>z, q/wq to return
nnoremap <leader>z :tabnew % <CR>

" Allows folding
set foldenable
set foldmethod=manual
set foldlevelstart=10

augroup filetype_json
  au!
  au FileType json setlocal foldmethod=syntax
  au FileType json setlocal foldlevelstart=4
augroup END

set foldnestmax=10

" For GoFmt
let g:go_fmt_fail_silently = 1

" Save folds automagically
augroup myFoldGroup
  autocmd!
  autocmd BufWinLeave *.* mkview
  autocmd BufWinEnter *.* silent! loadview 
augroup END

" automatically source .vimrc on changes:
augroup myvimrc
  au!
  au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
" source tmux.conf on changes
augroup tmuxconf
  au!
  au BufWritePost ~/.tmux.conf :!tmux source ~/.tmux.conf
augroup END
" updates unchanged files when waiting around
set autoread
augroup updatefiles
  au!
  au CursorHold,CursorHoldI * silent! checktime
augroup END

" makes vnew and new behave normally
set splitright
set splitbelow

" open useful files for editing
" NOTE: not really sure why, but this isn't clickable. Might be a personal
" issue.
nnoremap <leader>virc :botright vnew ~/.vimrc<CR>
nnoremap <leader>mux :botright vnew ~/.tmux.conf<CR>
nnoremap <leader>brc  :botright vnew ~/.bashrc<CR>
nnoremap <leader>pro :botright vnew ~/.bash_profile<CR>
nnoremap <leader>llll :botright vnew ~/.lein/profiles.clj<CR>

" Allows for undoing in ~/.vim/undos.
" NOTE: you need to make this directory
set undofile
set undodir=~/.vim/undos
set tags=./tags,tags,../tags

" Close quickfix if it's the only thing left:
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

""" Colorscheme setting
" set termguicolors
set t_Co=256
" colorscheme dracula

colorscheme brogrammer

" Solarized
" set background=dark
" let g:solarized_termcolors=256
" colorscheme solarized

" Moriarty
" colorscheme moriarty

" Crystallite
" colorscheme crystallite

" Lucario
" colorscheme lucario

" make [w]ords (not [W]ords) treat `_` as a word boundary
" set iskeyword-=_
