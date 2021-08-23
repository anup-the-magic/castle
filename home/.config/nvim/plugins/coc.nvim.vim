Plug 'neoclide/coc.nvim', { 'branch': 'release' }

let g:coc_global_extensions = ['coc-json', 'coc-metals', 'coc-prettier', 'coc-tsserver']

"" coc.nvim, CoC
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
" autocmd CursorHold * silent call CocActionAsync('highlight')

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
nmap ?? call CocAction('doHover')

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

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

"" COC CONFIG
let g:coc_user_config = { 'languageserver': {} }

let g:coc_user_config['codeLens.enable'] = 'true'

let g:coc_user_config['diagnostic.maxWindowHeight'] = 20

let s:hie = {}
let s:hie['command'] = 'hie-wrapper'
let s:hie['scopes'] = ['source.haskell']
let s:hie['syntaxes'] = ['Packages/Haskell/Haskell.sublime-syntax']
let s:hie['filetypes'] = ['haskell']
let s:hie['languageId'] = 'haskell'
" let g:coc_user_config['languageserver']['haskell-ide-engine'] = s:hie

let s:haskell_language_server = {}
let s:haskell_language_server['command'] = 'haskell-language-server-wrapper'
let s:haskell_language_server['args'] = ['--lsp']
let s:haskell_language_server['rootPatterns'] = [
      \ '*.cabal',
      \ 'stack.yaml',
      \ 'cabal.project',
      \ 'package.yaml',
      \ 'hie.yaml'
      \ ]
let s:haskell_language_server['filetypes'] = ['haskell', 'lhaskell']
let s:haskell_language_server['languageId'] = 'haskell'
let s:haskell_language_server['initializationOptions'] = {
      \ 'languageServerHaskell': { 'hlintOn': 1 }
      \ }
let g:coc_user_config['languageserver']['haskell-lsp'] = s:haskell_language_server

let s:elmlang = {}
let s:elmlang['command'] = 'elm-language-server'
let s:elmlang['filetypes'] = ['elm']
let s:elmlang['rootPaterns'] = ['elm.json']
let s:elmlang['initializationOptions'] = { 'elmAnalyseTrigger': 'change' }
let g:coc_user_config['languageserver']['elmlang'] = s:elmlang
