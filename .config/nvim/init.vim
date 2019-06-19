" vim-markdown-composer
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

call plug#begin('$XDG_DATA_HOME/nvim/plugged')

" Always
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'chriskempson/base16-vim'
Plug 'justinmk/vim-sneak'
Plug 'justinmk/vim-dirvish'
Plug 'xolox/vim-misc'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'scrooloose/nerdcommenter'
Plug 'junegunn/fzf', { 'dir': $XDG_CONFIG_HOME.'/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-signify'
Plug 'matze/vim-move'
Plug 'ludovicchabant/vim-gutentags'
Plug 'kassio/neoterm'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'neoclide/coc.nvim', { 'tag': '*', 'do': './install.sh' }
Plug 'sheerun/vim-polyglot'

" Useful at times
" Plug 'guns/xterm-color-table.vim'
" Plug 'raghur/vim-ghost', { 'do': ':GhostInstall' }
" Plug 'wlangstroth/vim-racket', { 'for': ['racket', 'scheme'] }
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

call plug#end()

set nobackup
set noswapfile

" UI
set relativenumber
set number
set history=1000
set hidden " switch buffers without saving
set backspace=indent,eol,start
set showmatch
set incsearch
set hlsearch
set ignorecase
set smartcase
set wildmenu
set wildmode=list:longest,full
set whichwrap=b,s,h,l,<,>,[,]
set scrolljump=5
set scrolloff=3
set nolist
set clipboard+=unnamedplus
set cursorline
set updatetime=300
set shortmess+=c

" Formatting
set background=dark
filetype plugin indent on
syntax on
if filereadable(expand($XDG_CONFIG_HOME).'/nvim/nvim_background')
  let base16colorspace=256
  set termguicolors
  source $XDG_CONFIG_HOME/nvim/nvim_background
endif
set nowrap
set textwidth=100
set wrapmargin=0
set autoindent
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set fillchars=vert:\ ,stl:\ ,stlnc:\ , " note: trailling comma required
set statusline=\ %t\ [%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
nnoremap <Leader>jf :%!python -m json.tool<CR>

" Key
inoremap jj <Esc>
inoremap jk <Esc>
let mapleader = ','
nmap <Leader>ev :e $MYVIMRC<CR>
nmap <Leader>sv :so $MYVIMRC<CR>
nmap <Leader>r :redraw!<CR>
map <Leader>p <C-^>
map <Leader>. :bn<CR>
map <Leader>bd :bd<CR>
map <Leader>w :w<CR>
map <Leader>q :q<CR>
map <Leader>n :noh<CR>

" Maximise current
map <Leader>m <C-W><Bar>

" Open all folds
map <Leader>ff zR

" Splits
map <Leader>vs :vs<CR>
map <leader>sp :sp<CR>
set splitright

" Move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-p> :FZF<CR>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" Resize windows
map <A-,> <C-W><
map <A-.> <C-W>>
map <A-+> <C-W>+
map <A--> <C-W>-
map <A-=> <C-W>=

" Move within a wrapped line
nnoremap j gj
nnoremap k gk

" Working directory
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" Indent without leaving visual mode
vnoremap < <gv
vnoremap > >gv

" Fugitive
set previewheight=30
let g:netrw_browsex_viewer = 'google-chrome'
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>du :diffupdate<CR>
nnoremap <silent> <leader>dgt :diffget //2<CR>
nnoremap <silent> <leader>dgm :diffget //3<CR>

" Location list
nnoremap <silent> <leader>ln :lnext<CR>
nnoremap <silent> <leader>lp :lprevious<CR>

" vim-signify
highlight clear SignColumn
let g:signify_vcs_list               = [ 'git', 'hg' ]
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = 'Δ'
let g:signify_sign_changedelete      = g:signify_sign_change

" highlight lines in Sy and vimdiff etc.)
highlight DiffAdd cterm=bold ctermbg=none ctermfg=34
highlight DiffDelete cterm=bold ctermbg=none ctermfg=16
highlight DiffChange cterm=bold ctermbg=none ctermfg=4

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" Sneak
let g:sneak#label = 1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" ripgrep
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" FZF
" Rg uses with_preview option (hit '?' to display)
" Also, don't show results from tagfiles, .git, node_modules, lock files
command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --ignore-case --hidden --no-ignore --glob "!{.git,node_modules,tags,package-lock.json,yarn.lock}" '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)
" Same, but search on word under cursor
command! -bang -nargs=* Rr
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --ignore-case --hidden --no-ignore --glob "!{.git,node_modules,tags,package-lock.json,yarn.lock}" '.shellescape(expand('<cword>')), 1,
    \   <bang>0 ? fzf#vim#with_preview('up:60%')
    \           : fzf#vim#with_preview('right:50%:hidden', '?'),
    \   <bang>0)
" Git grep from FZF
command! -bang -nargs=* GGrep
    \ call fzf#vim#grep(
    \   'git grep --line-number '.shellescape(<q-args>), 0,
    \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
" Files with preview
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(
    \   <q-args>,
    \   fzf#vim#with_preview(),
    \   <bang>0)
nnoremap <leader>rg :Rg<space>
nnoremap <leader>rr :Rr<CR>

" markdown
autocmd BufRead,BufNewFile *.md setlocal wrap linebreak tw=0

" vim-gutentags
let g:gutentags_ctags_exclude = ['node_modules', '.git', 'package-lock.json', 'yarn.lock'] 

" python
let g:python_host_prog = expand($XDG_DATA_HOME).'/virtualenvs/nvimp2-sk9zInl9/bin/python'
let g:python3_host_prog = expand($XDG_DATA_HOME).'/virtualenvs/nvimp3-VnFM7OAS/bin/python'

" terminal
noremap <leader>` :vertical Tnew<CR>
tnoremap  <leader>` <C-\><C-N>
let g:neoterm_autoinsert = 1

" airline/tmuxline
let g:airline_powerline_fonts=1
let g:airline_theme='base16_vim'
let g:airline_base16_monotone = 1
let g:airline#extensions#tmuxline#enabled = 1
let airline#extensions#tmuxline#snapshot_file = expand($XDG_CONFIG_HOME).'/tmux/tmux-status.conf'

" coc.vim
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,typescript.tsx,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" highlight CocErrorLine term=NONE gui=NONE
" highlight CocWarningLine term=NONE gui=NONE
highlight CocErrorHighlight term=bold cterm=bold gui=bold
highlight CocWarningHighlight term=bold cterm=bold gui=bold
highlight CocInfoHighlight term=italic cterm=italic gui=italic
highlight CocHintHighlight term=italic cterm=italic gui=italic

nnoremap <silent> <leader>tsi :CocCommand tsserver.executeAutofix<CR>
nnoremap <silent> <leader>tso :CocCommand tsserver.organizeImports<CR>
nnoremap <silent> <leader>tsp :CocCommand prettier.formatFile<CR>