" ~/.vimrc (configuration file for vim only)
" skeletons
function! SKEL_spec()
	0r /usr/share/vim/current/skeletons/skeleton.spec
	language time en_US
	let login = system('whoami')
	if v:shell_error
	   let login = 'unknown'
	else
	   let newline = stridx(login, "\n")
	   if newline != -1
		let login = strpart(login, 0, newline)
	   endif
	endif
	let hostname = system('hostname -f')
	if v:shell_error
	    let hostname = 'localhost'
	else
	    let newline = stridx(hostname, "\n")
	    if newline != -1
		let hostname = strpart(hostname, 0, newline)
	    endif
	endif
	exe "%s/specRPM_CREATION_DATE/" . strftime("%a\ %b\ %d\ %Y") . "/ge"
	exe "%s/specRPM_CREATION_AUTHOR_MAIL/" . login . "@" . hostname . "/ge"
	exe "%s/specRPM_CREATION_NAME/" . expand("%:t:r") . "/ge"
endfunction
autocmd BufNewFile	*.spec	call SKEL_spec()

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


" do not use vi key mode, use vim's instead
set nocompatible

" syntax 
set syntax=on

" disable voice remind for wrong typing
set noeb

" force ask to confirm save before switch from unsaved file
set confirm

" auto indent
set autoindent
set cindent

" set width of Tab key
set tabstop=4

" width of auto indent
set shiftwidth=4

set softtabstop=4
set expandtab

 
 

" use tab at the start of line and paragraph
set smarttab

" show line number
set number

" show history
set history=1000

" disable to generate swap file
set nobackup
set noswapfile
set ignorecase

" high light search result
set hlsearch
set incsearch

" replacement in a line
set gdefault

" code setting
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936


" set what will be shown in status bar
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
"set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]

" always show status bar
set laststatus=2

" show ruler
set ruler

" set command line height
set cmdheight=2

" enable file type detection
filetype on

" enable auto load file type plugin
filetype plugin on

" different indent scheme for different file type
filetype indent on

" save global variable
set viminfo+=!

" don't add line feed for those charactar
set iskeyword+=_,$,@,%,#,-

" space added measured with pixel, in between charatars
set linespace=0

set wildmenu

set backspace=2

set whichwrap+=<,>,h,l

" enable mouse selection 
set mouse=a
set selection=exclusive
set selectmode=mouse,key

set report=0

set shortmess=atI

" show blank space in between splitted windows
set fillchars=vert:\ ,stl:\ ,stlnc:\

" show matched bracket
set showmatch

" indicate how long time the matched bracket will show
set matchtime=5

set scrolloff=3

set smartindent

" show line number only when file type was detected
if has("autocmd")
autocmd FileType xml,html,c,cs,java,perl,shell,bash,cpp,python,vim,php,ruby set number
autocmd FileType xml,html vmap <C-o> <ESC>'<i<!–<ESC>o<ESC>'>o–>
autocmd FileType java,c,cpp,cs vmap <C-o> <ESC>'<o/*<ESC>'>o*/
autocmd FileType html,text,php,vim,c,java,xml,bash,shell,perl,python setlocal textwidth=100
autocmd Filetype html,xml,xsl source $VIMRUNTIME/plugin/closetag.vim
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif
endif " has("autocmd")

" F5 compile and run C program
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
exec "w"
exec "!gcc % -o %<"
exec "! ./%<"
endfunc

" F6 compile and run C++ program
map <F6> :call CompileRunGpp()<CR>
func! CompileRunGpp()
exec "w"
exec "!g++ % -o %<"
exec "! ./%<"
endfunc

" nicely show .NFO file
set encoding=utf-8
function! SetFileEncodings(encodings)
let b:myfileencodingsbak=&fileencodings
let &fileencodings=a:encodings
endfunction
function! RestoreFileEncodings()
let &fileencodings=b:myfileencodingsbak
unlet b:myfileencodingsbak
endfunction

au BufReadPre *.nfo call SetFileEncodings('cp437')|set ambiwidth=single
au BufReadPost *.nfo call RestoreFileEncodings()

" enable folder/unfolder code by space key
set foldenable
set foldmethod=indent
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" setting for minibufexpl
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" minibufexpl keyboard bounding
map <C-l> <C-k><Tab><CR>
map <C-h> <C-k><S-Tab><CR> 

" fast switch from header and source file
nnoremap <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

function! Csc()
  cscope find c <cword>
  copen
endfunction
" command! Csc call Csc()
nnoremap <F5> :call Csc()<CR>

" add file for search from
cs add cscope.out

" add 80 column limit
set colorcolumn=80
highlight ColorColumn ctermbg=7

" set tags, ';' is to ask vim search tags file in parent folder
set tags=./tags;

" enable mouse select feature
set mouse=v

" On pressing tab, insert 4 spaces
set expandtab

" Toggle nerd tree
map <C-n> :NERDTreeToggle<CR>

" search file recursively in current path
set path+=**

" tell it to use an undo file
set undofile
" set a directory to store the undo history
set undodir=/home/lhuang/.vim/undo/

" open/close taglist plugin
nnoremap <silent> <F8> :TlistToggle<CR>
let Tlist_Auto_Open = 0
let Tlist_Exit_OnlyWindow = 1
" exit if taglist is last window open 
let Tlist_Show_One_File = 1 
" Only show tags for current buffer 
let Tlist_Use_Right_Window = 0 
" Open on right side 
let Tlist_Enable_Fold_Column = 0

" Quick write session with F2
map <F2> :mksession! ~/.vim_session <cr>

" And load session with F3
map <F3> :source ~/.vim_session <cr>     

" adjust window to 80% of terminal vertical and horizantal direction
nnoremap <F12> :exec 'resize ' . string(&lines *  0.80) <CR> <bar> :exec 'vertical resize ' . string(&columns *  0.80) <CR>

function! MyHello()
    :ls
endfunction

nnoremap <F9> :call MyHello()<CR>

augroup autocom
    autocmd!
    "executes the command on quit
    autocmd VimLeave * :mksession! ~/.vim_session
    "on startup
    "autocmd VimEnter * :source ~/.vim_session

    "execute the command on write
    " autocmd BufWritePost,FileWritePost *.cpp !your_commad
    "autocmd BufEnter * :exec 'resize ' . string(&lines *  0.80) <CR> | :exec 'vertical resize ' . string(&columns *  0.80) <CR>
augroup END

" map ctrl+j and k to move to next/previous buffer
nnoremap <C-j> :bn<Enter>
nnoremap <C-k> :bp<Enter>

" -------------------- markdown starts here

" markdown plugin
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'zxqfl/tabnine-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

au Filetype html,xml,xsl source ~/.vim/plugin/closetag.vim
