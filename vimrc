" set this first (avoid use of -N for vi compatibility)
set nocompatible

" tip, write file and fire command into a Tmux window
" :map ,t :w\|:Tmux xcodebuild -scheme videosnap build && /u/code/videosnap/build/products/Debug/videosnap -v<cr>
" :map ,t :w\|:call SendToTmux("ruby ".expand('%')."\n")<cr>

" plugins via Plug - https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/tpope/vim-cucumber.git'
Plug 'https://github.com/tpope/vim-bundler.git'
Plug 'https://github.com/tpope/vim-haml.git'
Plug 'https://github.com/tpope/vim-rails.git'
Plug 'https://github.com/tpope/vim-markdown.git'
Plug 'https://github.com/kien/ctrlp.vim.git'
Plug 'https://github.com/jgdavey/vim-turbux.git'
Plug 'https://github.com/jgdavey/tslime.vim.git'
Plug 'https://github.com/christoomey/vim-tmux-navigator.git'
Plug 'https://github.com/kchmck/vim-coffee-script.git'
Plug 'https://github.com/godlygeek/tabular.git'
Plug 'https://github.com/mattn/gist-vim.git'
Plug 'https://github.com/mattn/webapi-vim.git'
Plug 'https://github.com/szw/vim-g'
Plug 'https://github.com/rking/ag.vim.git'
Plug 'https://github.com/SirVer/ultisnips.git'
Plug 'https://github.com/honza/vim-snippets.git'

call plug#end()

" load matchit (use % to jump)
runtime macros/matchit.vim

" use this dictionary for completions (ctrl-x ctrl-k)
:set dictionary=/usr/share/dict/words

" comma for map leader
let mapleader = ","
let g:mapleader = ","

" snippets trigger configuration
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" textwidth and format options
set textwidth=80
set fo-=t
" show line at 80 chars
set colorcolumn=+1

" 256 color scheme
set t_Co=256
if &t_Co >= 256 || has("gui_running")
  colorscheme jellybeans
endif

syntax on                         " turn on syntax highlighting
filetype plugin indent on         " turn on file type detection

set encoding=utf-8                " encoding
set history=10000                 " remember more commands/searches
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
let g:turbux_command_rspec = 'rspec'

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
nmap <leader>c \\\
vmap <leader>c \\\

" do an grep search of the current word in the project
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

"  Opening quick buffers
nnoremap <C-n> :cn<cr>
nnoremap <C-p> :cp<cr>

" F3 alphabetize sorts inner css
nmap <F3> :g#\({\n\)\@<=#.,/}/sort<CR>

" F5 formats and tidy up
map <silent> <F5> mmgg=G'm
imap <silent> <F5> <Esc> mmgg=G'm

" F7 spell checks
map <F7> :setlocal spell! spelllang=en<CR>

" convert hashes to new style
map <leader>ch :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<CR>

" format paragraph including set textwidth
nnoremap <leader>q gqip

" git-stripspace the current buffer
map <Leader>s :%!git stripspace<CR>

" other shortcuts
map <leader>w :w!<cr>
map <leader>v :sp ~/.vimrc<cr>
map <leader>u :source ~/.vimrc<cr>
map <leader>e :Explore<cr>
map <leader>ev :new <C-R>=expand("%:p:h") . '/'<cr><cr>
map <leader>m :! mate %<cr>

" ctrl-a clears highlighted searches
nnoremap <silent> <C-a> :nohl<CR><C-a>

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

" perform Google search for word(s)
map <leader>? :G<cr>

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
" nnoremap <Left>  <nop>
" nnoremap <Right> <nop>

" custom syntax highlighting
au BufRead,BufNewFile *.as   set ft=actionscript
au BufRead,BufNewFile *.mxml set ft=mxml
au BufNewFile,BufRead *.json set ft=javascript
au BufNewFile,BufRead *.god  set ft=ruby
au BufNewFile,BufRead /private/etc/apache2/*.conf* set ft=apache
au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,bluepill.pill,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby

" auto strip whitespace when saving
autocmd BufWritePre * :%s/\s\+$//e

" auto spell check & limit width of git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72

" always spellcheck on text like files
autocmd BufRead,BufNewFile {*.md,*.txt,*.textile} setlocal spell

" allow spell check auto complete C-N (insert mode)
set complete+=kspell

" copy and paste with pbcopy/pbpaste in visual mode
vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
nmap <C-V> :call setreg("\"",system("pbpaste"))<CR>p

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
