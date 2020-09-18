"right click to open[HKEY_CURRENT_USER\SOFTWARE\Classes\*\shell\Open with Neovim\command]
"C:\tools\neovim\Neovim\bin\nvim-qt.exe "%1""
" SYNTAX HIGHLIGHTING... on if terminal has colors
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" 

let s:is_windows = (has("win32") || has("win64"))
let s:is_gui = has("gui_running")

if s:is_windows
  source $VIMRUNTIME/mswin.vim
  behave mswin
endif
behave xterm


call plug#begin()
"# 这里写上需要安装的插键
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
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

"   edit
set scs		        " 查找时智能大小写
set mouse=nvi             " enable mouse interaction
set mousehide		" Hide the mouse when typing text
set number              " line numbers at the side
set ruler               " show the cursor position all the time
set splitright          " create vertical splits to the right
set splitbelow          " create horizontal splits below


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
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" FZF
nnoremap <C-p> :GFiles<CR>
nnoremap <C-o> :Buffers<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}
