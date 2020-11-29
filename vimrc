execute pathogen#infect()
" Pathogen setup

syntax on
filetype plugin indent on

set incsearch
set number
set ignorecase " set number relativenumber
set smartcase
set nowrap " Prevent line breaks on long lines
set cursorline!
set colorcolumn=100
set backupcopy=yes " Webpack needs this to detect file changes
set backspace=start,eol " Allow backspacing over the start of insert
set redrawtime=10000 " Large files keep syntax highlight

" Set ok Variable
let g:os = substitute(system('uname'), '\n', '', '')

" Mouse compatibility on OSX
if g:os == "Darwin"
  set ttyfast " Send more characters for redraws
  set mouse=a " Enable mouse use in all modes
else
  " Set this to the name of your terminal that supports mouse codes.
  " Must be one of: xterm, xterm2, netterm, dec, jsbterm, pterm
  set ttymouse=xterm2
endif

" Removed in favor of sleuth plugin
" set expandtab
" set shiftwidth=2
" set tabstop=2

map ; :
command SudoW w !sudo tee % > /dev/null

" Colorscheme
set termguicolors
set background=dark
colorscheme molokai

let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
" Increase contrast of grubbox background
if g:colors_name == "gruvbox"
  highlight Normal ctermbg=16 guibg=#000000
endif

"" Opacity
hi Normal guibg=NONE ctermbg=NONE

" Copy and paste to clipboard
if g:os == "Darwin"
  " OSX y and p already use system's clipboad
  set clipboard+=unnamed
else
  " Linux \c in visual model or \v in normal mode
  vmap <Leader>c y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
  nmap <Leader>v :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p
endif

" Folds
" set foldmethod=syntax
" set nofoldenable
" set foldlevel=2
" nnoremap <Space> za

" Remove arrows
" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>

" Change cursor to line on insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Mix test
nnoremap <Leader>t :execute "terminal mix test %:" . line(".")<CR>
nnoremap <Leader>T :execute "terminal mix test %"<CR>
nnoremap <Leader>ti :execute "terminal iex -S mix test %:" . line(".")<CR>

" Move current line
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Buffers
set hidden

" use bdelete N to delete buffer
" :vb N to open buffer N in vertical split
" :sbuffer N to open in horizontal split
cabbrev vb vert sb

" F5 and F6 to switch buffers
nnoremap <F5> :bp<CR>
nnoremap <F6> :bn<CR>

" Tabs
" F7 to switch tabs
nnoremap <F7> :tabnext<CR>

" Plugin mappings
map <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>a :Ack!<Space>
nnoremap <silent> <Leader>f :ZoomWin<CR>

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" NERDTree show hidden files
let NERDTreeShowHidden=1

" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Ack
if executable('ag')
  let g:ackprg = 'ag --hidden --vimgrep'
endif

" Airline
let g:airline_theme='wombat'
let g:airline_powerline_fonts = 1
" Airline show buffers with number
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'short_path'

" Ale
" Required, explicitly enable Elixir LS
let g:ale_linters.elixir = ['elixir-ls']

" Required, tell ALE where to find Elixir LS
let g:ale_elixir_elixir_ls_release = expand("/Users/alexcosta/Dev/clones/elixir-ls/rel/")

" Optional, you can disable Dialyzer with this setting
let g:ale_elixir_elixir_ls_config = {'elixirLS': {'dialyzerEnabled': v:true}}

" Optional, configure as-you-type completions
set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_completion_enabled = 1

" Ctrlp
" set runtimepath^=~/.vim/bundle/ctrlp
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/](\.(git|hg|svn|elixir_ls)|(node_modules|tmp|_build|deps|rel|vendor|cover))$',
      \ 'file': '\v\.(pyc|exe|so|dll|swp)$',
      \ }
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
endif

" FZF
set rtp+=/usr/local/opt/fzf

" Mix format for elixir code
let g:mix_format_on_save = 1

" Vue.js
autocmd FileType vue syntax sync fromstart
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css

" Vue.js + NERDCommenter
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
	exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction

" Autoswp
set title titlestring=

