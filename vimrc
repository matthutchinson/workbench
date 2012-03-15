" set this first (avoid use of -N for vi compatibility)
set nocompatible

" use pathogen
call pathogen#infect('pathogen')

" load the matchit plugin.
runtime macros/matchit.vim

" user comma for map leader
let mapleader = ","
let g:mapleader = ","

" textwidth and format options
set textwidth=72
set fo-=t

" 256 color scheme
set t_Co=256
if &t_Co >= 256 || has("gui_running")
  set background=dark
  colorscheme ir_black
endif

syntax on                         " turn on syntax highlighting.
filetype plugin indent on         " turn on file type detection.
set encoding=utf-8                " encoding

set showcmd                       " display incomplete commands.
set showmode                      " display the mode you're in.

set backspace=indent,eol,start    " intuitive backspacing.

set hidden                        " handle multiple buffers better.
set wildmode=list:longest         " complete files like a shell.

set ignorecase                    " case-insensitive searching.
set smartcase                     " but case-sensitive if expression contains a capital letter.

set number                        " show line numbers.
set ruler                         " show cursor position.

set incsearch                     " highlight matches as you type.
set hlsearch                      " highlight matches.

set autoindent                    " always set autoindenting on
set copyindent                    " copy the previous indentation on autoindenting

set nowrap                        " turn on line wrapping.
set scrolloff=3                   " show 3 lines of context around the cursor.

set title                         " set the terminal's title
set visualbell                    " no beeping.
set noerrorbells

set backup                        " save backups
set backupdir=$HOME/.vim/tmp      " keep backup files in one location
set noswapfile                    " don't use swp files

set softtabstop=2                 " soft tabs, ie. number of spaces for tab
set tabstop=2                     " global tab width.
set shiftwidth=2                  " and again, related.
set expandtab                     " use spaces instead of tabs
set smarttab                      " insert tabs on the start of a line according to shiftwidth, not
set shiftround                    " use multiple of shiftwidth when indenting with '<' and '>'
set grepprg=ack                   " use Ack instead of grep

"set synmaxcol=72                 " for speed, only syntax highlight the first 72 chars (ruby style guide)
set ttyfast                       " for speed and better rendering

" status line colors
hi User1 ctermbg=black ctermfg=green guibg=black guifg=green
hi User2 ctermbg=black ctermfg=red guibg=black guifg=red
hi User3 ctermbg=black ctermfg=yellow guibg=black  guifg=yellow

" ctags file search order
set tags=./tags;

" status line
set laststatus=2
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %=%-16(\ %l,%c-%v\ %)%P
set statusline+=\ %{fugitive#statusline()}

" folding
set foldmethod=syntax
set foldcolumn=4
set nofoldenable

" custom mappings
" Ctrl+t opens ctrlp.vim
" Ctrl+c or ,c toggles commenting
" Ctrl+f opens grep
" F3 alphabetizes inner css
" F5 formats/tidies
" F7 spell checks
nmap <silent> <C-t> :CtrlP<CR>
nmap <leader>c \\\
vmap <leader>c \\\
map <C-F> :grep<Space>
nmap <F3> :g#\({\n\)\@<=#.,/}/sort<CR>
map <silent> <F5> mmgg=G'm
imap <silent> <F5> <Esc> mmgg=G'm
map <F7> :setlocal spell! spelllang=en<CR>

set wildignore+=*.o,*.obj,**/vendor/apache-ant-1.8.2/**,**/vendor/rails/**,**/vendor/bundle/**,**/tmp/cache/**,**/public/destinations/**
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*.so,tags

" fast saving
nmap <leader>w :w!<cr>

" fast edit and source vimrc
map <leader>v :sp ~/.vimrc<cr>       " opens ~/.vimrc in a split
map <leader>t :sp ~/.tmux.conf<cr>   " opens ~/.tmux.conf in a split
map <leader>u :source ~/.vimrc<cr>   " sources ~/.vimrc
map <leader>e :e <C-R>=expand("%:p:h") . '/'<cr><cr>
map <leader>ev :vnew <C-R>=expand("%:p:h") . '/'<cr><cr>

" fugitive git bindings
map <leader>gs :Gstatus<cr>
map <leader>gb :Gblame<cr>
map <leader>gd :Gdiff<cr>
map <leader>gg :Ggrep<Space>
map <leader>ge :Gedit<cr>
map <leader>gl :Glog -250<cr><cr>:copen<cr><cr>
map <leader>gL :Glog -250 --<cr><cr>:copen<cr><cr>
map <leader>gc :Gcommit

" ruby 
" save and run
map <leader>rn :w ! ruby<CR>
" convert hashes to 1.9 style
map <leader>rh :%s/:\([^ ]*\)\(\s*\)=>/\1:/g<CR>

" rails
map <leader>ra :A<CR>
map <leader>rr :Rake<CR>  " Rake
map <leader>fr :.Rake<CR> " focused Rake
map <leader>rf :1R<Space>
map <leader>rg :Rgenerate migration<Space>
map <leader>rm :Rmodel<CR>
map <leader>rv :Rview<CR>
map <leader>rc :Rcontroller<CR>
map <leader>ru :RVunittest<CR>
map <leader>rt :RVfunctionaltest<CR>
map <leader>rs :<C-U>!bundle exec spec <c-r>=expand("%:p") <CR> -c -l <c-r>=line(".") <CR> <CR>

" buffers
nnoremap <tab> :bn<cr>
nnoremap <S-tab> :bp<cr>
nmap <leader>d :bd<cr>
nmap <leader>D :bufdo bd<cr>

" results
nnoremap <C-k> :cn<cr>
nnoremap <C-j> :cp<cr>

" turn OFF arrow keys altogther
nnoremap <Up>    <nop>
nnoremap <Down>  <nop>
nnoremap <Left>  <nop>
nnoremap <Right> <nop>

" custom syntax highlighting
au BufRead,BufNewFile *.as    set filetype=actionscript
au BufRead,BufNewFile *.mxml  set filetype=mxml
au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby

" auto strip whitespace when saving
let machine = substitute(system('hostname'), "\n", "", "")
" don't auto strip on these machines
if machine !~ "[calcifer]"
  autocmd BufWritePre * :%s/\s\+$//e
endif

" copy and paste with pbcopy/pbpaste in visual mode
vmap <C-c> y:call system("pbcopy", getreg("\""))<CR>
nmap <C-V> :call setreg("\"",system("pbpaste"))<CR>p

" focus mode
function! ToggleFocusMode()
  if (&foldcolumn != 12)
    set laststatus=0
    set numberwidth=10
    set foldcolumn=12
    set noruler
    hi FoldColumn ctermbg=none
    hi LineNr ctermfg=0 ctermbg=none
    hi NonText ctermfg=0
  else
    set laststatus=2
    set numberwidth=4
    set foldcolumn=0
    set ruler
    execute 'colorscheme ' . g:colors_name
  endif
endfunc
nnoremap <F1> :call ToggleFocusMode()<CR>
