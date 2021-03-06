"去掉vi的一致性"
set nocompatible
"显示行号"
set number
" 隐藏滚动条"
set guioptions-=r
set guioptions-=L
set guioptions-=b
"隐藏顶部标签栏"
set showtabline=0
"设置字体"
set guifont=Monaco:h13
"vim 解决中文乱码问题"
"set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1

syntax on    "开启语法高亮"
"let g:solarized_termcolors=256    "solarized主题设置在终端下的设置"
"set background=dark        "设置背景色"
colorscheme gotham

set wrap    "设置折行"
set fileformat=unix    "设置以unix的格式保存文件"
set cindent        "设置C样式的缩进格式"
set tabstop=8    "设置table长度"
set shiftwidth=8        "同上"
set listchars=tab:>-,trail:-,extends:#,nbsp:- "设置tab可见格式
set list  "设置tab可见"

set showmatch    "显示匹配的括号"
set scrolloff=5        "距离顶部和底部5行"
set laststatus=2    "命令行为两行"
set fenc=utf-8      "文件编码"
set backspace=2
set mouse=c        "启用鼠标"
set selection=exclusive
set selectmode=mouse,key
set matchtime=5
set ignorecase        "忽略大小"
set incsearch
set hlsearch        "高亮搜索项"
set noexpandtab        "不允许扩展table"
set whichwrap+=<,>,h,l
set autoread
set smartcase " 如果搜索模式包含大写字符，不使用 'ignorecase' 选项。只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用。
set autowrite " 自动把内容写回文件: 如果文件被修改过，在每个 :next、:rewind、:last、:first、:previous、:stop、:suspend、:tag、:!、:make、CTRL-] 和 CTRL-^命令时进行；用 :buffer、CTRL-O、CTRL-I、'{A-Z0-9} 或 `{A-Z0-9} 命令转到别的文件时亦然。
set cursorline        "突出显示当前行"
set cursorcolumn        "突出显示当前列"
"设置自动cd到vim打开的文件所在位置
"set autochdir
"递归从下往上找tags文件
set tags=tags;
"需要先去生成一个systags
set tags+=~/.vim/systags;

set autoindent " 设置自动对齐(缩进)：即每行的缩进值与上一行相等；使用 noautoindent 取消设置
set linebreak " 整词换行

"set clipboard=unnamedplus "设置默认系统粘贴板"
if $TMUX == ''
	set clipboard+=unnamed
endif
"map "+y :!xclip -f -sel clip
"map "+p :r!xclip -o -sel clip


"开启记录光标位置
augroup resCur
	autocmd!
	autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Lokaltog/vim-powerline'
Plugin 'scrooloose/nerdtree'
Plugin 'Yggdroot/indentLine'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tell-k/vim-autopep8'
Plugin 'scrooloose/nerdcommenter'
Plugin 'flazz/vim-colorschemes'
Plugin 'rdnetto/YCM-Generator'
Plugin 'kien/ctrlp.vim'
Plugin 'Chiel92/vim-autoformat'
call vundle#end()
filetype plugin indent on

"缩进指示线"
let g:indentLine_char='┆'
let g:indentLine_enabled = 1

"autopep8设置"
let g:autopep8_disable_show_diff=1

if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=0
	set cst
	set csverb
	set cspc=3
	"add any database in current dir
	if filereadable("cscope.out")
		cs add cscope.out
		"else search cscope.out elsewhere
	else
		let cscope_file=findfile("cscope.out", ".;")
		let cscope_pre=matchstr(cscope_file, ".*/")
		if !empty(cscope_file) && filereadable(cscope_file)
			exe "cs add" cscope_file cscope_pre
		endif
	endif
endif



"YouCompleteMe插件中要设置extra config，来自于YCM-Generator
"let g:ycm_global_ycm_extra_conf = '~/Documents/linux-4.19.2/.ycm_extra_conf.py'
let g:ycm_global_ycm_extra_conf = '/home/shipt/.vim/.ycm_extra_conf.py'
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0

"Youcompleteme 插件开启debug模式
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

"设置语法折叠
set foldenable              " 开始折叠
set foldmethod=syntax       " 设置语法折叠
set foldcolumn=0            " 设置折叠区域的宽度
setlocal foldlevel=1        " 设置折叠层数为
set foldlevelstart=99       " 打开文件是默认不折叠代码

set foldclose=all          " 设置为自动关闭折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
"                            " 用空格键来开关折叠

"设置taglist插件
map <silent> <F9> :TlistToggle<cr>
let Tlist_Auto_Open = 0 "1代表自动开启taglist。0表示关闭"
let Tlist_Use_Right_Window = 1 "右侧放置taglist窗口"
let Tlist_Exit_OnlyWindow = 1 "如果taglist是最后一个窗口，则关闭"

"astyle自动格式化
"au BufWrite * :Autoformat
let g:autoformat_remove_trailing_spaces = 1
noremap <F3> :Autoformat<CR>

let g:formatdef_linux_8 = '"astyle --style=linux -t8 -H -p -U"'
let g:formatters_cpp = ['linux_8']
let g:formatters_c = ['linux_8']

"nerdtree setting
"设置快捷键 F2 
map <F2> :NERDTreeToggle<CR>
"自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&b:NERDTreeType == "primary") | q | endif
"打开文件夹时自动打开nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
