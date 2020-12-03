" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" ================ General Config ====================

set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set visualbell                  "No sounds
set autoread                    "Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" Change leader to a comma because the backslash is too far away
" That means all \x commands turn into ,x
" The mapleader has to be set before vundle starts loading all
" the plugins.
let mapleader=";"
let g:VM_leader = ";"

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') && isdirectory(expand('~').'/.vim/backups')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

filetype on           " Enable filetype detection
filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================

set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Completion =======================

set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif

" ================ Scrolling ========================

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Search ===========================

set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" Copy relative path to clipboard
" remap ;evs :source $MYVIMRC
nnoremap <Leader>cp :let @+ = expand("%")\| echo "path copied"<CR>
" nnoremap <Leader>cp :let @+=expand('%:p')<CR>
nnoremap <silent> <Leader>cl :let @+ = expand("%") . ":" . line(".")\| echo "path and line copied"<CR>

" jj for escape
nnoremap j gj
nnoremap k gk
inoremap jj <Esc>
nnoremap JJJJ <Nop>

" json format
com! FormatJSON %!python -m json.tool
"nmap =json :%!python -m json.tool<CR>

 " allow underscore to delimit words"
set iskeyword-=_

call plug#begin('~/.vim/plugged')

"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'

Plug 'chrisbra/color_highlight'
Plug 'skwp/vim-colors-solarized'

" Plug 'Shougo/deoplete.nvim'
" Plug 'roxma/nvim-yarp'
" Plug 'roxma/vim-hug-neovim-rpc'

" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Or build from source code by using yarn: https://yarnpkg.com
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf'

Plug 'christoomey/vim-tmux-navigator'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-abolish'

Plug 'skwp/vim-html-escape'
Plug 'elzr/vim-json'

Plug 'vim-syntastic/syntastic'

Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'

Plug 'dense-analysis/ale'

Plug 'ecomba/vim-ruby-refactoring'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-endwise'
Plug 'vim-ruby/vim-ruby'
Plug 'keith/rspec.vim'
Plug 'skwp/vim-spec-finder'
Plug 'tpope/vim-bundler'
Plug 'ck3g/vim-change-hash-syntax'

Plug 'skwp/vim-iterm-rspec'
Plug 'slim-template/vim-slim'
Plug 'mxw/vim-jsx'
Plug 'mattn/emmet-vim'

Plug 'justinmk/vim-sneak'
Plug 'rking/ag.vim'
Plug 'henrik/vim-indexed-search'
Plug 'nelstrom/vim-visual-star-search'
Plug 'skwp/greplace.vim'
Plug 'Lokaltog/vim-easymotion'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tomtom/tcomment_vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

"Plug 'nelstrom/vim-textobj-rubyblock'

" Initialize plugin system
call plug#end()

syntax enable
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

" search
map <leader>t :FZF<CR>

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

function! OpenNerdTree()
  if &modifiable && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
  else
    NERDTreeToggle
  endif
endfunction
nnoremap <silent> <C-\> :call OpenNerdTree()<CR>

let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let g:NERDTreeWinSize = 30
let g:nerdtree_tabs_open_on_gui_startup = 0
let g:nerdtree_tabs_focus_on_files = 1

nmap <D-N> :NERDTreeToggle<CR>
nnoremap <Leader>e :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>r :NERDTreeFind<CR>

" to to the beginnning of text, not a new line
nnoremap 0 ^
nnoremap ^ 0

nmap <leader>ag :Ag ""<Left>

let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>

" Disable the scrollbars (NERDTree)
set guioptions-=r
set guioptions-=L

" Disable the macvim toolbar
set guioptions-=T
set guifont=Monaco:h14

" quickly edit vimrc
" nnoremap <leader>ev :e $MYVIMRC<cr> nnoremap <leader>evs :source $MYVIMRC<cr>
" nnoremap <leader>evl :source $MYVIMRC<cr>

" find next underscore
nnoremap + /\w\+_<CR>
" convert to camelcase
nnoremap _ f_x~

" add yaml formatting
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" remove whitespace
autocmd BufWritePre * %s/\s\+$//e

" external vimrc
set exrc
set secure

" ruby
if has("autocmd")
  augroup templates
    autocmd BufNewFile *[^spec].rb 0r ~/.vim/templates/ruby.rb
    autocmd BufNewFile *_spec.rb 0r ~/.vim/templates/ruby_spec.rb
  augroup END

  " :autocmd BufRead   *.rb    1;/^def
endif

"imap <S-CR>    <CR><CR>end<Esc>-cc
"
" \   'ruby': ['standardrb', 'rubocop'],
let g:ale_linters = {
      \   'ruby': ['standardrb'],
      \   'python': ['flake8', 'pylint'],
      \   'javascript': ['prettier'],
      \}
let g:ale_fix_on_save = 1

" let g:deoplete#enable_at_startup = 1

" autocompletion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" gem install solargraph
let g:coc_global_extensions = ['coc-solargraph']
" :CocInstall coc-vetur coc-json coc-tsserver
