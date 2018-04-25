set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

set nocompatible
"set paste
source $VIMRUNTIME/vimrc_example.vim
if has("win32")
    source $VIMRUNTIME/mswin.vim
    set renderoptions=type:directx,renmode:5,taamode:1
    
    "behave mswin
endif

behave xterm

set ffs=unix,dos
set fencs=cp936,ucs-bom,default,latin1,utf-8    ",ucs-bom
set langmenu=none	" 使用英文菜单
set tw=0

if has("win32")
    au GUIEnter * simalt ~x 
    "nnoremap <silent>  <F2> :!start "D:\tools\dev\Source Insight 3\Insight3.exe" -i  +<C-R>=expand(line("."))<CR> %<CR>
else
    set term=screen
endif





if exists('$TMUX')
    set term=screen-256color
endif

" 1 height windows
"set winminheight=1



set guicursor=a:blinkon0    "   停止闪烁
if has("gui_running")

    if v:version >= 700
        set cursorline		" 高亮当前行,在oceandeep布局下显示的不是很清楚，
        set cursorcolumn
    endif

    "   win下FixedSys的字体比较好看, unix下bitstream不错
    "    set guifont=Bitstream_Vera_Sans_Mono:h12:cANSI
    if has("win32")
        set guifont=Fixedsys:h12:cGB2312
    else
        set guifont=Bitstream\ Vera\ Sans\ Mono\ 16
    endif
    set guioptions-=T    " 去掉工具栏,我喜欢显示的范围更大的
    set guioptions-=m    " 去掉菜单,我喜欢显示的范围更大的
    set guioptions-=l
    set guioptions-=L
    "set guioptions-=r
    "set guioptions-=R


    colorscheme  darkblue "molokai    oceandeep   
    "let g:molokai_original = 1
    "colorscheme  molokai   
    "  desert      " 背景颜色           
else
    set t_Co=256
    " set background=light gives a different style, feel free to choose between them.
    "set background=dark
    colors molokai 
endif

"-------------------------------------------------------------------------------
" Moving cursor to other windows
" 
" shift down   : change window focus to lower one (cyclic)
" shift up     : change window focus to upper one (cyclic)
" shift left   : change window focus to one on left
" shift right  : change window focus to one on right
"-------------------------------------------------------------------------------
"
nmap <s-down>   <c-w>w
nmap <s-up>     <c-w>W
nmap <s-left>   <c-w>h
nmap <s-right>  <c-w>l


set autoread              " read open files again when changed outside Vim
"   set autowrite             " write a modified buffer on each :next , ...
set browsedir  =current   " which directory to use for the file browser
"set nowrap                " 显示时不自动换行, 看个人爱好, 注掉也不错

"-------------------------------------------------------------------------------
" Change the working directory to the directory containing the current file
"-------------------------------------------------------------------------------
if has("autocmd")
    " 如果使用cscope或是ctags的话, 最好不要自动切换目录, 不然标志无法定位
    "  autocmd BufEnter * :lcd %:p:h
endif
"-------------------------------------------------------------------------------
" Filename completion
" 
"   wildmenu : command-line completion operates in an enhanced mode
" wildignore : A file that matches with one of these
"              patterns is ignored when completing file or directory names.
"-------------------------------------------------------------------------------
" 
set wildmenu
set wildignore=*.svn,*.svn-base,*.bak,*.swp,*.zip,*.so,*.o,*.e,*.pyc,*.pyo,*~
set suffixes=.svn


" Allow edit buffers to be hidden
set hidden


if v:version >= 700
    set stal=1        " 当打开多个tab时显示tab,如果只有一个则不显示,tab只在7.0中有效
endif

" Highlight matching parens
"set showmatch


set number              "   显示行号
set et			"   TODO    删除
set ch=2		" Make command line two lines high
set mousehide		" Hide the mouse when typing text
let c_comment_strings=1	" I like highlighting strings inside C comments


set formatoptions=tcrqn2mB
set ts=8	    " tab是8空格
set sw=4	    "shift width,indent时的值是4格, 
set sts=4	    " soft tab是4空格, 按一次tab时也是4格, 使用space代替
set bs=2            " 退格键的模式
set lsp=0	    " space it out a little more (easier to read)
set vb t_vb=	    " set visual bell and disable screen flash

set ru		    " 在下面显示标尺

set grepprg=grep\ -nH	"   使用grep查找, grep包括在unxutils中

"""""""""""""""""""""""""""""""""""""""
"   查找的配置
"""""""""""""""""""""""""""""""""""""""
set incsearch       " use incremental search
set ic		    " 查找时忽略大小写
set is		    " 增量查找
set scs		    " 查找时智能大小写
set hlsearch	    " hlsearch, 高亮显示查找结果
" Wrap on these
set whichwrap+=<,>,[,]
"""""""""""""""""""""""""""""""""""""""
"   自动补全功能
"   编程快捷键, 按#i 空格时, 自动变成#include
"""""""""""""""""""""""""""""""""""""""
iab #i #include
iab #d #define
iab #e #endif




"""""""""""""""""""""""""""""""""""""""
"   配置命令模式下的快键键
"""""""""""""""""""""""""""""""""""""""
"   Tlist   :taglist, 在左边窗口显示文件中的函数名与定义名
"   WMToggle	打开/关闭 资源管理器和buf 管理器
"   zO,zC,zR,zM	折行功能
"   :cn		grep查找到结果时进入下一个结果
"map <F1>    :Tlist<cr>
map <F1>    :NERDTreeToggle<cr>
map <F2>    :TagbarToggle<cr>
map <F3>    zO
map <F4>    zc
map <F5>    zR
map <F6>    zM
map <F7>    :cn<CR>
map <F12>   :NERDTreeToggle<CR>

"NERD Tree
let NERDChristmasTree=0
let NERDTreeAutoCenter=1
let NERDTreeBookmarksFile=$VIM.'\Data\NerdBookmarks.txt'
let NERDTreeMouseMode=2
let NERDTreeShowBookmarks=1
let NERDTreeShowFiles=1
let NERDTreeShowHidden=0
let NERDTreeShowLineNumbers=1
let NERDTreeIgnore=['\.svn$','\.o$','\.ko$','\.cmd$','\~$','\.pyc$','\.pyo$']
let NERDTreeWinPos = "left" "where NERD tree window is placed on the screen
let NERDTreeWinSize = 31 "size of the NERD tree

"""""""""""""""""""""""""""""""""""""""
"   配置备份和交换文件目录
"   默认vim会把这些文件放在当时目录下, 看起来比较乱
"""""""""""""""""""""""""""""""""""""""
set backup    " enable backup and define the backup file
set backupext=.bak
" 设置swap文件的目录到dir
"设置备份文件的目录到backupdir 我不喜欢看到每个目录下都有备份 因为一般备份用不到
if has("unix")
    set dir=/tmp
    set backupdir=/tmp
else
    set nobackup
    set dir=D:\\tmp\\vim\\swap
    "set backupdir=D:\tmp\vim\bak
    set undodir=D:\\tmp\\vim\\swap
endif

"""""""""""""""""""""""""""""""""""""""
"   大文件配置
"""""""""""""""""""""""""""""""""""""""
" file is large from 10mb
let g:LargeFile = 1024 * 1024 * 10
augroup LargeFile 
 autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function LargeFile()
 " no syntax highlighting etc
 set eventignore+=FileType
 " save memory when other file is viewed
 setlocal bufhidden=unload
 " is read-only (write with :w new_filename)
 setlocal buftype=nowrite
 " no undo possible
 setlocal undolevels=-1
 " display message
 autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
endfunction

"""""""""""""""""""""""""""""""""""""""
"   折行配置
"""""""""""""""""""""""""""""""""""""""
"   根据语法折行, 如c/c++中就是{}
if v:version >= 700
    set foldmethod=syntax   " marker,folder模式为语法
else
    "	vim63中不支持根据语法折行
    set foldmethod=indent
endif

set foldlevel=100       " Don't autofold anything (but I can still fold manually)
set foldopen-=search    " don't open folds when you search into them
set foldopen-=undo      " don't open folds when you undo stuff
"""""""""""""""""""""""""""""""""""""""
" Perl
"""""""""""""""""""""""""""""""""""""""
let perl_extended_vars=1 " highlight advanced perl vars inside strings


"   配置git的merge
"   git config --global merge.tool vimdiff
"   git config --global mergetool.prompt false
map <silent> <leader>1 :diffget 1<CR> :diffupdate<CR>
map <silent> <leader>2 :diffget 2<CR> :diffupdate<CR>
map <silent> <leader>3 :diffget 3<CR> :diffupdate<CR>
map <silent> <leader>4 :diffget 4<CR> :diffupdate<CR>




""""""""""""""""""""""""""""""""""""""
"   网上下载
""""""""""""""""""""""""""""""""""""""
" Nice statusbar
set laststatus=2
set statusline=
set statusline+=%2*%-10.3n%0*\                " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%1*%m%r%w%0*               " flags
"set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
"set statusline+=%{&encoding},                " encoding
"set statusline+=%{&fileformat}]              " file format
if filereadable(expand("$VIM/vimfiles/plugin/vimbuddy.vim"))
    set statusline+=\ %{VimBuddy()}          " vim buddy
endif
set statusline+=%=                           " right align
set statusline+=%2*0x%-4B\                   " current char
set statusline+=%-8.(%l,%c%V%)\ %<%P        " offset

" special statusbar for special windows
if has("autocmd")
    au FileType qf
                \ if &buftype == "quickfix" |
                \     setlocal statusline=%2*%-3.3n%0* |
                \     setlocal statusline+=\ \[Compiler\ Messages\] |
                \     setlocal statusline+=%=%2*\ %<%P |
                \ endif

    fun! <SID>FixMiniBufExplorerTitle()
        if "-MiniBufExplorer-" == bufname("%")
            setlocal statusline=%2*%-3.3n%0*
            setlocal statusline+=\[Buffers\]
            setlocal statusline+=%=%2*\ %<%P
        endif
    endfun


    au BufWinEnter *
                \ let oldwinnr=winnr() |
                \ windo call <SID>FixMiniBufExplorerTitle() |
                \ exec oldwinnr . " wincmd w"
endif

" Nice window title
if has('title') && (has('gui_running') || &title)
    set titlestring=
    set titlestring+=%f\                     " file name
    set titlestring+=%h%m%r%w                " flags
    set titlestring+=\ -\ %{v:progname}      " program name
endif

" If possible, try to use a narrow number column.
if v:version >= 700
    try
        setlocal numberwidth=3
    catch
    endtry
endif


" Better include path
set path+=src/

" Show tabs and trailing whitespace visually
"if (&termencoding == "utf-8") || has("gui_running")
"    if v:version >= 700
"        set list listchars=tab:?·,trail:·,extends:…,nbsp:?
"    else
"        set list listchars=tab:?·,trail:·,extends:…
"    endif
"else
"    if v:version >= 700
"        set list listchars=tab:>-,trail:.,extends:>,nbsp:_
"    else
"        set list listchars=tab:>-,trail:.,extends:>
"    endif
"endif

set fillchars=fold:-

"	 "-----------------------------------------------------------------------
"	 " completion
"	 "-----------------------------------------------------------------------
"	 set dictionary=/usr/share/dict/words






"""""""""""""""""""""""""""""""""""""""
"   插件配置
"""""""""""""""""""""""""""""""""""""""
"   taglist,	显示在右边
let Tlist_Use_Right_Window=0
"let Tlist_WinWidth = 20
"let Tlist_Inc_Winwidth = 0
let Tlist_Enable_Fold_Column = 0
let g:defaultExplorer=0

"-----------------------------------------------------------------------
" plugin / script / app settings
"-----------------------------------------------------------------------

if has("eval")
    " Perl specific options
    let perl_include_pod=1
    let perl_fold=1
    let perl_fold_blocks=1

    " Vim specific options
    let g:vimsyntax_noerror=1
    let g:vimembedscript=0

    " c specific options
    let g:c_gnu=1
    let g:c_no_curly_error=1

    " eruby options
    au Syntax * hi link erubyRubyDelim Directory

    " Settings for taglist.vim
    let Tlist_Use_Right_Window=1
    let Tlist_Auto_Open=0
    let Tlist_Enable_Fold_Column=0
    let Tlist_Compact_Format=1
    let Tlist_WinWidth=28
    let Tlist_Exit_OnlyWindow=1
    let Tlist_File_Fold_Auto_Close = 1
    "  nnoremap <silent> <F9> :Tlist<CR>

    "	     " Settings minibufexpl.vim
    "	     let g:miniBufExplModSelTarget = 1
    "	     let g:miniBufExplWinFixHeight = 1
    "	     let g:miniBufExplWinMaxSize = 1
    "	     " let g:miniBufExplForceSyntaxEnable = 1

    " Settings for showmarks.vim
    if has("gui_running")
        let g:showmarks_enable=1
    else
        let g:showmarks_enable=0
        let loaded_showmarks=1
    endif

    let g:showmarks_include="abcdefghijklmnopqrstuvwxyz"

    if has("autocmd")
        fun! <SID>FixShowmarksColours()
            if has('gui')
                hi ShowMarksHLl gui=bold guifg=#a0a0e0 guibg=#2e2e2e
                hi ShowMarksHLu gui=none guifg=#a0a0e0 guibg=#2e2e2e
                hi ShowMarksHLo gui=none guifg=#a0a0e0 guibg=#2e2e2e
                hi ShowMarksHLm gui=none guifg=#a0a0e0 guibg=#2e2e2e
                hi SignColumn   gui=none guifg=#f0f0f8 guibg=#2e2e2e
            endif
        endfun
        if v:version >= 700
            autocmd VimEnter,Syntax,ColorScheme * call <SID>FixShowmarksColours()
        else
            autocmd VimEnter,Syntax * call <SID>FixShowmarksColours()
        endif
    endif

    " Settings for explorer.vim
    let g:explHideFiles='^\.'

    " Settings for netrw
    let g:netrw_list_hide='^\.,\~$'

    " Settings for :TOhtml
    let html_number_lines=1
    let html_use_css=1
    let use_xhtml=1

    " cscope settings
    if has('cscope') 
        " && filereadable("/usr/bin/cscope")
        """""""""""""""""""""""""""""""""""""""
        "   设置使用cscope, 并设置自动查找tags文件的目录
        """""""""""""""""""""""""""""""""""""""
        set cst
        set csto=1
        set tags=./tags,../tags,../../tags,../../../tags
        set cspc=3	    " show file path's last three part
        set csto=0
        set cscopetag
        set nocsverb
        "if filereadable("cscope.out")
        "    cs add cscope.out
        "endif
        "set csverb

        let x = "sgctefd"
        while x != ""
            let y = strpart(x, 0, 1) | let x = strpart(x, 1)
            exec "nmap <C-j>" . y . " :cscope find " . y .
                        \ " <C-R>=expand(\"\<cword\>\")<CR><CR>"
            exec "nmap <C-j><C-j>" . y . " :scscope find " . y .
                        \ " <C-R>=expand(\"\<cword\>\")<CR><CR>"
        endwhile
        nmap <C-j>i      :cscope find i ^<C-R>=expand("<cword>")<CR><CR>
        nmap <C-j><C-j>i :scscope find i ^<C-R>=expand("<cword>")<CR><CR>
    endif
endif


if has("win32")
"   tagtoggle
" Added to ~/ctags.cnf (On Win7):
" --langdef=powershell
" --langmap=powershell:.ps1.psm1
" --regex-powershell=/^[Ff]unction[\t ]*([a-zA-Z0-9_-]+)/\1/f,function/
" --regex-powershell=/^[Ff]ilter[\t ]*([a-zA-Z0-9_-]+)/\1/i,filter/
" --regex-powershell=/^[sS]et-[Aa]lias[\t ]*([a-zA-Z0-9_-]+)/\1/a,alias/
    let g:tagbar_type_ps1 = {
                \ 'ctagstype' : 'powershell',
                \ 'kinds'     : [
                \ 'f:function',
                \ 'i:filter',
                \ 'a:alias'
                \ ]
                \ }
" ctrlp
    let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'  " Windows
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
else
    " ctrlp
    set wildignore+=*/tmp/*,*.so,*.pyc,*.pyo,*.swp,*.zip     " Linux/MacOSX
    let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
endif

""""""""""""""""""""""""""""""""""""""
"   ctrlp
""""""""""""""""""""""""""""""""""""""
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/]\.(git|hg|svn)$',
	\ 'file': '\v\.(exe|so|dll)$',
	\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
	\ }


""""""""""""""""""""""""""""""""""""""""""""""""""""
"	其它不用的
""""""""""""""""""""""""""""""""""""""""""""""""""""
" turn off any existing search
if has("autocmd")
    "     au VimEnter * nohls
endif

" set showfulltag	    " Show full tags when doing search completion

" Speed up macros
set lazyredraw

" Try to show at least three lines and two columns of context when
" scrolling
" set scrolloff=3
" set sidescrolloff=2

"-------------------------------------------------------------------------------
" Use of dictionaries
"	 "-----------------------------------------------------------------------
"	 " final commands
"	 "-----------------------------------------------------------------------
"	 " mio
"	 let Tlist_Ctags_Cmd="/usr/bin/exuberant-ctags"
"	 " plegado ident para python
"	 au FileType python set foldmethod=indent
"	 " plegado syntax para sgml,htmls,xml y xsl
"	 au Filetype html,xml,xsl,sgml,docbook
"	 " explorador vertical
"	 let g:explVertical=1
"	 " define leader como =
"	 let mapleader = "="
"	
"	 map <S-F2> :vsplit ~/.vim/ref_full.vim<CR>
"	 map <F2> :11vsplit ~/.vim/ref.vim<CR>
"	 map <F3> :Sexplore /home/bass/<CR>
"	 map <S-F3> :2split ~/.vim/fun_ref.vim<CR>
"	 map <F4> :set nu<CR>
"	 map <S-F4> :set nu!<CR>
"	 map <F5> ggVGg?
"	 map <F6> :set encoding=utf-8<CR> | :set fenc=utf-8<CR>
"	 map <S-F6> :set encoding=iso8859-15<CR> | :set fenc=iso8859-15<CR>
"	 map <F7> :SpellProposeAlternatives<CR>
"	 map <S-F7> :SpellCheck<CR>
"	 map <C-F7> :let spell_language_list = "english,spanish"
"	 nnoremap <silent> <F8> :Tlist<CR>
"	 nnoremap <silent> <S-F8> :TlistSync<CR>
"	 map <F11> !!date<CR>
"	 map <F12> :TC<CR>
"	 nmap  :X        :x
"	 nmap  :W        :w
"	 nmap  :Q        :q
"	 noremap <Leader>rg :color relaxedgreen<CR>
"	 noremap <Leader>ip :color inkpot<CR>
"	
"	 " CVS
"	 nmap <leader>cadd <Plug>CVSAdd
"	 nmap <leader>cci <Plug>CVSCommit
"	 nmap <leader>clog <Plug>CVSLog
"	 map <leader>cre <Plug>CVSRevert
"	 nmap <leader>cup <Plug>CVSUpdate
"	 nmap <leader>cdiff <Plug>CVSDiff
"	
"	 " Spell
"	 let spell_executable = "aspell"
"	 let spell_language_list = "spanish,english"
"	
"	 " Comentiffy
"	 let g:EnhCommentifyMultiPartBlocks = 'yes'
"	 let g:EnhCommentifyAlignRight = 'yes'
"	 " let g:EnhCommentifyRespectIndent = 'Yes'
"	 let g:EnhCommentifyPretty = 'Yes'
"	 " let g:EnhCommentifyUserBindings = 'yes'

"-----------------------------------------------------------------------
" vim: set shiftwidth=4 softtabstop=4 expandtab tw=72                  :


" 
" dictionary : List of file names that are used to lookup words
"              for keyword completion commands
"   complete : search the files defined by the 'dictionary' option
"-------------------------------------------------------------------------------
"
"set complete+=k






"	"-----------------------------------------------------------------------
"	" autocmds
"	"-----------------------------------------------------------------------
"	
"	if has("eval")
"	
"	    " If we're in a wide window, enable line numbers.
"	    fun! <SID>WindowWidth()
"	        if winwidth(0) > 90
"	            setlocal foldcolumn=1
"	            setlocal number
"	        else
"	            setlocal nonumber
"	            setlocal foldcolumn=0
"	        endif
"	    endfun
"	endif
"	
"	" content creation
"	if has("autocmd")
"	    augroup content
"	        autocmd!
"	
"	        autocmd BufNewFile *.rb 0put ='# vim: set sw=4 sts=4 et tw=80 :' |
"	                    \ 0put ='#!/usr/bin/ruby' | set sw=4 sts=4 et tw=80 |
"	                    \ norm G
"	
"	        autocmd BufNewFile *.hh 0put ='/* vim: set sw=4 sts=4 et foldmethod=syntax : */' |
"	                    \ 1put ='' | call MakeIncludeGuards() |
"	                    \ 5put ='#include \"config.h\"' |
"	                    \ set sw=4 sts=4 et tw=80 | norm G
"	
"	        autocmd BufNewFile *.cc 0put ='/* vim: set sw=4 sts=4 et foldmethod=syntax : */' |
"	                    \ 1put ='' | 2put ='' | call setline(3, '#include "' .
"	                    \ substitute(expand("%:t"), ".cc$", ".hh", "") . '"') |
"	                    \ set sw=4 sts=4 et tw=80 | norm G
"	
"	        autocmd BufNewFile configure.ac
"	                    \ 0put ='dnl vim: set sw=8 sts=8 noet :' |
"	                    \ $put ='' |
"	                    \ call setline(line('$'), 'AC_INIT([' . substitute(expand('%:p:h'),
"	                    \     '^.\{-}/\([^/]\+\)\(/trunk\)\?$', '\1', '') . '], [0.0])') |
"	                    \ $put ='AC_PREREQ(2.5)' |
"	                    \ $put ='AC_CONFIG_SRCDIR([])' |
"	                    \ $put ='AC_CONFIG_AUX_DIR(config)' |
"	                    \ $put ='AM_INIT_AUTOMAKE(1.9)' |
"	                    \ $put ='' |
"	                    \ $put ='dnl check for required programs' |
"	                    \ $put ='AC_PROG_CXX' |
"	                    \ $put ='AC_PROG_INSTALL' |
"	                    \ $put ='AC_PROG_LN_S' |
"	                    \ $put ='AC_PROG_RANLIB' |
"	                    \ $put ='AC_PROG_MAKE_SET' |
"	                    \ $put ='' |
"	                    \ $put ='dnl output' |
"	                    \ $put ='AM_CONFIG_HEADER(config.h)' |
"	                    \ $put ='AC_OUTPUT(' |
"	                    \ $put ='   Makefile' |
"	                    \ $put ='   src/Makefile' |
"	                    \ $put ='   )' |
"	                    \ set sw=8 sts=8 noet |
"	                    \ norm ggjjjjf]
"	
"	        autocmd BufNewFile autogen.bash
"	                    \ 0put ='#!/usr/bin/env bash' |
"	                    \ 1put ='# vim: set sw=4 sts=4 et tw=80 :' |
"	                    \ $put ='run() {' |
"	                    \ $put ='echo \">>> $@\"' |
"	                    \ $put ='    if ! $@ ; then' |
"	                    \ $put ='        echo \"oops!\" 1>&2' |
"	                    \ $put ='        exit 127' |
"	                    \ $put ='    fi' |
"	                    \ $put ='}' |
"	                    \ $put ='' |
"	                    \ $put ='get() {' |
"	                    \ $put ='    type ${1}-${2}    &>/dev/null && echo ${1}-${2}    && return' |
"	                    \ $put ='    type ${1}${2//.}  &>/dev/null && echo ${1}${2//.}  && return' |
"	                    \ $put ='    type ${1}         &>/dev/null && echo ${1}         && return' |
"	                    \ $put ='    echo \"Could not find ${1} ${2}\" 1>&2' |
"	                    \ $put ='    exit 127' |
"	                    \ $put ='}' |
"	                    \ $put ='' |
"	                    \ $put ='run mkdir -p config' |
"	                    \ $put ='run $(get libtoolize 1.5 ) --copy --force --automake' |
"	                    \ $put ='rm -f config.cache' |
"	                    \ $put ='run $(get aclocal 1.9 )' |
"	                    \ $put ='run $(get autoheader 2.59 )' |
"	                    \ $put ='run $(get autoconf 2.59 )' |
"	                    \ $put ='run $(get automake 1.9 ) -a --copy' |
"	                    \ set sw=4 sts=4 et tw=80 |
"	                    \ norm gg=Ggg
"	
"	        autocmd BufNewFile Makefile.am
"	                    \ 0put ='CLEANFILES = *~' |
"	                    \ if (! filereadable(expand("%:p:h:h") . '/Makefile.am')) |
"	                    \     $put ='MAINTAINERCLEANFILES = Makefile.in configure config/* aclocal.m4 \' |
"	                    \     $put ='' |
"	                    \     call setline(line('$'), "\t\t\tconfig.h config.h.in") |
"	                    \     $put ='AUTOMAKE_OPTIONS = foreign dist-bzip2' |
"	                    \     $put ='EXTRA_DIST = autogen.bash' |
"	                    \ else |
"	                    \     $put ='MAINTAINERCLEANFILES = Makefile.in' |
"	                    \ endif
"	
"	    augroup END
"	endif
"	
"	"-----------------------------------------------------------------------
"	" mappings
"	"-----------------------------------------------------------------------
"	
"	nmap   <silent> <S-Right>  :bnext<CR>
"	
"	" v_K is really really annoying
"	vmap K k
"	
"	" Delete a buffer but keep layout
"	if has("eval")
"	    command! Kwbd enew|bw #
"	    nmap     <C-w>!   :Kwbd<CR>
"	endif
"	
"	" quickfix things
"	nmap <Leader>cwc :cclose<CR>
"	nmap <Leader>cwo :botright copen 5<CR><C-w>p
"	nmap <Leader>cn  :cnext<CR>
"	
"	" Annoying default mappings
"	inoremap <S-Up>   <C-o>gk
"	inoremap <S-Down> <C-o>gj
"	noremap  <S-Up>   gk
"	noremap  <S-Down> gj
"	
"	" Make <space> in normal mode go down a page rather than left a
"	" character
"	noremap <space> <C-f>
"	
"	" Useful things from inside imode
"	inoremap <C-z>w <C-o>:w<CR>
"	inoremap <C-z>q <C-o>gq}<C-o>k<C-o>$
"	
"	" Commonly used commands
"	"nmap <silent> <F3> :silent nohlsearch<CR>
"	"imap <silent> <F3> <C-o>:silent nohlsearch<CR>
"	"nmap <F4> :Kwbd<CR>
"	"nmap <F5> <C-w>c
"	"nmap <F7> :make check<CR>
"	"nmap <F8> :make<CR>
"	"nmap <F10> :!svn update<CR>
"	"nmap <F11> :!svn status \| grep -v '^?' \| sort -k2<CR>
"	
"	" Insert a single char
"	noremap <Leader>i i<Space><Esc>r
"	
"	" Split the line
"	nmap <Leader>n \i<CR>
"	
"	" Pull the following line to the cursor position
"	noremap <Leader>J :s/\%#\(.*\)\n\(.*\)/\2\1<CR>
"	
"	" In normal mode, jj escapes
"	inoremap jj <Esc>
"	
"	" Kill line
"	noremap <C-k> "_dd
"	
"	" Select everything
"	noremap <Leader>gg ggVG
"	
"	" Reformat everything
"	noremap <Leader>gq gggqG
"	
"	" Reformat paragraph
"	noremap <Leader>gp gqap
"	
"	" Clear lines
"	noremap <Leader>clr :s/^.*$//<CR>:nohls<CR>
"	
"	" Delete blank lines
"	noremap <Leader>dbl :g/^$/d<CR>:nohls<CR>
"	
"	" Enclose each selected line with markers
"	noremap <Leader>enc :<C-w>execute
"	            \ substitute(":'<,'>s/^.*/#&#/ \| :nohls", "#", input(">"), "g")<CR>
"	
"	" Enable fancy % matching
"	if has("eval")
"	    runtime! macros/matchit.vim
"	endif
"	"	
"	"	 " q: sucks
"	"	 nmap q: :q
"	"	
"	"	 " set up some more useful digraphs
"	"	 if has("digraphs")
"	"	     digraph ., 8230    " ellipsis (…)
"	"	 endif
"	
"	if has("eval")
"	    " GNU format changelog entry
"	    fun! MakeChangeLogEntry()
"	        norm gg
"	        /^\d
"	        norm 2O
"	        norm k
"	        call setline(line("."), strftime("%Y-%m-%d") .
"	                    \ " J. Alberto Suárez López <bass@gentoo.org>")
"	        norm 2o
"	        call setline(line("."), "\t* ")
"	        norm $
"	    endfun
"	    noremap <Leader>cl :call MakeChangeLogEntry()<CR>
"	
"	    " command aliases, can't call these until after cmdalias.vim is loaded
"	    au VimEnter * if exists("loaded_cmdalias") |
"	                \       call CmdAlias("mkdir",   "!mkdir") |
"	                \       call CmdAlias("cvs",     "!cvs") |
"	                \       call CmdAlias("svn",     "!svn") |
"	                \       call CmdAlias("commit",  "!svn commit -m \"") |
"	                \       call CmdAlias("upload",  "make upload") |
"	                \ endif
"	endif
"	
"	" super i_c-y / i_c-e
"	if v:version >= 700 && has("eval")
"	    fun! SuperYank(offset)
"	        let l:cursor_pos = col(".")
"	        let l:this_line = line(".")
"	        let l:source_line = l:this_line + a:offset
"	        let l:this_line_text = getline(l:this_line)
"	        let l:source_line_text = getline(l:source_line)
"	        let l:add_text = ""
"	
"	        let l:motion = "" . nr2char(getchar())
"	        if -1 != match(l:motion, '\d')
"	            let l:count = 0
"	            while -1 != match(l:motion, '\d')
"	                let l:count = l:count * 10 + l:motion
"	                let l:motion = "" . nr2char(getchar())
"	            endwhile
"	        else
"	            let l:count = 1
"	        endif
"	
"	        if l:motion == "$"
"	            let l:add_text = strpart(l:source_line_text, l:cursor_pos - 1)
"	        elseif l:motion == "w"
"	            let l:add_text = strpart(l:source_line_text, l:cursor_pos - 1)
"	            let l:add_text = substitute(l:add_text,
"	                        \ '^\(\s*\%(\S\+\s*\)\{,' . l:count . '}\)\?.*', '\1', '')
"	        elseif l:motion == "f" || l:motion == "t"
"	            let l:add_text = strpart(l:source_line_text, l:cursor_pos - 1)
"	            let l:char = nr2char(getchar())
"	            let l:pos = matchend(l:add_text,
"	                        \ '^\%([^' . l:char . ']\{-}' . l:char . '\)\{' . l:count . '}')
"	            if -1 != l:pos
"	                let l:add_text = strpart(l:add_text, 0, l:motion == "f" ? l:pos : l:pos - 1)
"	            else
"	                let l:add_text = ''
"	            endif
"	        else
"	            echo "Unknown motion: " . l:motion
"	        endif
"	
"	        if l:add_text != ""
"	            let l:new_text = strpart(l:this_line_text, 0, l:cursor_pos - 1) .
"	                        \ l:add_text . strpart(l:this_line_text, l:cursor_pos - 1)
"	            call setline(l:this_line, l:new_text)
"	            call cursor(l:this_line, l:cursor_pos + strlen(l:add_text))
"	        endif
"	    endfun
"	
"	    inoremap <C-g>y <C-\><C-o>:call SuperYank(-1)<CR>
"	    inoremap <C-g>e <C-\><C-o>:call SuperYank(1)<CR>
"	endif
"	
"	"	 " tab completion
"	"	 if has("eval")
"	"	     function! CleverTab()
"	"	         if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
"	"	             return "\<Tab>"
"	"	         else
"	"	             return "\<C-N>"
"	"	         endif
"	"	     endfun
"	"	     inoremap <Tab> <C-R>=CleverTab()<CR>
"	"	     inoremap <S-Tab> <C-P>
"	"	 endif
"	
"	"	
"	"	     augroup abbreviations
"	"	         autocmd!
"	"	         autocmd FileType cpp :call <SID>abbrev_cpp()
"	"	     augroup END
"	"	 endif
"	
"	"-----------------------------------------------------------------------
"	" special less.sh and man modes
"	"-----------------------------------------------------------------------
"	
"	if has("eval") && has("autocmd")
"	    fun! <SID>check_pager_mode()
"	        if exists("g:loaded_less") && g:loaded_less
"	            " we're in vimpager / less.sh / man mode
"	            set laststatus=0
"	            set ruler
"	            set foldmethod=manual
"	            set foldlevel=99
"	            set nolist
"	        endif
"	    endfun
"	    autocmd VimEnter * :call <SID>check_pager_mode()
"	endif
