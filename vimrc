" set this first (avoid use of -N for vi compatibility)
set nocompatible

" change the leader
let mapleader=","
let g:mapleader=","


" #### Requirements
" ensure to brew install ctags-exuberant (http://tinyurl.com/3lcrsrh)


" #### Plugins (https://github.com/junegunn/vim-plug)

call plug#begin('~/.vim/plugged')
  " core
  Plug 'rking/ag.vim'
  Plug 'kien/ctrlp.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-bundler'
  Plug 'tpope/vim-rails'
  Plug 'itchyny/lightline.vim'

  " extras
  Plug 'godlygeek/tabular'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'mattn/gist-vim'
  Plug 'mattn/webapi-vim'
  Plug 'jgdavey/vim-turbux'
  Plug 'christoomey/vim-tmux-navigator'

  " syntax
  Plug 'tpope/vim-markdown', { 'for': 'markdown' }
  Plug 'tpope/vim-cucumber', { 'for': 'cucumber' }
  Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
call plug#end()




" #### Shortcuts

" mapping fixes
map <Esc>[Z <S-Tab>
map <Esc>[24~ <F12>

map <leader>w :w!<cr>
map <leader>v :sp ~/.vimrc<cr>
map <leader>u :source ~/.vimrc<cr>
map <leader>e :new <C-R>=expand("%:p:h")<cr><cr>
map <leader>m :! mate %<cr>
map <leader>rn :w ! %<cr>

" use :w!! to save with sudo
cmap w!! w !sudo tee % >/dev/null

" grep project folder for word
nnoremap K :grep! "\b<C-R><C-W>\b"<cr>:cw<cr>
" move through results
nnoremap <C-n> :cn<cr>
nnoremap <C-p> :cp<cr>
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<cr>
" re-open previous edited file
nnoremap <leader><leader> :e#<cr>
" format paragraphs to textwidth
nnoremap <leader>q gqip

" buffers
nmap <Tab> :bp<cr>
nmap <S-Tab> :bn<cr>
nmap <leader>d :bd<cr>
nmap <leader>D :bufdo bd<cr>

" function keys
map <F1> :sp ~/Dropbox/system/vim_notes<cr>
map <F2> :sp ~/Dropbox/system/todos<cr>
map <F3> :sp ~/Dropbox/system/secrets<cr>
map <F4> :sp ~/Dropbox/system/notes<cr>
" F5 formats and tidy up
noremap <F5> mmgg=G'm
inoremap <silent> <F5> <Esc> mmgg=G'mi
" alphabetize sorts inner css
nmap <F6> :g#\({\n\)\@<=#.,/}/sort<cr>
" F7 spell checks
map <F7> :setlocal spell! spelllang=en<cr>

" ruby/rails shortcuts
map <leader>ch :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<cr>
map <leader>rs :<C-U>!bundle exec rspec <c-r>=expand("%:p") <cr> -c -l <c-r>=line(".") <cr><cr>

" turn OFF evil arrow keys
nnoremap <Up>    <nop>
nnoremap <Down>  <nop>
nnoremap <Left>  <nop>
nnoremap <Right> <nop>




" #### Editor

" load matchit (use % to jump)
filetype plugin indent on
runtime macros/matchit.vim

" appearance
set t_Co=256                      " 256 color scheme
syntax on                         " turn on syntax highlighting
colorscheme jellybeans
set textwidth=80                  " set textwidth
set fo-=t
set colorcolumn=+1                " show vertical break at textwidth
set cursorline                    " highlight the current line
set number                        " show line numbers
set ruler                         " show cursor position
set title                         " set the terminal's title
set visualbell                    " visual flash
set noerrorbells                  " no beeping please
set laststatus=2                  " always show a status bar

" speedy scrolling
syntax sync minlines=100
set nocursorcolumn
set norelativenumber
set ttyfast
set ttyscroll=3
set lazyredraw
set regexpengine=1                " issue with ruby syntax highlighting (use older RE engine)

" general
set encoding=utf-8
set history=200                       " remember all the things
set backspace=indent,eol,start        " intuitive backspacing
set hidden                            " handle multiple buffers better
set wildmode=list:longest             " complete files like a shell
set splitbelow                        " open vertical splits below
set splitright                        " open horizontal splits on the right
set cm=blowfish2                      " encryption mode (http://tuxdiary.com/2015/01/13/encrypt-files-with-vim/)
set complete+=kspell                  " spell check auto complete (C-N in i-mode)
set dictionary=/usr/share/dict/words  " use this for completions (ctrl-x ctrl-k)
"set clipboard=unnamed                 " all c&p operations on OS clipboard

" searching
set ignorecase                    " case-insensitive searching
set smartcase                     " but case-sensitive if expression contains a capital letter
set showmatch
set incsearch                     " highlight matches as you type
set hlsearch                      " highlight matches

" use Ag instead of grep (the silver searcher)
set grepprg=ag\ --nogroup\ --nocolor\ --hidden

" scrolling
set nowrap                        " turn on line wrapping
set scrolloff=3                   " show 3 lines of context around the cursor
set sidescroll=1                  " scroll horizontally without jumping http://tinyurl.com/zs3ntow

" backups
set backup                        " save backups
set backupdir=$HOME/.vim/tmp      " keep backup files in one location
set noswapfile                    " don't use swp files

" indenting, tabs and folds
set autoindent                    " autoindent on
set copyindent                    " copy the previous indentation on autoindenting
set smartindent
set softtabstop=2                 " soft tabs, ie. number of spaces for tab
set tabstop=2                     " global tab width
set shiftwidth=2                  " and again, related
set expandtab                     " use spaces instead of tabs
set smarttab                      " insert tabs on the start of a line according to shiftwidth, not
set shiftround                    " use multiple of shiftwidth when indenting with '<' and '>'
set foldmethod=syntax
set foldcolumn=4
set nofoldenable




" #### Plugin Shortcuts

" start a global search
map <C-F> :Ag --hidden<space>

" opens CtrlP buffer
map <leader>b :CtrlPBuffer<cr>

" tabularize
nmap <leader>a> :Tabularize /=><cr>
vmap <leader>a> :Tabularize /=><cr>
nmap <leader>a= :Tabularize /=<cr>
vmap <leader>a= :Tabularize /=<cr>
nmap <leader>a: :Tabularize /:\zs<cr>
vmap <leader>a: :Tabularize /:\zs<cr>

" commentary
nmap <leader>c gcc
vmap <leader>c gc

" save and run in Tmux
map <leader>rr :w\|:call SendToTmux("\"".expand('%:p%h')."\"\n")<cr>

" ulti-snips
map <leader>U :UltiSnipsEdit<cr>

" fugitive
map <leader>gg :Gpull<cr>
map <leader>gc :Gcommit<space>
map <leader>gp :Gpush<cr>
map <leader>gs :Gstatus<cr>
map <leader>gb :Gblame<cr>
map <leader>gd :Gdiff<cr>
map <leader>ge :Gedit<cr>
map <leader>gl :Glog -250<cr><cr>:copen<cr><cr>
map <leader>gL :Glog -250 --<cr><cr>:copen<cr><cr>





" #### Plugin Settings

" ag
let g:ag_working_path_mode="r"

" gist-vim
let g:gist_open_browser_after_post = 1
let g:gist_detect_filetype = 1

" turbux
let g:turbux_command_prefix = 'bundle exec'
let g:turbux_command_rspec = 'zeus rspec'

" ctrlp
let g:ctrlp_max_height = 10      " window height
let g:ctrlp_follow_symlinks = 1  " do follow symlinks
let g:ctrlp_lazy_update = 1      " update after 250ms

" lightline
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'fugitive', 'filename' ] ]
  \ },
  \ 'component_function': {
  \   'fugitive': 'LightLineFugitive',
  \   'readonly': 'LightLineReadonly',
  \   'modified': 'LightLineModified',
  \   'filename': 'LightLineFilename'
  \ },
  \ 'separator': { 'left': '⮀', 'right': '⮂' },
  \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
\ }


" snippets trigger configuration
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-u>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
let g:UltiSnipsSnippetDirectories=["UltiSnips"]




" #### Vim Functions

" helper to exec a macro on multiple (visually sel) lines
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<cr>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" lightline bar components
function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "⭤"
  else
    return ""
  endif
endfunction

function! LightLineFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? '⭠ '._ : ''
  endif
  return ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

" rename a file
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>n :call RenameFile()<cr>

" open a split for each dirty file in git
function! OpenChangedFiles()
  only " close windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "sp " . filename
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()




" #### FileType settings

au BufRead,BufNewFile *.as   set ft=actionscript
au BufRead,BufNewFile *.mxml set ft=mxml
au BufNewFile,BufRead *.json set ft=javascript
au BufNewFile,BufRead *.god  set ft=ruby
au BufNewFile,BufRead {*.md,*.markdown} set ft=markdown
au BufNewFile,BufRead /private/etc/apache2/*.conf* set ft=apache
au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,bluepill.pill,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby

" always spellcheck on text like files
autocmd BufRead,BufNewFile {*.md,*.txt,*.textile,*.markdown,*.rdoc} setlocal spell
" auto strip whitespace when saving
autocmd BufWritePre * :%s/\s\+$//e
" auto spell check & limit width of git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72




" #### Ignores

set wildignore+=*.o,*.obj,*/.hg/*,*/.svn/*,*.so,*/.git
set wildignore+=**/vendor/rails/**,**/vendor/bundle/**,**/tmp/**
