Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_extensions = []
" let g:ctrlp_extensions += 'tag'
" let g:ctrlp_extensions += 'buffertag'
let g:ctrlp_extensions += ['quickfix']
let g:ctrlp_extensions += ['dir']
let g:ctrlp_extensions += ['rtscript']
let g:ctrlp_extensions += ['undo']
let g:ctrlp_extensions += ['line']
let g:ctrlp_extensions += ['changes']
let g:ctrlp_extensions += ['mixed']
let g:ctrlp_extensions += ['bookmarkdir']

  let g:ctrlp_prompt_mappings = {'ToggleFocus()': ['<s-tab>'] }
let g:ctrl_prompt_mappings = {}
let g:ctrl_prompt_mappings['ToggleFocus()'] = ['<c-/>']
nnoremap <c-b> :CtrlPBuffer<CR>
nnoremap <leader><c-p> :CtrlPCurWD<CR>
