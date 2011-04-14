" Set this first (avoid use of -N for vi compatibility) 
set nocompatible

" Colors
set t_Co=256
if &t_Co >= 256 || has("gui_running")
  set background=dark
  colorscheme ir_black
endif

syntax on                         " Turn on syntax highlighting.
filetype plugin indent on         " Turn on file type detection.

runtime macros/matchit.vim        " Load the matchit plugin.

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
set history=1000                  " Remember more commands and search history
set undolevels=1000               " Use many muchos levels of undo

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location

set softtabstop=2                 " Soft tabs, ie. number of spaces for tab
set tabstop=2                     " Global tab width.
set shiftwidth=2                  " And again, related.
set expandtab                     " Use spaces instead of tabs
set smarttab                      " Insert tabs on the start of a line according to shiftwidth, not
set shiftround                    " Use multiple of shiftwidth when indenting with '<' and '>'

" Status line colors
hi User1 ctermbg=black ctermfg=green guibg=black guifg=green
hi User2 ctermbg=black ctermfg=red guibg=black guifg=red

" Status line config
set laststatus=2                  
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P
set statusline+=%1*
set statusline+=\ %{exists('g:loaded_rvm')?rvm#statusline():''} " RVM info in green
set statusline+=%2*
set statusline+=\ [%{GitBranch()}] " GIT branch in red
set statusline+=%*

" Folding
set foldmethod=syntax
set foldcolumn=4
set nofoldenable

" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

" Custom mappings
" CTRL+t opens Command-T 
" CTRL+b opens lusty buffer
" CTRL+F opens Ack search
" F6 opens lusty file
" F5 indents/formats entire document
map  <C-t> <leader>t
map  <C-b> <leader>lb
map  <C-F> :Ack 
map  <F6> <leader>lf
map  <silent> <F5> mmgg=G'm
imap <silent> <F5> <Esc> mmgg=G'm

" CTRL+c,p copies and pastes from the system paste buffer
vmap <C-c> y:call system("pbcopy", getreg("\""))<CR> 
nmap <C-p> :call setreg("\"",system("pbpaste"))<CR>p 

" Turn OFF arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Custom syntax highlighting
au BufRead,BufNewFile Gemfile set filetype=ruby
au BufRead,BufNewFile *.as    set filetype=actionscript
au BufRead,BufNewFile *.mxml  set filetype=mxml

" Always open with these commands
" autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd p
