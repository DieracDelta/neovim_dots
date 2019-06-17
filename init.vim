" TAKEN FROM ISAACS CONFIG (https://github.com/isaacmorneau/dotfiles/blob/master/.vim/vimrc)
"Base vim setup
" Jump to last open
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"Indentation rules for language
filetype plugin indent on
"why not use ed otherwise?
syntax on
"what am i typing
set showcmd
"what did i pick
set showmatch
"follow case like a normal person
set ignorecase
set smartcase
set cursorline
"highlight CursorLine gui=underline

"i only have so much screen space
set wrap
"go back like a normal person
set backspace=indent,eol,start
"duh
set autoindent
set copyindent

set splitbelow
set splitright

"nnoremap <Space> <C-w>
let mapleader = "\<SPACE>"

tnoremap <Esc> <C-\><C-n>

"when entering a terminal enter in insert mode
"autocmd BufWinEnter,WinEnter term://* startinsert

"line numbers
set number
"whats open?
set title
"dont care if its not valid,dont tell me
set noerrorbells
"(when i didnt have this before i wiped my hosts file)
set undofile
set undolevels=1000
set undoreload=10000
"reload when i change it with say git
set autoread
"manage buffers nicely
set hidden

"fold setting"
"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use



"give it a little bigger of a bump when i go off the edge
set scrolloff=3
set sidescrolloff=5
"visualize whitepsace
set listchars=tab:→→,trail:●,nbsp:○
set list
if has('unnamedplus')
        set clipboard=unnamed,unnamedplus
endif
"ex mode is BS disable it
"nnoremap Q <nop>
"this is why we have airline
set noshowmode
"delete comment character when joining commented lines
set formatoptions+=j
"this enables true color support but will break how everything looks if you
"use a terminal that doesnt support it such as urxvt
set tgc
"set the encodings to be sane
" note that to add word to custom dictionary, use zg (and undo is zug)
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary
"tabs are bad, also set this after encoding or weird things happen
set expandtab
"tell me whats going on
"only enable when stuff breaks and you dont know why
"let &verbose = 1
if exists('$SHELL')
        set shell=$SHELL
else
        set shell=/bin/bash
endif
"for full code pastes may as well use pastemode
set pastetoggle=<leader>v
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3.6'
"to avoid the mistake of uppercasing these
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qa! qa!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa qa
function! InitializeDirectories()
        let parent = $HOME
        let prefix = 'vim'
        let dir_list = {
                                \ 'backup': 'backupdir',
                                \ 'views':  'viewdir',
                                \ 'swap':   'directory',
                                \ 'undo':   'undodir' }

        let common_dir = parent . '/.' . prefix

        for [dirname, settingname] in items(dir_list)
                let directory = common_dir . dirname . '/'
                if exists("*mkdir")
                        if !isdirectory(directory)
                                call mkdir(directory)
                        endif
                endif
                if !isdirectory(directory)
                        echo "Warning: Unable to create backup directory: " . directory
                        echo "Try: mkdir -p " . directory
                else
                        let directory = substitute(directory, " ", "\\\\ ", "g")
                        exec "set " . settingname . "=" . directory
                endif
        endfor
        let g:scratch_dir = common_dir . 'scratch'. '/'
        if exists("*mkdir")
                if !isdirectory(g:scratch_dir)
                        call mkdir(g:scratch_dir)
                endif
        endif
        if !isdirectory(g:scratch_dir)
                echo "Warning: Unable to create scratch directory: " . g:scratch_dir
                echo "Try: mkdir -p " . g:scratch_dir
        endif
endfunction
call InitializeDirectories()
let s:vim_plug = '~/.vim/autoload/plug.vim'
"if we dont have vimplug yet use this to disable erring first run sections
let s:first_run = 0
if empty(glob(s:vim_plug, 1))
    let s:first_run = 1
    execute 'silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

"been around for ages yet isnt default for % to match if else etc
runtime macros/matchit.vim
"so that line wraps are per terminal line not per global line
nnoremap j gj
nnoremap k gk
"work around for mouse selection to clipboard
"if term supports mouse then the selection will be visual anyway
vnoremap <LeftRelease> "*ygv
"i dont actually want visual mode mouse control
"but i still do want scroll and cursor clicking
set mouse=ni
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter' " The git gutter being the extra column tracking git changes by numbering
Plug 'chrisbra/Colorizer' "highlight hex codes with the color they are
Plug 'isaacmorneau/vim-update-daily' "update vim plugins once a day (yea i made this one)
Plug 'joshdick/onedark.vim' "main color theme
Plug 'luochen1990/rainbow' "rainbow highlight brackets
Plug 'junegunn/fzf' "fuzzy jumping arround
Plug 'junegunn/fzf.vim'
Plug 'isaacmorneau/vim-simple-sessions' "sessions
Plug 'neomake/neomake' "do full syntax checking for most languages
Plug 'ntpeters/vim-better-whitespace' "show when there is gross trailing whitespace
Plug 'sbdchd/neoformat' "allows the formatting of code sanely
Plug 'sheerun/vim-polyglot' "syntax highlighting"
let g:polyglot_disabled = ['latex']
Plug 'tpope/vim-surround' "change things surounding like ()->[]
Plug 'vim-airline/vim-airline' "a statusbar
Plug 'vim-airline/vim-airline-themes' "themes for the statusbar
Plug 'majutsushi/tagbar'
Plug 'vim-syntastic/syntastic'
Plug 'ludovicchabant/vim-gutentags'
"Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'

"Plug 'jreybert/vimagit'
"Plug 'jceb/vim-orgmode'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-speeddating'

" coc.nvim
" to edit config file, :CocConfig
"Plug 'neoclide/coc.nvim'
Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}




" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger='<c-h>'
let g:UltiSnipsJumpForwardTrigger='<c-h>'
let g:UltiSnipsJumpBackwardTrigger='<c-g>'
let g:UltiSnipsSnippetDirectories=['UltiSnips', '/home/dieraca/.config/nvim/snippets/UltiSnips/']

"latex setup
Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

" auto insert delimiters
Plug 'Raimondi/delimitMate'

"Plug 'https://github.com/neoclide/coc.vim', {'do': 'yarn install --frozen-lockfile'}

"Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
"Plug 'Shougo/deoplete.nvim'
"Plug 'sebastianmarkow/deoplete-rust'

call plug#end()

"i put this here so it doesnt look dumb when doing an update and the colors
"are not appllied
if s:first_run == 0
    colorscheme onedark
endif
set background=dark

"[fzf]
"map <C-m> FZF<CR>
"map <s-enter> :FZF<CR>
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let $FZF_DEFAULT_COMMAND =  "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
map <leader>bb :Buffers<cr>
map <leader>bl :Lines<cr>
map <leader>bt :BTags<cr>
map <leader>bm :Marks<cr>
"map <leader>bN :FZF<cr>
map <leader>gg :Ag<cr>
nmap <silent> <leader>h :History<cr>


" The Silver Searcher
if executable('ag')
        let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
        set grepprg=ag\ --nogroup\ --nocolor
endif

"[Easy Align]
"Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
"Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" [ripgrep]
if executable('rg')
        let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
        set grepprg=rg\ --vimgrep
        command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif


"[vim-simple-sessions]
" TODO I want =1 but idk how to get that to work lol
let g:ss_auto_exit=0

"[rainbow]
let g:rainbow_active = 1
"honestly the default config is fine
"
""[update-daily]
"custom command to also update remote plugins for stuff like deoplete
let g:update_daily = 'PU'

" [neoformat]
map <C-x> :Neoformat<CR>
"good for debugging broken formatters
let g:neoformat_verbose = 1
let g:neoformat_basic_format_align = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim = 1
let g:neoformat_c_clang_format = {
                        \ 'exe': 'clang-format',
                        \ 'args': ['-style=~/.clang-format'],
                        \ }
let g:neoformat_cpp_clang_format = {
                        \ 'exe': 'clang-format',
                        \ 'args': ['-style=~/.clang-format'],
                        \ }

let g:neoformat_enabled_c = ['clangformat']
let g:neoformat_enabled_cpp = ['clangformat']

"[one]
"it was the first run so now we need to enable it again
if s:first_run == 1
    colorscheme onedark
endif

"[Airline]
set laststatus=2
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline#extensions#coc#enabled = 1

let g:airline#extensions#tabline#enabled = 1

"i dont know what adds this bullshit but its annoying as hell
let g:omni_sql_no_default_maps = 1

let g:rustfmt_autosave = 1


"autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
"autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

" spacemacs keybinds
map <leader>ws :sp<cr>
map <leader>wv :vs<cr>
map <leader>bd :q<cr>
map <leader>bD :Bclose!<cr>
map <leader>wd :q<cr>
map <leader>bn :tabnext<cr>
map <leader>bp :tabprevious<cr>
map <leader>bN :tabedit<cr>
" enter spawns a new window
map <C-m> :tabedit<cr>:FZF<cr>

"split nav
map <leader>wl :wincmd l<cr>
map <leader>wj :wincmd j<cr>
map <leader>wk :wincmd k<cr>
map <leader>wh :wincmd h<cr>
map <leader>tv :vsplit<cr> :terminal<cr> A
map <leader>ts :split<cr> :terminal<cr> A
map <leader>tn :tab term<cr> A

map <leader>gt gt
map <leader>gT gT
" buffer management
map <leader>bn :bn<cr>
map <leader>bp :bp<cr>
map <leader>bd :bdelete<cr>
map <leader>bD :bdelete!<cr>
"map <leader>;;

map <leader>mb :VimtexCompile<cr>

inoremap <C-z> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-z> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>

"Cntrl + l to fix previous spelling mistake
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
"latex sane tabs + spelling
autocmd FileType tex setlocal ts=2 sw=2 sts=0 expandtab spell
let g:vimtex_complete_enabled = 1
let g:vimtex_complete_close_braces = 1
let g:vimtex_complete_ignore_case = 1
let g:vimtex_complete_smart_case = 1
"let g:vimtex_complete_bib = 1
"
let g:deoplete#enable_at_startup=1
let g:vimtex_compiler_progname='nvr'
set spell spelllang=en_us
set spellfile=/home/dieraca/.config/nvim/spell/en.utf-8.add

"colorizer config
let g:colorizer_auto_color=1

" coc config
" Show all diagnostics; escape to get out
nnoremap <silent> <leader>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <leader>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <leader>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <leader>o  :<C-u>CocList outline<cr>
" Search workleader symbols
nnoremap <silent> <leader>s  :<C-u>CocList -I symbols<cr>
" Resume latest coc list
nnoremap <silent> <leader>p  :<C-u>CocListResume<CR>
" fix current line
nmap <leader>qq  <Plug>(coc-fix-current)

"" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use `[c` and `]c` to navigate errors in current project
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
" error handling aimed at vimtex specifically
nmap <silent> <leader>ee :VimtexErrors<cr>

" Remap keys for gotos
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>td <Plug>(coc-type-definition)
nmap <silent> <leader>i <Plug>(coc-implementation)
nmap <silent> <leader>r <Plug>(coc-references)
" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
nmap <leader>l :Format<cr>
