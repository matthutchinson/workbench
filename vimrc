" set this first (avoid use of -N for vi compatibility)
set nocompatible

runtime macros/matchit.vim        " Load the matchit plugin.

" user comma for map leader
let mapleader = ","
let g:mapleader = ","

" textwidth and format options
set textwidth=80
set fo-=t

" allow mouse input
if has("mouse")
  set mouse=a
  set mousehide
endif

set t_Co=256
if &t_Co >= 256 || has("gui_running")
  set background=dark
  colorscheme ir_black
endif

syntax on                         " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

set showcmd                       " Display incomplete commands.
set showmode                      " Display the mode you're in.

set backspace=indent,eol,start    " Intuitive backspacing.

set hidden                        " Handle multiple buffers better.

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show line numbers.
set ruler                         " Show cursor position.

set incsearch                     " Highlight matches as you type.
set hlsearch                      " Highlight matches.

set autoindent                    " Always set autoindenting on
set copyindent                    " Copy the previous indentation on autoindenting

set nowrap                        " Turn on line wrapping.
set scrolloff=3                   " Show 3 lines of context around the cursor.

set title                         " Set the terminal's title
set visualbell                    " No beeping.

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location

set softtabstop=2                 " Soft tabs, ie. number of spaces for tab
set tabstop=2                     " Global tab width.
set shiftwidth=2                  " And again, related.
set expandtab                     " Use spaces instead of tabs
set smarttab                      " Insert tabs on the start of a line according to shiftwidth, not
set shiftround                    " Use multiple of shiftwidth when indenting with '<' and '>'

set synmaxcol=80                  " For speed, only syntax highlight the first 80 chars (ruby style guide)
set ttyfast                       " For speed
set listchars+=trail:░            " Show trailing chars as the ░ char

" status line colors
hi User1 ctermbg=black ctermfg=green guibg=black guifg=green
hi User2 ctermbg=black ctermfg=red guibg=black guifg=red
hi User3 ctermbg=black ctermfg=yellow guibg=black  guifg=yellow

" status line config
set laststatus=2
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P
set statusline+=%1*
set statusline+=%3*
set statusline+=\ %{fugitive#statusline()} " Git info in red
set statusline+=\[%{&fo}] " Git info in red
set statusline+=%*

" folding
set foldmethod=syntax
set foldcolumn=4
set nofoldenable

" custom mappings
" Ctrl+t opens CommandT
" F6 runs CommandTFlush
" Ctrl+c toggles commenting
" Ctrl+f opens Ack
" F5 tidies syntax in entire file
nmap <silent> <C-t> :CommandT<CR>
nmap <silent> <F6> :CommandTFlush<CR>
map <C-c> <leader>c<Space>
map <C-F> :Ack
map <silent> <F5> mmgg=G'm
imap <silent> <F5> <Esc> mmgg=G'm

" CommandT config
let g:CommandTMaxFiles=25000
let g:CommandTMaxDepth=15
let g:CommandTCancelMap='<C-x>'
set wildignore+=*.o,*.obj,.git,*.png,*.PNG,*.JPG,*.jpg,*.GIF,*.gif,*.zip,*.ZIP,*.eot,*.svg,*.csv,*.ttf,*.svg,*.eof,*.ico,*.woff,vendor/**,coverage/**,tmp/**,rdoc/**,*.sqlite3,.svn,**/vendor/apache-ant-1.8.2/**,**/vendor/rails/**

" fast saving
nmap <leader>w :w!<cr>

" fast edit and source vimrc
map <leader>v :sp ~/.vimrc<cr>       " \v opens ~/.vimrc in a split
map <leader>u :source ~/.vimrc<cr>   " \u sources ~/.vimrc

" fugitive git bindings
map <leader>gs :Gstatus<cr>
map <leader>gb :Gblame<cr>
map <leader>gd :Gdiff<cr>
map <leader>gg :Ggrep<Space>
map <leader>ge :Gedit<cr>
map <leader>gl :Glog -250<cr><cr>:copen<cr><cr>
map <leader>gL :Glog -250 --<cr><cr>:copen<cr><cr>
map <leader>gc :Gcommit

" RSpec run spec under cursor
map <leader>rs :<C-U>!spec <C-R>=expand("%:p") <CR> -c -l <C-R>=line(".") <CR> <CR>

" move buffers tab/shift-tab moves
nnoremap <tab> :bn<cr>
nnoremap <S-tab> :bp<cr>
" close buffer
nmap <leader>d :bd<cr>
" close all buffers
nmap <leader>D :bufdo bd<cr>

" turn OFF arrow keys
nnoremap <Up>    <nop>
nnoremap <Down>  <nop>
nnoremap <Left>  <nop>
nnoremap <Right> <nop>

" custom syntax highlighting
au BufRead,BufNewFile Gemfile set filetype=ruby
au BufRead,BufNewFile *.as    set filetype=actionscript
au BufRead,BufNewFile *.mxml  set filetype=mxml

" auto strip whitespace when saving
autocmd BufWritePre * :%s/\s\+$//e
