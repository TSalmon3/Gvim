vim9script

# Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

# Use the internal diff if available.
# Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction


## GUI Config/hide tool bar and menu bar
set guioptions-=m
set guioptions-=T
set guifont=CaskaydiaCove_Nerd_Font_Mono:h12



## basic config

set noswapfile
set number
set relativenumber
set textwidth=80
set wrap
set linebreak
set cursorline
set nocompatible
set showmode
set showcmd
set mouse=a
set cc=+1
set mouse=a
set encoding=utf-8
set tabstop=8
set shiftwidth=8
set expandtab
set softtabstop=8
set laststatus=2
set wrapmargin=2
set updatetime=100
set incsearch
set hlsearch

filetype plugin on
filetype indent on
syntax on

set background=dark
colorscheme gruvbox

## keymap
g:mapleader = ","
g:localmapleader = "<space>"

### keymap/save
nnoremap <c-s> :w<cr>

### keymap/scoll
nnoremap K 2<c-y>
nnoremap J 2<c-e>

### keymap/window split
nnoremap sv :vsplit<cr>
nnoremap sh :split<cr>

### keymap/window close
nnoremap sc :quit<cr>

### keymap/window toggle
nnoremap <a-h> <C-w>h
nnoremap <a-j> <C-w>j
nnoremap <a-k> <C-w>k
nnoremap <a-l> <C-w>l

### keymap/window resize
nnoremap <a-Left> :vertical resize -2<cr>
nnoremap <a-Right> :vertical resize +2<cr>
nnoremap <a-Up> :resize -2<cr>
nnoremap <a-Down> :resize +2<cr>

### keymap/Fast to exit insert/visual mode
inoremap jk <esc>
vnoremap jk <esc>

### keymap/Fast open and source .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

### keymap/switch between termianl win to nerdtree win or editor win
tnoremap <a-j> <c-w>j
tnoremap <a-k> <c-w>k
tnoremap <a-h> <c-w>h
tnoremap <a-l> <c-w>l

## plugin
plug#begin('D:APP/ENGINEERING/vim/vim90/plugged')
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'
Plug 'easymotion/vim-easymotion'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'romainl/vim-cool'
Plug 'voldikss/vim-floaterm'
Plug 'airblade/vim-rooter'
Plug 'vim-autoformat/vim-autoformat'
Plug 'gelguy/wilder.nvim'
Plug 'Yggdroot/indentLine'
Plug 'mg979/vim-visual-multi', {'branch':'master'}
Plug 'justinmk/vim-dirvish'
Plug 'Yggdroot/LeaderF'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
plug#end()

### Plugin/vim-visual-multi
g:VM_maps = {}
g:VM_maps["Exit"] = '<esc>'
g:VM_maps["Find Under"] = '<c-n>'
g:VM_maps["Find Subword Under"] = '<c-n>'
g:VM_maps["Find Next"] = 'n'
g:VM_maps["Find Prev"] = 'N'
g:VM_maps["Remove Region"] = 'q'
g:VM_maps["Skip Region"] = 'Q'
g:VM_maps["Select Cursor Down"] = '<c-j>'
g:VM_maps["Select Cursor Up"] = '<c-k>'
g:VM_maps["Increase"] = '='
g:VM_maps["Decrease"] = '-'
g:VM_maps["Undo"] = 'u'
g:VM_maps["Redo"] = '<c-r>'

### Plugin/wilder
call wilder#setup({
      \ 'modes': [':', '/', '?'],
      \ 'next_key': '<Tab>',
      \ 'previous_key': '<S-Tab>',
      \ })



call wilder#set_option('renderer', wilder#renderer_mux({
      \ ':': wilder#popupmenu_renderer(),
      \ '/': wilder#wildmenu_renderer(),
      \ }))


call wilder#set_option('renderer', wilder#popupmenu_renderer({
      \ 'left': [
      \   ' ', wilder#popupmenu_devicons(),
      \ ],
      \ 'right': [
      \   ' ', wilder#popupmenu_scrollbar(),
      \ ],
      \ }))

# 'border'            : 'single', 'double', 'rounded' or 'solid'
#                     : can also be a list of 8 characters,
#                     : see :h wilder#popupmenu_border_theme() for more details
# 'highlights.border' : highlight to use for the border`
# call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
      # \ 'highlights': {
      # \   'border': 'Normal',
      # \ },
      # \ 'border': 'rounded',
      # \ })))

### Plugin/vim-autoformat
nnoremap <F3> :Autoformat<cr>
au BufWrite *.c :Autoformat

### Plugin/vim-rooter
g:rooter_targets = '/,*'
g:rooter_patterns = ['.git']
g:rooter_manual_only = 1
g:rooter_cd_cmd = "cd"
g:rooter_silent_chdir = 0
nnoremap cd :Rooter<cr> :NERDTreeCWD<cr> :NERDTreeToggle<cr>

### Plugin/vim-floaterm
g:floaterm_height = 0.8
g:floaterm_width = 0.8
g:floaterm_autoclose = 2

nnoremap <F1> :FloatermToggle --cwd=<root><cr>
tnoremap <F1> <C-\><C-n>:FloatermToggle --cwd=<root><cr>

nnoremap tt :FloatermToggle<cr>
nnoremap txt :FloatermKill<cr>
tnoremap tt <C-\><C-n>:FloatermToggle<cr>
tnoremap txt <C-\><C-n>:FloatermKill<cr>
tnoremap <esc> <C-\><C-n>

### plugin/vim-cpp-enhanced-highlight(syntax highlight)
g:cpp_member_variable_highlight = 1

### Plugin/vim-cool
g:cool_total_matches = 1


### plugin/rainbow
g:rainbow_active = 1
g:rainbow_conf = {
\       'separately': {
\               'nerdtree': 0,
\       }
\}

### Plugin/starify
nnoremap <a-s> :Startify<cr>
g:startify_lists = [
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'files',     'header': ['   MRU']            },
          \ ]

# g:startify_bookmarks = ['~/OneDrive/Document/Obsidian/bookmark/index.md']

nnoremap <leader>ss :SSave<cr>
nnoremap <leader>sc :SClose<cr>


### plugin/nerdtree 
nnoremap te :NERDTreeToggle<cr>

### plugin/vim-devicons

### plugin/vim-ariline
g:airline_theme = 'one'
g:airline#extensions#branch#vcs_checks = ['untracked', 'dirty']
g:airline#extensions#tabline#enabled = 1
g:airline#extensions#tabline#left_sep = ''

g:airline_left_sep = ''
g:airline_left_alt_sep = ''
g:airline_right_sep = ''
g:airline_right_alt_sep = ''

if !exists('g:airline_symbols')
    g:airline_symbols = {}
endif


g:airline_symbols.branch = ''
g:airline_symbols.colnr = ' ℅:'
g:airline_symbols.readonly = ''
g:airline_symbols.linenr = ' :'
g:airline_symbols.maxlinenr = '¶ '

g:airline#extensions#tabline#buffer_idx_mode = 1
nnoremap <leader>1 <Plug>AirlineSelectTab1
nnoremap <leader>2 <Plug>AirlineSelectTab2
nnoremap <leader>3 <Plug>AirlineSelectTab3
nnoremap <leader>4 <Plug>AirlineSelectTab4
nnoremap <leader>5 <Plug>AirlineSelectTab5
nnoremap <leader>6 <Plug>AirlineSelectTab6
nnoremap <leader>7 <Plug>AirlineSelectTab7
nnoremap <leader>8 <Plug>AirlineSelectTab8
nnoremap <leader>9 <Plug>AirlineSelectTab9
nnoremap <leader>0 <Plug>AirlineSelectTab0

nnoremap <leader>- <Plug>AirlineSelectPrevTab
nnoremap <leader>= <Plug>AirlineSelectNextTab


### plugin/easymotion
g:EasyMotion_do_mapping = 0
g:EasyMotion_smartcase = 0
nnoremap <leader> <Plug>(easymotion-prefix)

#### <Leader>f{char} to move to {char}
nnoremap mf <Plug>(easymotion-bd-f)
nnoremap mf <Plug>(easymotion-overwin-f)

#### <Leader>s{char}{char} to move to {char}{char}
nnoremap ms <Plug>(easymotion-overwin-f2)

#### Move to line
nnoremap ml <Plug>(easymotion-bd-jk)
nnoremap ml <Plug>(easymotion-overwin-line)

#### Move to word
nnoremap mw <Plug>(easymotion-bd-w)
nnoremap mw <Plug>(easymotion-overwin-w)

