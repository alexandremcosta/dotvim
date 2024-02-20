syntax on
" Removed temporarily because of elixir indentation conflicts
filetype plugin indent off

set number
set incsearch
set smartcase
set ignorecase
set colorcolumn=99
set nowrap " Prevent line breaks on long lines.
set backupcopy=yes " Webpack needs this to detect file changes.
set backspace=start,eol " Allow backspacing over the start of insert.
set redrawtime=10000 " Large files keep syntax highlight.
set scrolloff=5 " Always show at least 10 lines above/below the cursor.

" Set os Variable
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
colorscheme dracula

" Fix bug in kitty where background of vim follows kitty not colorscheme
let &t_ut=''

" Copy and paste to clipboard
if g:os == "Darwin"
  " OSX y and p already use system's clipboad
  set clipboard+=unnamed
else
  " Linux \c in visual model or \v in normal mode
  vmap <Leader>c y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
  nmap <Leader>v :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p
endif

" Return to last edit position when opening files
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

" Git Blame
nnoremap <silent> <Leader>b :!git blame --color-by-age --date short -- %<CR>

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

" Focus splits
nnoremap <silent> <c-h> <c-w>h
nnoremap <silent> <c-j> <c-w>j
nnoremap <silent> <c-k> <c-w>k
nnoremap <silent> <c-l> <c-w>l

" Move current line
" nnoremap <C-j> :m .+1<CR>==
" nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

nnoremap <silent> <Leader>= :exe "resize " . (winheight(0) * 10/9)<CR>:exe "vertical resize " . (winwidth(0) * 10/9)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 9/10)<CR>:exe "vertical resize " . (winwidth(0) * 9/10)<CR>

" Buffers
set hidden

" use bdelete N to delete buffer
" :vb N to open buffer N in vertical split
" :sbuffer N to open in horizontal split
cabbrev vb vert sb

" Whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader>f :ZoomToggle<CR>

" File explorer
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction

map <Leader>n :call ToggleNetrw()<CR>
map <Leader>N :let @/=expand("%:t") <Bar> execute 'Lexplore' expand("%:h") <Bar> normal n<CR>

" let g:netrw_banner = 0
let g:netrw_liststyle = 1
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" Toggle file explorer
let g:NetrwIsOpen=0

" Open file explorer automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'Vexplore' argv()[0] | wincmd p | ene | endif

" Ack
nnoremap <Leader>a :Ack!<Space>
if executable('rg')
  let g:ackprg = 'rg --vimgrep --smart-case --ignore-vcs --hidden --sortr accessed'
endif

" Auto close the Quickfix list after pressing '<enter>' on a list item
let g:ack_autoclose = 1

" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1

" Navigate quickfix list with ease
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>

" Airline
let g:airline_theme='wombat'
let g:airline_powerline_fonts = 1
" Airline show buffers with number
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'short_path'

" Ale
let g:ale_linters = {}
let g:ale_linters.elixir = ['elixir-ls', 'credo']
let g:ale_fixers = {'elixir': ['mix_format']}
let g:ale_fix_on_save = 1
nnoremap dg :ALEGoToDefinition<cr>
nnoremap dh :ALEHover<cr>
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<TAB>"

" Required, tell ALE where to find Elixir LS
let g:ale_elixir_elixir_ls_release = expand("/Users/alexcosta/Dev/clones/elixir-ls/rel/")

" Optional, you can disable Dialyzer with this setting
let g:ale_elixir_elixir_ls_config = {'elixirLS': {'dialyzerEnabled': v:false}}

" Optional, configure as-you-type completions
set completeopt=menu,menuone,preview,noselect,noinsert
let g:ale_completion_enabled = 1

" FZF
set rtp+=/Users/alexcosta/brew/opt/fzf/
nmap <C-P> :Files<CR>

" Jump to existing window if possible
let g:fzf_buffers_jump = 1
" Override key commands
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit' }

" let $FZF_DEFAULT_COMMAND = 'ag -g ""'
let $FZF_DEFAULT_COMMAND = "rg --files --smart-case --ignore-vcs --hidden --sortr accessed -g '!.git'"

" Autoswp
set title titlestring=

" Split terminal with mix test
let s:term_buf_nr = -1

function! s:MixTestLine() abort
    if s:term_buf_nr == -1
        execute 'terminal mix test % ' . '--exclude test --include line:'. line('.')
        set nonu " remove numbers
        set cc= " remove colorcolumn
        resize -15
        wincmd w " move back to last split pane
        let s:term_buf_nr = bufnr("$")
    else
        try
            execute "bdelete! " . s:term_buf_nr
        catch
        endtry
        let s:term_buf_nr = -1
        call <SID>MixTestLine()
    endif
endfunction

function! s:MixTestFile() abort
    if s:term_buf_nr == -1
        execute 'terminal mix test % --include integration'
        set nonu " remove numbers
        set cc= " remove colorcolumn
        resize -15
        wincmd w " move back to last split pane
        let s:term_buf_nr = bufnr("$")
    else
        try
            execute "bdelete! " . s:term_buf_nr
        catch
        endtry
        let s:term_buf_nr = -1
        call <SID>MixTestFile()
    endif
endfunction

nnoremap <silent> <Leader>t :call <SID>MixTestLine()<CR>zz
tnoremap <silent> <Leader>t <C-w>N:call <SID>MixTestLine()<CR>zz

nnoremap <silent> <Leader>T :call <SID>MixTestFile()<CR>zz
tnoremap <silent> <Leader>T <C-w>N:call <SID>MixTestFile()<CR>zz

nmap <Leader>i i\|> IO.inspect(label: "")<ESC>hi
imap <Leader>i \|> IO.inspect(label: "")<ESC>hi

if &term =~ "xterm\\|rxvt"
  " use an orange cursor in insert mode
  let &t_SI = "\<Esc>]12;green\x7"
  " use a red cursor otherwise
  let &t_EI = "\<Esc>]12;gray\x7"
  silent !echo -ne "\033]12;gray\007"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]112\007"
  " use \003]12;gray\007 for gnome-terminal and rxvt up to version 9.21
endif
