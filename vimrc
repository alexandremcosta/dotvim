" Pathogen setup
execute pathogen#infect()

syntax on
filetype plugin indent on

set incsearch
set number relativenumber
set ignorecase
set smartcase

map ; :
command SudoW w !sudo tee % > /dev/null

" Plugins
"nnoremap <silent> <C-w>w :ZoomWin<CR>
map <Leader>n :NERDTreeToggle<CR>
nnoremap <Leader>a :Ack!<Space>
nnoremap <silent> <Leader>f :ZoomWin<CR>
inoremap <silent> <Leader>f <Esc>:ZoomWin<CR>==gi

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Colorscheme
set termguicolors
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
set background=dark
colorscheme gruvbox

" Remove arrows
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Move current line
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" Ctrlp
set runtimepath^=~/.vim/bundle/ctrlp
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/](\.(git|hg|svn)|(node_modules|tmp))$',
      \ 'file': '\v\.(exe|so|dll|swp)$',
      \ }

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

