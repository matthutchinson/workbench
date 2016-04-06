" set this first (avoid use of -N for vi compatibility)
set nocompatible

" tip, write file and fire command into a Tmux window
" :map ,t :w\|:Tmux xcodebuild -scheme videosnap build && /u/code/videosnap/build/products/Debug/videosnap -v<cr>
" :map ,t :w\|:call SendToTmux("ruby ".expand('%')."\n")<cr>
" or just write file, compile and run it (no Tmux)
" :map ,t :w\|:!gcc % -o ./string_reverser; ./string_reverser<CR>

" plugins via Plug - https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

" core
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'rking/ag.vim'

" status bar
Plug 'itchyny/lightline.vim'

" extras
Plug 'godlygeek/tabular'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'szw/vim-g'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/gist-vim'

" tmux
Plug 'jgdavey/vim-turbux'
Plug 'christoomey/vim-tmux-navigator'

" syntax
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'tpope/vim-cucumber', { 'for': 'cucumber' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }

call plug#end()

" load matchit (use % to jump)
runtime macros/matchit.vim

" use this dictionary for completions (ctrl-x ctrl-k)
:set dictionary=/usr/share/dict/words

" comma for map leader
let mapleader=","
let g:mapleader=","

" snippets trigger configuration
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsEditSplit="vertical"

" use DuckDuckGo for searching words with <leader>?
let g:vim_g_query_url="http://duckduckgo.com/?q="
let g:vim_g_command = "DuckDuck"

" git gutter update time and change supression
set updatetime=250 " 4000 is default
let g:gitgutter_map_keys = 0
let g:gitgutter_max_signs = 300 " 500 is default
let g:gitgutter_diff_args = '-w' " ignore whitespace in gutter changes

" textwidth and format options
set textwidth=80
set fo-=t
" show line at 80 chars
set colorcolumn=+1

" color scheme
set t_Co=256
if &t_Co >= 256 || has("gui_running")
  colorscheme jellybeans
endif

" configure lightline statusbar and components
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

syntax on                         " turn on syntax highlighting
filetype plugin indent on         " turn on file type detection

set encoding=utf-8                " encoding
set history=1000                  " remember more commands/searches
set backspace=indent,eol,start    " intuitive backspacing

set hidden                        " handle multiple buffers better
set wildmode=list:longest         " complete files like a shell

set ignorecase                    " case-insensitive searching
set smartcase                     " but case-sensitive if expression contains a capital letter

set cursorline                    " highlight the current line
set number                        " show line numbers
set ruler                         " show cursor position

set showmatch
set incsearch                     " highlight matches as you type
set hlsearch                      " highlight matches

set autoindent                    " always set autoindenting on
set copyindent                    " copy the previous indentation on autoindenting
set smartindent

set nowrap                        " turn on line wrapping
set scrolloff=3                   " show 3 lines of context around the cursor

set title                         " set the terminal's title
set visualbell                    " visual flash
set noerrorbells                  " no beeping please

set backup                        " save backups
set backupdir=$HOME/.vim/tmp      " keep backup files in one location
set noswapfile                    " don't use swp files

set softtabstop=2                 " soft tabs, ie. number of spaces for tab
set tabstop=2                     " global tab width
set shiftwidth=2                  " and again, related
set expandtab                     " use spaces instead of tabs
set smarttab                      " insert tabs on the start of a line according to shiftwidth, not
set shiftround                    " use multiple of shiftwidth when indenting with '<' and '>'
set ttyfast                       " for speed and better rendering
set splitbelow                    " open horizontal splits on the right
set splitright                    " open vertical splits below

" ctags are maintained/refreshed using this technique with git and the fugitive
" and rails plugins from tpope
" http://tbaggery.com/2011/08/08/effortless-ctags-with-git.html

" status line
set laststatus=2
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %=%-16(\ %l,%c-%v\ %)%P
set statusline+=\ %{fugitive#statusline()}

" folding
set foldmethod=syntax
set foldcolumn=4
set nofoldenable

" turbux
let g:turbux_command_prefix = 'bundle exec'
let g:turbux_command_rspec = 'zeus rspec'

" ctrlp
let g:ctrlp_max_height = 20      " window height
let g:ctrlp_follow_symlinks = 1  " do follow symlinks
let g:ctrlp_lazy_update = 1      " update after 250ms

" if we have Ag (the silver searcher)
if executable('ag')
  " use Ag instead of grep (the silver searcher)
  set grepprg=ag\ --nogroup\ --nocolor\ --hidden

  " Ctrl+f opens global search, and browsing
  map <C-F> :Ag --hidden<Space>
endif

" ,b opens CtrlP buffer
map <leader>b :CtrlPBuffer<CR>

" gist-vim
let g:gist_open_browser_after_post = 1
let g:gist_detect_filetype = 1

" zencoding (HTML) expand with <c-y>,
let g:user_zen_settings = { 'erb' : { 'extends' : 'html' }}

" tabularize
if exists(":Tabularize")
  nmap <leader>a> :Tabularize /=><CR>
  vmap <leader>a> :Tabularize /=><CR>
  nmap <leader>a= :Tabularize /=<CR>
  vmap <leader>a= :Tabularize /=<CR>
  nmap <leader>a: :Tabularize /:\zs<CR>
  vmap <leader>a: :Tabularize /:\zs<CR>
endif

" Ctrl+c or ,c toggles commenting
" to comment next 6 lines use 6gcc or 6<leader>c
" see :help commentary for more
nmap <leader>c gcc
vmap <leader>c gc

" do an grep search of the current word in the project
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

"  Opening quick buffers
nnoremap <C-n> :cn<cr>
nnoremap <C-p> :cp<cr>

" re-open previous file
nnoremap <leader><leader> :e#<CR>

" == function keys begin ==
map <Esc>OP <F1>
map <Esc>OQ <F2>
map <Esc>OR <F3>
map <Esc>OS <F4>
map <Esc>[15~ <F5>
map <Esc>[17~ <F6>
map <Esc>[18~ <F7>
map <Esc>[19~ <F8>
map <Esc>[20~ <F9>
map <Esc>[21~ <F10>
map <Esc>[23~ <F11>
map <Esc>[24~ <F12>
" F3 alphabetize sorts inner css
nmap <F3> :g#\({\n\)\@<=#.,/}/sort<CR>
" F5 formats and tidy up
noremap <F5> mmgg=G'm
inoremap <silent> <F5> <Esc> mmgg=G'mi
" F7 spell checks
map <F7> :setlocal spell! spelllang=en<CR>
map <F2> :echo 'Current time is ' . strftime('%c')<CR>
" == function keys end ==

" convert hashes to new style
map <leader>ch :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<CR>

" format paragraph including set textwidth
nnoremap <leader>q gqip

" git-stripspace the current buffer
map <Leader>s :%!git stripspace<CR>

" other shortcuts
map <leader>w :w!<cr>
map <leader>j :sp ~/Dropbox/system/notes<cr>
map <leader>k :sp ~/Dropbox/system/secrets<cr>
map <leader>l :sp ~/Dropbox/system/todos<cr>
map <leader>v :sp ~/.vimrc<cr>
map <leader>u :source ~/.vimrc<cr>
map <leader>e :Explore<cr>
map <leader>ev :new <C-R>=expand("%:p:h") . '/'<cr><cr>
map <leader>m :! mate %<cr>

" Esc clears highlighted searches
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>

" buffers
nmap <Tab> :bp<cr>
nmap <S-Tab> :bn<cr>
nmap <leader>d :bd<cr>
nmap <leader>D :bufdo bd<cr>

" save and run in shell
map <leader>rn :w ! %<CR>

" save and run in Tmux window
map <leader>rr :w\|:call SendToTmux("\"".expand('%:p%h')."\"\n")<cr>

" convert to new ruby hash syntax
map <leader>ch :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<CR>

" perform DuckDuckGo search for word(s)
map <leader>? :DuckDuck<cr>

" rails plugin shortcuts
map <leader>ra :A<CR>
map <leader>fr :.Rake<CR> " focused Rake
map <leader>rf :1R<Space>
map <leader>rg :Rgenerate migration<Space>
map <leader>rm :Rmodel<CR>
map <leader>rv :Rview<CR>
map <leader>rc :Rcontroller<CR>
map <leader>ru :RVunittest<CR>
map <leader>rt :RVfunctionaltest<CR>
map <leader>rs :<C-U>!bundle exec spec <c-r>=expand("%:p") <CR> -c -l <c-r>=line(".") <CR> <CR>
map <leader>sr :<C-U>!bundle exec script/runner %<CR>

" fugitive plugin shortcuts
map <leader>gs :Gstatus<cr>
map <leader>gb :Gblame<cr>
map <leader>gd :Gdiff<cr>
map <leader>gg :Ggrep<Space>
map <leader>ge :Gedit<cr>
map <leader>gl :Glog -250<cr><cr>:copen<cr><cr>
map <leader>gL :Glog -250 --<cr><cr>:copen<cr><cr>
map <leader>gc :Gcommit

" turn OFF arrow keys
nnoremap <Up>    <nop>
nnoremap <Down>  <nop>
nnoremap <Left>  <nop>
nnoremap <Right> <nop>

" custom syntax highlighting
au BufRead,BufNewFile *.as   set ft=actionscript
au BufRead,BufNewFile *.mxml set ft=mxml
au BufNewFile,BufRead *.json set ft=javascript
au BufNewFile,BufRead *.god  set ft=ruby
au BufNewFile,BufRead {*.md,*.markdown} set ft=markdown
au BufNewFile,BufRead /private/etc/apache2/*.conf* set ft=apache
au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,bluepill.pill,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby

" auto strip whitespace when saving
autocmd BufWritePre * :%s/\s\+$//e

" auto spell check & limit width of git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72

" always spellcheck on text like files
autocmd BufRead,BufNewFile {*.md,*.txt,*.textile,*.markdown,*.rdoc} setlocal spell

" set encryption mode (http://tuxdiary.com/2015/01/13/encrypt-files-with-vim/)
set cm=blowfish2

" allow spell check auto complete C-N (insert mode)
set complete+=kspell

" copy and paste with pbcopy/pbpaste in visual mode
vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
nmap <C-x> :call setreg("\"",system("pbpaste"))<CR>p

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

" open a split for each dirty file in git - from garybernhardt
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

" ignores
set wildignore+=*.o,*.obj,*/.hg/*,*/.svn/*,*.so
set wildignore+=**/vendor/rails/**,**/vendor/bundle/**,**/tmp/cache/**,**/public/destinations/**
