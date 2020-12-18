Plug 'w0rp/ale'

" To turn off ale always linting
" let g:ale_lint_on_text_changed = 'never'
let g:ale_fixers = {}
let g:ale_fixers['elm'] = ['format']
let g:ale_fixers['haskell'] = ['ormolu']
let g:ale_fixers['javascript'] = ['prettier']
let g:ale_fixers['json'] = ['prettier']
let g:ale_fixers['markdown'] = ['prettier']
let g:ale_fixers['scala'] = ['scalafmt']
let g:ale_fixers['sh'] = ['shfmt']
let g:ale_fixers['typescript'] = ['prettier']
let g:ale_fixers['yaml'] = ['prettier']

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
let g:ale_linters['go'] =
      \ ['gofmt'
      \ , 'goimports'
      \ , 'go vet'
      \ , 'gotype'
      \ , 'go build'
      \ , 'gosimple'
      \ ]
let g:ale_linters['java'] =
      \ [ 'checkstyle'
      \ , 'eclipselsp'
      \ , 'javalsp'
      \ , 'pmd'
      \ ]
      " \ , 'javac'

let g:ale_set_loc_list = 1
let g:ale_set_quickfix = 0
let g:ale_haskell_ormolu_executable = 'stack'
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
