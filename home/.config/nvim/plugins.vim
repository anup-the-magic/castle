let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
source ~/.config/nvim/plugins/vim-easy-align.vim " better? tabular
source ~/.config/nvim/plugins/ale.vim            " Autoformatter + linter
source ~/.config/nvim/plugins/coc.nvim.vim       " language servers!
source ~/.config/nvim/plugins/fzf.vim       " language servers!

Plug 'wesQ3/vim-windowswap'           " swap panes w/ \ww
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

Plug 'airblade/vim-gitgutter' " Provides branch changes in the gutter

Plug 'mileszs/ack.vim'                                        " code search in Vim using ack. Required for Ag
source ~/.config/nvim/plugins/vim-livedown.vim " Markdown live preview
source ~/.config/nvim/plugins/ctrlp.vim        " quick file search in base directory
source ~/.config/nvim/plugins/nerdtree.vim     " Filetree explorer
source ~/.config/nvim/plugins/ag.vim           " Like Ack but faster
" =============== Syntax ===============
Plug 'elzr/vim-json'                                     " makes jsons more readable
Plug 'bfrg/vim-jq'                                       " ultra-useful jq filetype plugin

source ~/.config/nvim/plugins/elm-vim.vim " Elm filetype + formatter
Plug 'itchyny/vim-haskell-indent'                        " Pre-indent code so hindent doesn't struggle so much
Plug 'pangloss/vim-javascript'                           " adds ES6 highlighting, alongside vim-jsx
Plug 'leafgarland/typescript-vim'                        " typescript ft
Plug 'mxw/vim-jsx'                                       " jsx highlighting
Plug 'derekwyatt/vim-scala'                              " scala syntax
Plug 'elixir-lang/vim-elixir'                            " elixir syntax
Plug 'avdgaag/vim-phoenix'                               " Phoenix additions
Plug 'wavded/vim-stylus'                                 " syntax for Stylus
Plug 'kchmck/vim-coffee-script'                          " Coffeescript
Plug 'digitaltoad/vim-pug'                               " Jade/pug format
Plug 'fatih/vim-go'                                      " Golang support
Plug 'xavierchow/vim-sequence-diagram'                   " Sequence Diagrams
" ================ Colors ================
Plug 'altercation/vim-colors-solarized' " colorscheme -- solarized
Plug 'aliou/moriarty.vim'               " colorscheme -- moriarty
Plug 'tomsik68/vim-crystallite'         " colorscheme -- crystallite
Plug 'dracula/Vim'                      " colorscheme -- dracula
Plug 'marciomazza/vim-brogrammer-theme' " colorscheme -- brogrammer
call plug#end()

"" Plug 'tpope/vim-fireplace'          " Clojure repl
"" Plug 'tpope/vim-classpath'          " Fixes find and gf in Java
"" Plug 'tpope/vim-salve'              " makes vim-fireplace better
"" Plug 'slashmili/alchemist.vim' " elixir autocomplete (poorly done)
