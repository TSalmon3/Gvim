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
# autocmd GUIEnter * simalt ~x

## basic config

set novb
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
set nobackup

filetype plugin on
filetype indent on
syntax on

set background=dark
# colorscheme gruvbox
colorscheme one

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
#plug#begin('D:APP/ENGINEERING/vim/vim90/plugged')
plug#begin('$VIMRUNTIME/plugged')
Plug 'morhetz/gruvbox'
Plug 'easymotion/vim-easymotion'
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
Plug 'luochen1990/rainbow'
Plug 'liuchengxu/vista.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

plug#end()

### Plugin/markdown-preview
g:mkdp_brower = 'firefox'
nnoremap <F8> <Plug>MarkdownPreviewToggle
inoremap <F8> <Plug>MarkdownPreviewToggle

### plugin/ale
g:ale_disable_lsp = 1
g:ale_sign_error = ''
g:ale_sign_warning = ''
g:ale_echo_msg_error_str = ''
g:ale_echo_msg_warning_str = ''
g:ale_echo_msg_format = '[%severity%][%linter%] %s'
nnoremap <silent> ]e <plug>(ale_next_wrap)
nnoremap <silent> [e <plug>(ale_previous_wrap)

### plugin/Vista
g:vista_sidebar_position = 'vertical topleft'
g:vista_default_execute = 'ctags'
g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
g:vista#renderer#enable_icon = 1
g:vista_highlight_whole_line = 1
autocmd BufEnter * if winnr("$") == 1 && vista#sidebar#IsOpen() | execute "normal! :q!\<CR>" | endif
nnoremap ta :Vista!!<cr>


### plugin/coc
g:coc_data_home = '$VIMRUNTIME/.config/coc'
g:coc_global_extension = [
        \ 'coc-marketplace',
        \ 'coc-json',
        \ 'coc-clangd',
        \ 'coc-vimlsp',
        \ 'coc-explorer',
        ]

# Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
# Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
# delays and poor user experience.
set updatetime=300
# Always show the signcolumn, otherwise it would shift the text each time
# diagnostics appear/become resolved.
set signcolumn=yes
# Use tab for trigger completion with characters ahead and navigate.
# NOTE: There's always complete item selected by default, you may want to enable
# no select by `"suggest.noselect": true` in your configuration file.
# NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
# other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
  \ coc#pum#visible() ? coc#pum#next(1) :
  \ CheckBackspace() ? "\<Tab>" :
  \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

# Make <CR> to accept selected completion item or notify coc.nvim to format
# <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                          \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

def CheckBackspace(): bool
var col = col('.') - 1
return !col || getline('.')[col - 1]  =~# '\s'
enddef

# Use <c-o> to trigger completion.
inoremap <silent><expr> <c-o> coc#refresh()

# Use `[g` and `]g` to navigate diagnostics
# Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
# nnoremap <silent> g[ <Plug>(coc-diagnostic-prev)
# nnoremap <silent> g] <Plug>(coc-diagnostic-next)
# nnoremap <silent> ge <Plug>(coc-diagnostic-prev-error)
# nnoremap <silent> gE <Plug>(coc-diagnostic-next-error)
nnoremap <silent> <a-d> :CocDiagnostics<cr>

# GoTo code navigation.
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)

# GoTo diagnostic 
# nnoremap <silent> g] <Plug>(coc-diagnostic-next)
# nnoremap <silent> g[ <Plug>(coc-diagnostic_prev)
# nnoremap <silent> ge <Plug>(coc-diagnostic_next_error)
# nnoremap <silent> gE <plug>(coc-diagnostic_prev_error)
# nnoremap <silent> da <Plug>(coc-list-diagnostics)

# Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

def ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    CocActionAsync('doHover')
  else
    feedkeys('K', 'in')
  endif
enddef

# Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight') 

# Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

# coc/coc-explorer
nnoremap te <Cmd>CocCommand explorer --toggle --position right<CR> 

### plugin/auto-pairs
g:AutoPairsShortcutToggle = ''

### plugin/Leaderf
g:Lf_GtagsAutoGenerater = 1
g:Lf_RootMarkerts = ['.git']
nnoremap <a-f> :Leaderf rg -i<cr>
nnoremap <a-p> :Leaderf file<cr>
# nnoremap <a-m> :Leaderf mru<cr>
nnoremap <a-g> :Leaderf gtags --update<cr> :Leaderf gtags<cr>
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

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
nnoremap cd :Rooter<cr>
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

### plugin/vim-devicons

### plugin/vim-ariline
g:airline_theme = 'papercolor'
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

