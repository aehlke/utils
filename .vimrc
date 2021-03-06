"
" Basic/common settings
"

" Vim is better
set nocompatible
 
" Colorization/display
 
" Syntax highlighting!
syntax on
if &term=="builtin_gui"
    set t_Co=256
    colorscheme wombat256
    " Colorize for a dark background
    set background=dark
endif
" Show ruler line at bottom of each buffer
set ruler
" Show additional info in the command line (very last line on screen) where
" appropriate.
set showcmd
" Always display status lines/rulers
"set laststatus=2
" no extra status lines
set laststatus=0
" display more information in the ruler
set rulerformat=%40(%=%t%h%m%r%w%<\ (%n)\ %4.7l,%-7.(%c%V%)\ %P%)
" current mode in status line
set showmode
" don't redraw the screen during macros etc (NetHack's runmode:teleport)
set lazyredraw
" threshold for reporting number of lines changed
set report=0
"}}}
" Make vim less whiny {{{
" :bn with a change in the current buffer? no prob!
set hidden
" no bells whatsoever
set vb t_vb=
" send more data to the terminal in a way that makes the screen update faster
set ttyfast
" < and > will hit indentation levels instead of always -4/+4
set shiftround
 
" a - terse messages (like [+] instead of [Modified]
" o - don't show both reading and writing messages if both occur at once
" t - truncate file names
" T - truncate messages rather than prompting to press enter
" W - don't show [w] when writing
" I - no intro message when starting vim fileless
set shortmess=aotTWI

" Highlight word under cursor
"highlight flicker gui=bold guifg=white
"au CursorMoved <buffer> exe 'match flicker /\V\<'.escape(expand('<cword>'), '/').'\>/'



" Navigation/search
 
" Show matching brackets/parentheses when navigating around
set showmatch
" Show matching parens in 2/10 of a second. No idea why I wanted this.
set matchtime=2
" Search incrementally instead of waiting for me to hit Enter
set incsearch
" Search case-insensitively
set ignorecase
" But be smart about it -- if I have any caps in my term, be case-sensitive.
set smartcase
" Don't highlight search terms by default.
"set nohls
set hlsearch
" don't move the cursor to the start of the line when changing buffers
set nostartofline




" Formatting
 
" Automatically indent based on current filetype
set autoindent
" Don't unindent when I press Enter on an indented line
set preserveindent
" 'smartindent', however, screws up Python -- so turn it off
set nosmartindent
" Make tabbing/deleting honor 'shiftwidth' as well as 'softtab' and 'tabstop'
set smarttab
" Use spaces for tabs
set expandtab
" When wrapping/formatting, break at 79 characters.
set textwidth=79
" By default, all indent/tab stuff is 4 spaces, as God intended.
set tabstop=4
set softtabstop=4
set shiftwidth=4
" Default autoformatting options:
" t: automatically hard-wrap based on textwidth
" c: do the same for comments, but autoinsert comment character too
" r: also autoinsert comment character when making new lines after existing
" comment lines
" o: ditto but for o/O in normal mode
" q: Allow 'gq' to autowrap/autoformat comments as well as normal text
" n: Recognize numbered lists when autoformatting (don't explicitly need this,
" was probably in a default setup somewhere.)
" 2: Use 2nd line of a paragraph for the overall indentation level when
" autoformatting. Good for e.g. bulleted lists or other formats where first
" line in a paragraph may have a different indent than the rest.
set formatoptions=tcroqn2
" Try to break on specific characters instead of the very last character that
" might otherwise fit. Don't remember exactly why this is here but I'm happy
" with how things wrap now...
set lbr
" < and > will hit indentation levels instead of always -4/+4
set shiftround




" Behavior

" <Leader> key
let mapleader = "," 

" Allow folding to play nice with Python and other well-indented code
set foldmethod=indent
" Don't close all folds by default when file opens
set nofoldenable
" "/bin/bash -l -c <command>" for :sh and :!
" (so it sources my .bashrc and so forth)
set shellcmdflag=-c
set shell=bash\ -l
" Honor Vim modelines at top/bottom of files
set modeline
" Look 5 lines in for modelines (default is sometimes just 1 or 2 which may not
" be enough for some files)
set modelines=5
" When splitting, put new windows to the right (vertical) or below (horizontal)
set splitright splitbelow
" Start scrolling up/down when cursor gets to 3 lines away from window edge
set scrolloff=3
" Don't use 'more' for shell output automatically.
set nomore
" Use bash-like tab completion in Vim command line
set wildmenu
set wildmode=list:longest
" Allow backspaces to eat indents, end-of-line/beginning-of-line characters
set backspace=indent,eol,start
" Let me open a shitton of tabs at once if I really want.
set tabpagemax=100
" Make :sb let me navigate between all windows and tabs
set switchbuf=usetab
" only show a menu for completion, never a preview window or things like that
set completeopt=menuone
" remember lotsa fun stuff
set viminfo=!,'1000,f1,/1000,:1000,<1000,@1000,h,n~/.viminfo
" if you :q with changes it asks you if you want to continue or not
set confirm
" 50 milliseconds for escape timeout instead of 1000
set ttimeoutlen=100
" show commands as I type them
set sc


" Jump to last known location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif
 
" Filetype based indent rules
if has("autocmd")
  filetype indent plugin on
endif



" Folding {{{
" fold only when I ask for it damnit!
set foldmethod=marker
 
" close a fold when I leave it
set foldclose=all
 
 


"
" Settings for specific versions of Vim
"
 
" MacVim
if has("gui_macvim")
"    set transparency=5
    "set guifont=Inconsolata:h14
    set lines=60
    set formatoptions-=t
    set formatoptions-=c
endif
 
 
"
" Settings for specific filetypes
"
 
" Ruby
"autocmd FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2 foldmethod=syntax
 
" Markdown
autocmd FileType mkd setlocal ai comments=n:>
 
" ReST
autocmd BufRead *.rst setlocal filetype=rest
autocmd FileType rest setlocal ai comments=n:>
 
" YAML
autocmd FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2
 
" No more need to drop modelines into common Apache files
" (both Debian and RedHat style Apache conf dirs)
"autocmd BufRead /etc/apache2/*,/etc/httpd/* setlocal filetype=apache
 
 
"
" Key mappings
"
 
" Up/down go visually instead of by physical lines (useful for long wraps)
" Interactive ones need to check whether we're in the autocomplete popup (which
" breaks if we remap to gk/gj)
"TODO see SO, theres a better way to do this IIRC
map <up> gk
inoremap <up> <C-R>=pumvisible() ? "\<lt>up>" : "\<lt>C-o>gk"<Enter>
map <down> gj
inoremap <down> <C-R>=pumvisible() ? "\<lt>down>" : "\<lt>C-o>gj"<Enter>
 
 
" Insert-mode remappings/abbreviations {{{
" Hit <C-a> in insert mode after a bad paste (thanks absolon) {{{
inoremap <silent> <C-a> <ESC>u:set paste<CR>.:set nopaste<CR>gi
"ignore indent mode for shift-backspace
inoremap <S-BS> <Esc>xa


" Normal-mode remappings {{{
nore ; :
nore \ ;
" spacebar (in command mode) inserts a single character before the cursor
nmap <Space> i <Esc>r
" Custom mapping shortcut for :nohl
nmap <C-N> :noh<CR>
" Map normal mode Enter to add a new line.
" Useful for adding spacing to a file while navigating.
nmap <Enter> o<Esc>
" have Y behave analogously to D rather than to dd
nmap Y y$
" miscellaneous commands I use a lot, so deserve quick shortcuts
nmap \/ :nohl<CR>
" now search commands will re-center the screen
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz
"w (move forward by word) should have W as its opposite
nmap W b
" shift + right and left switch buffers
nmap <S-Right> :bn<CR>
nmap <S-Left> :bp<CR>


" make help easier to navigate
autocmd FileType help nnoremap <buffer> <CR> <C-]>
autocmd FileType help nnoremap <buffer> <BS> <C-T>




" Plugins
"
" Plugin mappings

" FuzzyFinder
"map <leader>t :FuzzyFinderTextMate<CR>
cd ~/workspace/manabi
nmap <leader>F :FufFile<CR>
nmap <leader>t :FufFileRecursive<CR>
nmap <leader>f :FufFileWithCurrentBufferDir<CR>
nmap <leader>d :FufDir<CR>
nmap <leader>b :FufBuffer<CR>
let g:fuf_dir_exclude = '\v(^|[/\\])\.(hg|git|bzr)($|[/\\])'
let g:fuf_mrufile_exclude = '\v\~$|\.(bak|sw[mnop])$|^(\/\/|\\\\|\/mnt\/|\/media\/)'
" Ignore the dojango directory since it's huge and spammy
let g:fuf_file_exclude = '\v\~$|dojango|\.(o|exe|dll|bak|sw[mnop]|zip|pyc|DS_Store|tar\.gz)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'

" Plugin settings
let g:autoclose_on = 0




"
" netrw (builtin file-browser plugin) preferences
"
 
" Default to tree view
"let g:netrw_liststyle = 3
" Hide common hidden files
"let g:netrw_list_hide = '.*\.py[co]$,\.git$,\.swp$'
" Don't use frickin elinks, wtf
"let g:netrw_http_cmd = "wget -q -O" " or 'curl -Ls -o'
 
 
"
" Custom "snippets"/shortcuts
"
 
" ReST header shortcuts: create or resize header formatting under/around
" current line.
 
"function! NextLineIsOnly(char)
"    let check_char = a:char
"    if check_char == '~'
"        let check_char = '\~'
"    endif
"    return getline(line(".")+1) =~ "^" . check_char . "\\+$"
"endf
 
"function! ReplaceNextLineWith(char)
"    return "yyjVpVr" . a:char
"endf
 
"function! ReplaceSurroundingsWith(char)
"    return ReplaceNextLineWith(a:char) . "yykkVp"
"endf
 
"function! AppendLineOf(char)
"    return "yypVr" . a:char
"endf
 
"function! SurroundWith(char)
"    return AppendLineOf(a:char) . "yykP"
"endf
 
"function! H1()
"    let char = "="
"    if NextLineIsOnly(char)
"        return ReplaceSurroundingsWith(char)
"    else
"        return SurroundWith(char)
"    endif
"endf
 
"function! H(char)
"    if NextLineIsOnly(a:char)
"        return ReplaceNextLineWith(a:char)
"    else
"        return AppendLineOf(a:char)
"    endif
"endf
 
"nnoremap <expr> <F1> H1()
"nnoremap <expr> <F2> H("=")
"nnoremap <expr> <F3> H("-")
"nnoremap <expr> <F4> H("~")
 
 
" Git helper: take up to full length SHA1 under cursor and truncate to 7
" characters; plus a Redmine specific version to tack on "commit:"
 
"function! TruncateToSevenChars()
"    " Use viwo instead of b so it works even when cursor is on 1st char of word
"    return "viwo7ld"
"endf
 
"function! FormatShaForCommit()
"    return TruncateToSevenChars() . "bicommit:\<Esc>w"
"endf
 
"nnoremap <expr> <F7> FormatShaForCommit()






"""""""""""""""""""old
"filetype plugin indent on

"set nowrap
"set ts=4
"set ai
"set shiftwidth=4
"set expandtab
"set wildmode=longest,list
"set hlsearch
"set incsearch
"set ignorecase
"set smartcase
"set scrolloff=2

"Set color scheme
"colorscheme wombat256
"syntax enable

"disable cursor blink
set gcr=a:blinkon0


"Quick write session with F2
map <F2> :mksession! ~/.vim_session <cr>
"And load session with F3
map <F3> :source ~/.vim_session <cr>


"supertab
" <C-x><C-n> local keyword completion
" <C-x><C-o> omnicompletion
let g:SuperTabDefaultCompletionType = '<c-n>'
""context"
let g:SuperTabContextDefaultCompletionType = '<C-x><C-n>'
" let g:SuperTabRetainCompletionDuration = 'completion'

" make backspaces more powerful
"set backspace=indent,eol,start

"from vim-config-python-ide

" For full syntax highlighting:
"syntax on

"python syntax highlighting
let python_highlight_builtins = 1
let python_highlight_exceptions = 1
let python_highlight_string_formatting = 1
let python_highlight_string_format = 1
let python_highlight_string_templates = 1
let python_highlight_indent_errors = 1
let python_highlight_doctests = 1
let python_slow_sync = 1

" Set the default file encoding to UTF-8:
set encoding=utf-8

set completeopt=longest,menuone

set ofu=syntaxcomplete#Complete
"autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS


