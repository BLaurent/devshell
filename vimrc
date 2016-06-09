""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Get out of VI's compatible mode..
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'taglist.vim'
"Plugin 'minibufexpl.vim'
Plugin 'vimbuddy.vim'
Plugin 'hrp/EnhancedCommentify'
Plugin 'DeleteTrailingWhitespace'
Plugin 'YankRing.vim'
Plugin 'vim-scripts/hgrev'
Plugin 'vim-scripts/vim-less'
Plugin 'davidhalter/jedi-vim'
Plugin 'tmhedberg/SimpylFold'
"Plugin 'tpope/vim-classpath'
Plugin 'heartsentwined/vim-emblem'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kelan/gyp.vim'
Plugin 'vim-scripts/jade.vim'
Plugin 'marijnh/tern_for_vim'
Plugin 'majutsushi/tagbar'
Plugin 'ludovicchabant/vim-lawrencium'
Plugin 'pangloss/vim-javascript'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'moll/vim-node'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'fatih/vim-go'
Plugin 'dcharbon/vim-flatbuffers'
Plugin 'evanmiller/nginx-vim-syntax'
Plugin 'cstrahan/vim-capnp'

call vundle#end()            " required
filetype plugin indent on    " required

set shell=zsh

"Sets how many lines of history VIM har to remember
set history=400

"Enable filetype plugin
filetype plugin indent on

"Set to auto read when a file is changed from the outside
set autoread

"Have the mouse enabled all the time:
"set mouse=a

set clipboard=unnamed

"Set mapleader
let mapleader = ","
let g:mapleader = ","

"Fast saving
nmap <leader>w :w!<cr>
nmap <leader>f :find<cr>

"Fast reloading of the .vimrc
map <leader>s :source ~/.vimrc<cr>
"Fast editing of .vimrc
map <leader>e :e! ~/.vimrc<cr>
"When .vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable syntax hl
syntax enable

if has("gui_running")
  set guioptions-=T
"  set guioptions-=m  "remove menu bar
  set guioptions-=r  "remove right-hand scroll bar
  let psc_style='cool'
  colorscheme Monokai-Refined
else
  colorscheme inkpot
  set background=dark
  set t_Co=256
endif

"Some nice mapping to switch syntax (useful if one mixes different languages in one file)
map <leader>1 :set syntax=cheetah<cr>
map <leader>2 :set syntax=xhtml<cr>
map <leader>3 :set syntax=python<cr>
map <leader>4 :set ft=javascript<cr>
map <leader>$ :syntax sync fromstart<cr>

autocmd BufEnter * :syntax sync fromstart

"Highlight current
if has("gui_running")
  set cursorline
  hi cursorline guibg=#333333
  hi CursorColumn guibg=#333333
endif


"Omni menu colors
hi Pmenu guibg=#333333
hi PmenuSel guibg=#555555 guifg=#ffffff

"font
set guifont=Source\ Code\ Pro\ for\ Powerline:h12

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fileformats
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Favorite filetypes
set ffs=unix,dos,mac

nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
set so=7

"Turn on WiLd menu
set wildmenu
"set wildmode=list:longest,full

"Always show current position
set ruler

"The commandbar is 2 high
set cmdheight=2

"Show line number
set nu

"Do not redraw, when running macros.. lazyredraw
set lz

"Change buffer - without saving
set hid

"Set backspace
set backspace=eol,start,indent

"Bbackspace and cursor keys wrap to
set whichwrap+=<,>,h,l

"Ignore case when searching
set ignorecase
set incsearch

"Set magic on
set magic

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

"show matching bracets
set showmatch

"How many tenths of a second to blink
set mat=2

"Highlight search things
set hlsearch

""""""""""""""""""""""""""""""
" Statusline
""""""""""""""""""""""""""""""
"Always hide the statusline
set laststatus=2

function! CurDir()

   let curdir = substitute(getcwd(), '/home/laurebe/', "~/", "g")
   return curdir
endfunction

"Format the statusline

function! TagStatus()
	if bufname('%') == ''
		return ""
	else
		if exists('loaded_taglist')
			return Tlist_Get_Tagname_By_Line()
		else
			return ""
		endif
	endif
endfunction

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

""""""""""""""""""""""""""""""
" Visual
""""""""""""""""""""""""""""""
" From an idea by Michael Naumann
function! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"
  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  else
    execute "normal /" . l:pattern . "^M"
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

"Basically you press * or # to search for the current selection !! Really useful
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moving around and tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Map space to / and c-space to ?
map <space> /
map <c-space> ?

"Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"Actually, the tab does not switch buffers, but my arrows
"Bclose function ca be found in "Buffer related" section
map <leader>bd :Bclose<cr>

"Tab configuration
map <leader>tn :tabnew %<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
try
  set switchbuf=usetab
  set stal=2
catch
endtry

"Moving fast to front, back and 2 sides ;)
imap <m-$> <esc>$a
imap <m-0> <esc>0i
imap <D-$> <esc>$a
imap <D-0> <esc>0i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Autocommands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Switch to current dir
map <leader>cd :cd %:p:h<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
")
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $w <esc>`>a"<esc>`<i"<esc>

"Map auto complete of (, ", ', [
inoremap $1 ()<esc>:let leavechar=")"<cr>i
inoremap $2 []<esc>:let leavechar="]"<cr>i
inoremap $4 {<esc>o}<esc>:let leavechar="}"<cr>O
inoremap $3 {}<esc>:let leavechar="}"<cr>i
inoremap $q ''<esc>:let leavechar="'"<cr>i
inoremap $w ""<esc>:let leavechar='"'<cr>i
au BufNewFile,BufRead *.\(vim\)\@! inoremap " ""<esc>:let leavechar='"'<cr>i
au BufNewFile,BufRead *.\(txt\)\@! inoremap ' ''<esc>:let leavechar="'"<cr>i

imap <m-l> <esc>:exec "normal f" . leavechar<cr>a
imap <d-l> <esc>:exec "normal f" . leavechar<cr>a


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"My information
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
iab xname Benoit Laurent


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing mappings etc.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^

"Move a line of text using control
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command-line config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! Cwd()
  let cwd = getcwd()
  return "e " . cwd
endfunc

func! DeleteTillSlash()
  let g:cmd = getcmdline()
  if MySys() == "linux" || MySys() == "mac"
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  else
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
  endif
  if g:cmd == g:cmd_edited
    if MySys() == "linux" || MySys() == "mac"
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
    else
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
    endif
  endif
  return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc

"Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./

cno $q <C-\>eDeleteTillSlash()<cr>

cno $c e <C-\>eCurrentFileDir("e")<cr>

cno $tc <C-\>eCurrentFileDir("tabnew")<cr>
cno $th tabnew ~/
cno $td tabnew ~/Desktop/

"Bash like
cnoremap <C-A>    <Home>
cnoremap <C-E>    <End>
cnoremap <C-K>    <C-U>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffer realted
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Fast open a buffer by search for a name
map <c-q> :sb

"Open a dummy buffer for paste
map <leader>q :e ~/buffer<cr>

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" Buffer - reverse everything ... :)
map <F9> ggVGg?

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()

function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn backup off
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable folding, I find it very useful
set nofen
set fdl=0
set foldmethod=indent

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=2
"set encoding=utf-8
map <leader>t2 :set shiftwidth=2<cr>
map <leader>t4 :set shiftwidth=4<cr>
au FileType html,python,vim,javascript setl shiftwidth=2
au FileType html,python,vim,javascript setl tabstop=2
au FileType java setl shiftwidth=4
au FileType java setl tabstop=4
let g:DeleteTrailingWhitespace= 1
let g:DeleteTrailingWhitespace_Action = 'delete'


set smarttab
set lbr
set tw=500

   """"""""""""""""""""""""""""""
   " Indent
   """"""""""""""""""""""""""""""
   "Auto indent
   set ai

   "Smart indet
   set si

   "C-style indeting
   set cindent

   "Wrap lines
   set wrap


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   """"""""""""""""""""""""""""""
   " Vim Grep
   """"""""""""""""""""""""""""""
   let Grep_Skip_Dirs = 'RCS CVS SCCS .svn'
   let Grep_Skip_Files = '*.bak *~ tags TAGS'
   let Grep_Cygwin_Find = 1
   let Grep_Default_Options = '-I'

   """"""""""""""""""""""""""""""
   " Yank Ring
   """"""""""""""""""""""""""""""
   map <leader>y :YRShow<cr>

   """"""""""""""""""""""""""""""
   " File explorer
   """"""""""""""""""""""""""""""
   "Split vertically
   let g:explVertical=1

   "Window size
   let g:explWinSize=35

   let g:explSplitLeft=1
   let g:explSplitBelow=1

   "Hide some files
   let g:explHideFiles='^\.,.*\.class$,.*\.swp$,.*\.pyc$,.*\.swo$,\.DS_Store$'

   "Hide the help thing..
   let g:explDetailedHelp=0


   """"""""""""""""""""""""""""""
   " Minibuffer
   """"""""""""""""""""""""""""""
   let g:miniBufExplModSelTarget = 1
   let g:miniBufExplorerMoreThanOne = 2
   "let g:miniBufExplModSelTarget = 0
   let g:miniBufExplUseSingleClick = 1
   let g:miniBufExplMapWindowNavVim = 1
   "let g:miniBufExplVSplit = 25
   "let g:miniBufExplSplitBelow=1


   "autocmd BufRead,BufNew :call UMiniBufExplorer

    """"""""""""""""""""""""""""""
   " Buffer Explorer
   """"""""""""""""""""""""""""""
   let g:bufExplorerSortBy = "name"
   let g:bufExplorerSplitHorzSize=8
   let g:bufExplorerDefaultHelp=0
   let g:bufExplorerShowDirectories=1
   let g:bufExplorerSplitOutPathName=1


   """"""""""""""""""""""""""""""
   " Tag list (ctags)
   """"""""""""""""""""""""""""""
   let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
   let Tlist_Sort_Type = "name"
   let Tlist_Show_Menu = 1
   map <leader>t :TlistToggle<cr>
   set tags=${WORKHOME}/work.${WORKSUFFIX}/tags
"   set tags+=~/.vim/tags/stdlibcpp
"   set tags+=~/.vim/tags/gl
"   set tags+=~/.vim/tags/pb2
"   find `pwd` -type f \( -name "*.[chxSs]" -o -name "*.hpp" \) -print | egrep -v "graph|fusion|python|asio|typeof|spirit|omni|cppUnit|XmHTML" >| ~/.vim/tags/boost-filelist
"   ctags --sort=foldcase --c++-kinds=+p --fields=+iaS --extra=+q -f ~/.vim/tags/boost -L ~/.vim/tags/boost-filelist
"   set tags+=~/.vim/tags/boost
"   set tags+=~/.vim/tags/cppunit
"   set tags+=~/.vim/tags/sdl
"   set tags+=~/.vim/tags/qt4


   """"""""""""""""""""""""""""""
   " OmniCppComplete
   """"""""""""""""""""""""""""""
"   let OmniCpp_MayCompleteDot = 1 " autocomplete with .
"   let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
"   let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
"   let OmniCpp_SelectFirstItem = 1 " select first item (but don't insert)
"   let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included files
"   let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype (i.e. parameters) in popup window
"   let OmniCpp_GlobalScopeSearch = 1
"   let OmniCpp_ShowAccess = 1
"   let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD", "boost"]
   " automatically open and close the popup menu / preview window
"   au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
   set completeopt=menuone,menu,longest
    " Limit popup menu height
   set pumheight=15
"   let g:clang_library_path = "/usr/lib/"
"   let g:clang_use_library=1
"   let g:clang_hl_errors=1
"   let g:clang_complete_copen=1
   let g:ycm_autoclose_preview_window_after_completion=1
"   let g:ycm_path_to_python_interpreter="/usr/local/bin/python"
   let g:ycm_confirm_extra_conf = 0
   """"""""""""""""""""""""""""""
   " LaTeX Suite things
   """"""""""""""""""""""""""""""
   set grepprg=grep\ -nH\ $*
   let g:Tex_DefaultTargetFormat="pdf"
   let g:Tex_ViewRule_pdf='xpdf'

   "Bindings
   autocmd FileType tex map <silent><leader><space> :w!<cr> :silent! call Tex_RunLaTeX()<cr>

   "Auto complete some things ;)
   autocmd FileType tex inoremap $i \indent
   autocmd FileType tex inoremap $* \cdot
   autocmd FileType tex inoremap $i \item
   autocmd FileType tex inoremap $m \[<cr>\]<esc>O


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype generic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

   """"""""""""""""""""""""""""""
   " VIM
   """"""""""""""""""""""""""""""
   autocmd FileType vim map <buffer> <leader><space> :w!<cr>:source %<cr>


   """"""""""""""""""""""""""""""
   " HTML related
   """"""""""""""""""""""""""""""
   " HTML entities - used by xml edit plugin
   let xml_use_xhtml = 1
   "let xml_no_auto_nesting = 1

   "To HTML
   let html_use_css = 1
   let html_number_lines = 0
   let use_xhtml = 1


   """"""""""""""""""""""""""""""
   " Ruby & PHP section
   """"""""""""""""""""""""""""""
   autocmd FileType ruby map <buffer> <leader><space> :w!<cr>:!ruby %<cr>
   autocmd FileType php compiler php
   autocmd FileType php map <buffer> <leader><space> <leader>cd:w<cr>:make %<cr>


   """"""""""""""""""""""""""""""
   " Python section
   """"""""""""""""""""""""""""""
   "Run the current buffer in python - ie. on leader+space
   "au FileType python so ~/.vim/syntax/python.vim
   autocmd FileType python map <buffer> <leader><space> :w!<cr>:!python %<cr>
   autocmd FileType python so ~/.vim/bundle/python_fold/plugin/python_fold.vim

   "Set some bindings up for 'compile' of python
   autocmd FileType python set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
   autocmd FileType python set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

   "Python iMaps
   au FileType python set cindent
   au FileType python inoremap <buffer> $r return
   au FileType python inoremap <buffer> $s self
   au FileType python inoremap <buffer> $c ##<cr>#<space><cr>#<esc>kla
   au FileType python inoremap <buffer> $i import
   au FileType python inoremap <buffer> $p print
   au FileType python inoremap <buffer> $d """<cr>"""<esc>O

   "Run in the Python interpreter
   function! Python_Eval_VSplit() range
     let src = tempname()
     let dst = tempname()
     execute ": " . a:firstline . "," . a:lastline . "w " . src
     execute ":!python " . src . " > " . dst
     execute ":pedit! " . dst
   endfunction
   au FileType python vmap <F7> :call Python_Eval_VSplit()<cr>

   """"""""""""""""""""""""""""""
   " Cheetah section
   """""""""""""""""""""""""""""""
   autocmd FileType cheetah set ft=xml
   autocmd FileType cheetah set syntax=cheetah

   """""""""""""""""""""""""""""""
   " Vim section
   """""""""""""""""""""""""""""""
   autocmd FileType vim set nofen

   """""""""""""""""""""""""""""""
   " Java section
   """""""""""""""""""""""""""""""
   au FileType java inoremap <buffer> <C-t> System.out.println();<esc>hi

   "Java comments
   autocmd FileType java let b:jcommenter_class_author='Benoit Laurent (benoit.laurent@ge.com)'
   autocmd FileType java let b:jcommenter_file_author='Benoit Laurent (benoit.laurent@ge.com)'
   autocmd FileType java map <buffer> <F2> :call JCommentWriter()<cr>

   "Abbr'z
   autocmd FileType java inoremap <buffer> $pr private
   autocmd FileType java inoremap <buffer> $r return
   autocmd FileType java inoremap <buffer> $pu public
   autocmd FileType java inoremap <buffer> $i import
   autocmd FileType java inoremap <buffer> $b boolean
   autocmd FileType java inoremap <buffer> $v void
   autocmd FileType java inoremap <buffer> $s String

   "Folding
   function! JavaFold()
     setl foldmethod=syntax
     setl foldlevelstart=1
     syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend
     syn match foldImports /\(\n\?import.\+;\n\)\+/ transparent fold

     function! FoldText()
       return substitute(getline(v:foldstart), '{.*', '{...}', '')
     endfunction
     setl foldtext=FoldText()
   endfunction
   au FileType java call JavaFold()
   au FileType java setl fen

   au BufEnter *.sablecc,*.scc set ft=sablecc

"   let g:syntastic_java_javac_config_file_enabled = 1
   let g:syntastic_java_javac_classpath = "/usr/java/default/jre/lib:/home_raid1/laurebe/work.VVCloud/java/jar:/home_raid1/laurebe/SharedLibs/java/jar"
   let g:syntastic_javascript_checkers = ['jsl']
   highlight SyntasticWarningSign guifg=white guibg=orange

   """"""""""""""""""""""""""""""
   " JavaScript section
   """""""""""""""""""""""""""""""
   "au FileType javascript so ~/.vim/syntax/javascript.vim
   function! JavaScriptFold()
     setl foldmethod=syntax
     setl foldlevelstart=1
     syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

     function! FoldText()
       return substitute(getline(v:foldstart), '{.*', '{...}', '')
     endfunction
     setl foldtext=FoldText()
   endfunction
   au FileType javascript call JavaScriptFold()
   au FileType javascript setl fen

   au FileType javascript imap <c-t> console.log();<esc>hi
   au FileType javascript imap <c-a> alert();<esc>hi
   au FileType javascript setl nocindent
   au FileType javascript inoremap <buffer> $r return

   au FileType javascript inoremap <buffer> $d //<cr>//<cr>//<esc>ka<space>
   au FileType javascript inoremap <buffer> $c /**<cr><space><cr>**/<esc>ka


   """"""""""""""""""""""""""""""
   " HTML
   """""""""""""""""""""""""""""""
   au FileType html,cheetah set ft=xml
   au FileType html,cheetah set syntax=html


   """"""""""""""""""""""""""""""
   " C mappings
   """""""""""""""""""""""""""""""
   autocmd FileType c map <buffer> <leader><space> :w<cr>:!gcc %<cr>

   """""""""""""""""""""""""""""""
   " SML
   """""""""""""""""""""""""""""""
   autocmd FileType sml map <silent> <buffer> <leader><space> <leader>cd:w<cr>:!sml %<cr>


   """"""""""""""""""""""""""""""
   " Scheme bidings
   """"""""""""""""""""""""""""""
   autocmd BufNewFile,BufRead *.scm map <buffer> <leader><space> <leader>cd:w<cr>:!petite %<cr>
   autocmd BufNewFile,BufRead *.scm inoremap <buffer> <C-t> (pretty-print )<esc>i
   autocmd BufNewFile,BufRead *.scm vnoremap <C-t> <esc>`>a)<esc>`<i(pretty-print <esc>


   """"""""""""""""""""""""""""""
   " CVS section
   """""""""""""""""""""""""""""""
   map <F8> :call CVSSwitchDiffMode()<cr>


""""""""""""""""""""""""""""""
" Snippets
"""""""""""""""""""""""""""""""
   "You can use <c-j> to goto the next <++> - it is pretty smart ;)

   """""""""""""""""""""""""""""""
   " Python
   """""""""""""""""""""""""""""""
   autocmd FileType python inorea <buffer> cfun <c-r>=IMAP_PutTextWithMovement("def <++>(<++>):\n<++>\nreturn <++>")<cr>
   autocmd FileType python inorea <buffer> cclass <c-r>=IMAP_PutTextWithMovement("class <++>:\n<++>")<cr>
   autocmd FileType python inorea <buffer> cfor <c-r>=IMAP_PutTextWithMovement("for <++> in <++>:\n<++>")<cr>
   autocmd FileType python inorea <buffer> cif <c-r>=IMAP_PutTextWithMovement("if <++>:\n<++>")<cr>
   autocmd FileType python inorea <buffer> cifelse <c-r>=IMAP_PutTextWithMovement("if <++>:\n<++>\nelse:\n<++>")<cr>


   """""""""""""""""""""""""""""""
   " JavaScript
   """""""""""""""""""""""""""""""
   autocmd FileType cheetah,html,javascript inorea <buffer> cfun <c-r>=IMAP_PutTextWithMovement("function <++>(<++>) {\n<++>;\nreturn <++>;\n}")<cr>
   autocmd filetype cheetah,html,javascript inorea <buffer> cfor <c-r>=IMAP_PutTextWithMovement("for(<++>; <++>; <++>) {\n<++>;\n}")<cr>
   autocmd FileType cheetah,html,javascript inorea <buffer> cif <c-r>=IMAP_PutTextWithMovement("if(<++>) {\n<++>;\n}")<cr>
   autocmd FileType cheetah,html,javascript inorea <buffer> cifelse <c-r>=IMAP_PutTextWithMovement("if(<++>) {\n<++>;\n}\nelse {\n<++>;\n}")<cr>


   """""""""""""""""""""""""""""""
   " HTML
   """""""""""""""""""""""""""""""
   autocmd FileType cheetah,html inorea <buffer> cahref <c-r>=IMAP_PutTextWithMovement('<a href="<++>"><++></a>')<cr>
   autocmd FileType cheetah,html inorea <buffer> cbold <c-r>=IMAP_PutTextWithMovement('<b><++></b>')<cr>
   autocmd FileType cheetah,html inorea <buffer> cimg <c-r>=IMAP_PutTextWithMovement('<img src="<++>" alt="<++>" />')<cr>
   autocmd FileType cheetah,html inorea <buffer> cpara <c-r>=IMAP_PutTextWithMovement('<p><++></p>')<cr>
   autocmd FileType cheetah,html inorea <buffer> ctag <c-r>=IMAP_PutTextWithMovement('<<++>><++></<++>>')<cr>
   autocmd FileType cheetah,html inorea <buffer> ctag1 <c-r>=IMAP_PutTextWithMovement("<<++>><cr><++><cr></<++>>")<cr>


   """""""""""""""""""""""""""""""
   " Java
   """""""""""""""""""""""""""""""
   autocmd FileType java inorea <buffer> cfun <c-r>=IMAP_PutTextWithMovement("public<++> <++>(<++>) {\n<++>;\nreturn <++>;\n}")<cr>
   autocmd FileType java inorea <buffer> cfunpr <c-r>=IMAP_PutTextWithMovement("private<++> <++>(<++>) {\n<++>;\nreturn <++>;\n}")<cr>
   autocmd FileType java inorea <buffer> cfor <c-r>=IMAP_PutTextWithMovement("for(<++>; <++>; <++>) {\n<++>;\n}")<cr>
   autocmd FileType java inorea <buffer> cif <c-r>=IMAP_PutTextWithMovement("if(<++>) {\n<++>;\n}")<cr>
   autocmd FileType java inorea <buffer> cifelse <c-r>=IMAP_PutTextWithMovement("if(<++>) {\n<++>;\n}\nelse {\n<++>;\n}")<cr>
   autocmd FileType java inorea <buffer> cclass <c-r>=IMAP_PutTextWithMovement("class <++> <++> {\n<++>\n}")<cr>
   autocmd FileType java inorea <buffer> cmain <c-r>=IMAP_PutTextWithMovement("public static void main(String[] argv) {\n<++>\n}")<cr>

  """""""""""""""""""""""""""""""
   " Protocol Buffers
   """""""""""""""""""""""""""""""
   augroup filetype
     au! BufRead,BufNewFile *.proto setfiletype proto
   augroup end

   "Presse c-q insted of space (or other key) to complete the snippet
   imap <C-q> <C-]>

   """""""""""""""""""""""""""""""
   " GoLang
   """""""""""""""""""""""""""""""

   autocmd Filetype go nnoremap <leader>v :vsp <CR>:exe "GoDef" <CR>
   autocmd Filetype go nnoremap <leader>s :sp <CR>:exe "GoDef"<CR>
   autocmd Filetype go nnoremap <leader>t :tab split <CR>:exe "GoDef"<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Cope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"For Cope
map <silent> <leader><cr> :noh<cr>

"Orginal for all
map <leader>n :cn<cr>
map <leader>p :cp<cr>
"map <leader>c :botright cw 10<cr>
map <c-u> <c-l><c-j>:q<cr>:botright cw 10<cr>

if has("cscope")
    set csto=0
    set cst
    set nocsverb
    set cscopetag
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remove the Windows ^M
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"Paste toggle - when pasting something in, don't indent.
set pastetoggle=<F3>

"Remove indenting on empty lines
map <F2> :%s/\s*$//g<cr>:noh<cr>''

"Super paste
inoremap <C-v> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>

"A function that inserts links & anchors on a TOhtml export.
" Notice:
" Syntax used is:
" Link
" Anchor
function! SmartTOHtml()
   TOhtml
   try
    %s/&quot;\s\+\*&gt; \(.\+\)</" <a href="#\1" style="color: cyan">\1<\/a></g
    %s/&quot;\(-\|\s\)\+\*&gt; \(.\+\)</" \&nbsp;\&nbsp; <a href="#\2" style="color: cyan;">\2<\/a></g
    %s/&quot;\s\+=&gt; \(.\+\)</" <a name="\1" style="color: #fff">\1<\/a></g
   catch
   endtry
   exe ":write!"
   exe ":bd"
endfunction
