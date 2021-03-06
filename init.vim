" All:    mkdir 
"Windows:  right click to open[HKEY_CURRENT_USER\SOFTWARE\Classes\*\shell\Open with Neovim\command]
"          C:\tools\neovim\Neovim\bin\nvim-qt.exe "%1""
"      curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"      edit %userprofile%\AppData\Local\nvim\init.vim
" Mac:
"      brew install neovim
"      curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"      mkdir -p ~/.config/nvim && vi ~/.config/nvim/init.vim

let s:is_windows = (has("win32") || has("win64"))
let s:is_gui = has("gui_running")

if &compatible
  set nocompatible               " Be iMproved
endif

if s:is_windows
  source $VIMRUNTIME/mswin.vim
  behave mswin
endif
behave xterm
filetype plugin on

"_________________________________________________________________________
" PACKAGE SETTINGS
"
call plug#begin('~/.vim/plugged')
"# 这里写上需要安装的插键
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
call plug#end()


"_________________________________________________________________________
" GENERAL SETTINGS
"
map <silent> <F1>    :NERDTreeToggle<cr>
map <silent> <F3>    zO
map <silent> <F4>    zc
map <silent> <F5>    zR
map <silent> <F6>    zM
map <silent> <F7>    :cn<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>r :Rg 
nnoremap <C-p> :GFiles<CR>
nnoremap <C-o> :Buffers<CR>

"   color
syntax enable
set background=dark
colorscheme solarized
let g:solarized_termcolors=256

"   edit
set autoread              " read open files again when changed outside Vim
set autowrite             " write a modified buffer on each shell
set browsedir=current     " which directory to use for the file browser

set scs		        " 查找时智能大小写
set mouse=nvi             " enable mouse interaction
set mousehide		" Hide the mouse when typing text
set number              " line numbers at the side
set ruler               " show the cursor position all the time
set splitright          " create vertical splits to the right
set splitbelow          " create horizontal splits below
set cursorline

" fold
set foldenable
set foldmethod=indent   " marker,folder模式为语法
autocmd FileType cpp,c setlocal foldmethod=syntax
set foldlevelstart=2

let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML

set foldlevel=100       " Don't autofold anything (but I can still fold manually)
set foldopen-=search    " don't open folds when you search into them
set foldopen-=undo      " don't open folds when you undo stuff
"set foldopen=block,hor,mark,percent,quickfix,search,tag " what movements open folds

"   indent
set autoindent          " copy indent from the current line when starting a new line
set nosmartindent
set cindent
set cinoptions=:s,ps,ts,cs
set cinwords=if,else,while,do,for,switch,case
set shiftwidth=4        " pressing >> or << in normal mode indents by 4 characters
set tabstop=8           " a tab character indents to the 4th (or 8th, 12th, etc.) column
set sts=4	    " soft tab是4空格, 按一次tab时也是4格, 使用space代替
set expandtab 
set smarttab 


" Filename completion
set wildmode=longest:full,full
set wildmenu
set wildignore+=*.svn,*.svn-base,*.bak,*.sw?,*.zip,*.so,*.e,*.pyc,*.pyo,*~
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifestg,*.d

"   NERDTree
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeIgnore = ['^node_modules$']
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" FZF
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}
" vim-easy-align
vmap <Leader>a <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
if !exists('g:easy_align_delimiters')
  let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String'] }
