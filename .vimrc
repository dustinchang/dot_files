"NeoBundle Scripts-----------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=/home/dustin/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('/home/dustin/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'

" Custom Plugins
NeoBundle 'https://github.com/easymotion/vim-easymotion'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'https://github.com/airblade/vim-gitgutter'
NeoBundle 'https://github.com/ervandew/supertab'
NeoBundle 'https://github.com/terryma/vim-multiple-cursors'
" NeoBundle 'Valloric/YouCompleteMe', {
"      \ 'build'      : {
"         \ 'mac'     : './install.py',
"         \ 'unix'    : './install.py',
"         \ 'windows' : 'install.py',
"         \ 'cygwin'  : './install.py'
"         \ }
"      \ }
" YouCompleteMe has issues with installing easily and
" requires latest version of vim, which may not always
" be on the computers I use.


" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

" On load Commands
set nu
syntax enable
colorscheme molokai
inoremap ii <ESC>
set backspace=indent,eol,start "To make backspace work like assumed
set laststatus=2
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"⭤":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ }
      \ }
