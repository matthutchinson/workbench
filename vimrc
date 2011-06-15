"Set this first (avoid use of -N for vi compatibility)
set nocompatible

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

" Custom mappings
" Ctrl+t opens Command-T 
" Ctrl+b opens LustyBuffer
" Ctrl+c toggles commenting
" Ctrl+f opens Ack
" F5 tidies syntax in entire file
map <C-t> <leader>t
map <C-b> <leader>lb
map <C-c> <leader>c<Space>
map <C-F> :Ack 
map <silent> <F5> mmgg=G'm
imap <silent> <F5> <Esc> mmgg=G'm

" quickly edit and resource vimrc
map <leader>v :sp ~/.vimrc<cr>       " \v opens ~/.vimrc in a split
map <leader>u :source ~/.vimrc<cr>   " \u sources ~/.vimrc

" git blame with /g in visual mode
vmap <Leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

" Turn OFF arrow keys, left and right move through buffers
map <up> <nop>
map <down> <nop>
nnoremap <left> :bp<cr>
nnoremap <right> :bn<cr>

" Custom syntax highlighting
au BufRead,BufNewFile Gemfile set filetype=ruby
au BufRead,BufNewFile *.as    set filetype=actionscript
au BufRead,BufNewFile *.mxml  set filetype=mxml

" Clipboard
nmap <F1> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
imap <F1> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
nmap <F2> :.w !pbcopy<CR><CR>
vmap <F2> :w !pbcopy<CR><CR>

" Always open with these commands
" autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd p
