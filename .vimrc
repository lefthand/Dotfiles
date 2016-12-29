"~~~~~~~~~~~~~~~~  LEADERS ~~~~~~~~~~~~~~~~~~ {{{
let mapleader = ","
let maplocalleader = "\\"

" }}}
"~~~~~~~~~~~~~~~~  THEME ~~~~~~~~~~~~~~~~~~~~ {{{
colorscheme benokai

" }}}
"~~~~~~~~~~~~~~~~  ABBREVIATIONS ~~~~~~~~~~~~ {{{

iabbrev adn and
iabbrev cf cloudformation
iabbrev @@ lefthand@gmail.com

" }}}
"~~~~~~~~~~~~~~~~  COMMANDS ~~~~~~~~~~~~~~~~~ {{{

augroup useTemplate
  autocmd!
  autocmd BufNewFile * silent! 0r $VIMHOME/templates/%:e.tpl
augroup END
augroup stripTrailingSpace
  autocmd!
  autocmd BufWritePre * :%s/\s\+$//e
augroup END

"some common typos
command! Q  quit
command! W  write
command! Wq wq

cno sudow w !sudo tee % >/dev/null
command! Sudow w !sudo tee % >/dev/null

augroup cloudformationLint
  autocmd!
" Only execute if in ~/Code/cloudformation
" Handle output, if json, ignore. Print otherwise
autocmd BufWritePre *.yml :! aws cloudformation validate-template --template-body file://%
augroup END

augroup insertComments
  autocmd!
  autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
  autocmd FileType python     nnoremap <buffer> <localleader>c I#<esc>
  autocmd FileType ruby       nnoremap <buffer> <localleader>c I"<esc>
  autocmd FileType vim        nnoremap <buffer> <localleader>c I"<esc>
augroup END

augroup helpers
  autocmd!
  autocmd FileType python     :iabbrev <buffer> iff if:<left>
  autocmd FileType javascript :iabbrev <buffer> iff if ()<left>
  autocmd FileType ruby       :iabbrev <buffer> iff if
  autocmd FileType ruby       :iabbrev <buffer> what is
augroup END

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END


" }}}
"~~~~~~~~~~~~~~~~  SETTINGS ~~~~~~~~~~~~~~~~~ {{{

syntax on
let php_sql_query=1
let php_htmlInStrings=1
let php_folding = 2
let javascript_folding = 2

"Tab Stuff
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
noremap gf :tabedit <cfile><CR>

" Toggle search highlighting
"map H :let &hlsearch = !&hlsearch<CR>
"
set relativenumber
set showmatch
set cursorline
"Start search while typing
set incsearch
"see partial commands?
set showcmd
"highlight searches
set hlsearch
"Remove -- INSERT -- below status line
set noshowmode
"Set the dictionary and allow autocomplete
"set dictionary-=/usr/share/dict/words dictionary+=/usr/share/dict/words
set complete-=k complete+=k


" }}}
"~~~~~~~~~~~~~~~~  MAPPINGS ~~~~~~~~~~~~~~~~~ {{{

onoremap ih :<c-u>execute "normal! ?^[=-]\\{2,\\}$\r:nohlsearch\rkvg_"<cr>
onoremap ah :<c-u>execute "normal! ?^[=-]\\{2,\\}$\r:nohlsearch\rg_vk0"<cr>

onoremap p i(
onoremap b /return<cr>
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>
onoremap in{ :<c-u>normal! f{vi{<cr>
onoremap il{ :<c-u>normal! F}vi{<cr>

noremap <Leader># :s/^/#/<CR>
noremap <Leader>/ :s/^/\/\//<CR>
noremap <Leader>> :s/^/> /<CR>
noremap <Leader>" :s/^/\"/<CR>
noremap <Leader>% :s/^/%/<CR>
noremap <Leader>! :s/^/!/<CR>
noremap <Leader>; :s/^/;/<CR>
noremap <Leader>- :s/^/--/<CR>
noremap <Leader>c :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>
" wraping comments
noremap <Leader>* :s/^\(.*\)$/\/\* \1 \*\//<CR>
noremap <Leader>( :s/^\(.*\)$/\(\* \1 \*\)/<CR>
noremap <Leader>< :s/^\(.*\)$/<!-- \1 -->/<CR>
noremap <Leader>d :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/<CR>

" Move current line up / down
noremap - ddp
noremap _ ddkP

" Visually select entire word
" " Visually select entire word
noremap <space> viw

" Delete line in insert mode
inoremap <c-d> <esc>ddi
" Capitalize last or current word
inoremap <c-u> <esc>viwUea
nnoremap <c-u> viwUe

" Surround word with quotes
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
vnoremap <leader>" <esc>`<i"<esc>`>a"<esc>
vnoremap <leader>' <esc>`<i'<esc>`>a'<esc>

" Edit vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>


" }}}
"~~~~~~~~~~~~~~~~  FOLDING ~~~~~~~~~~~~~~~~~~ {{{

function! JavaScriptFold()
  setl foldmethod=syntax
  setl foldlevelstart=1
  syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

  function! FoldText()
    return substitute(getline(v:foldstart), '{.*', '{...}', '')
  endfunction
  setl foldtext=FoldText()
endfunction
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen





" }}}
"~~~~~~~~~~~~~~~~  PLUG-INS ~~~~~~~~~~~~~~~~~ {{{

" Vim pathogen, used to install git plugin and others
execute pathogen#infect()

" Vim plug - plugin manager
call plug#begin('~/.vim/plugged')
"A theme
Plug 'morhetz/gruvbox'

" Chef plugins
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'vadv/vim-chef'

Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'avakhov/vim-yaml'
Plug 'kchmck/vim-coffee-script'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
"Plug 'wookiehangover/jshint.vim'
call plug#end()

" }}}
" ================      Lightline  ========== {{{

set laststatus=2
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
        \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ }

function! LightlineFugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

" }}}
" ================      Syntastic  ========== {{{
" Configurations Syntastic and respective linters

autocmd FileType ruby,eruby set filetype=ruby.eruby.chef
autocmd BufNewFile,BufRead *.json set ft=javascript

" Improve display of syntastic numberline flags
hi! link SyntasticStyleErrorSign ErrorMsg
hi! link SyntasticErrorSign ErrorMsg
hi! link SyntasticWarningSign Type
hi! link SyntasticStyleWarningSign Type

" jscs returns exit code when no config file is present.
" only load it when appropriate
function! JavascriptCheckers()
  if filereadable(getcwd() . '/.jscsrc')
    return ['jshint', 'jscs']
  else
    return ['jshint']
  endif
endfunction

function! PhpcsArgs()
  let fpath = getcwd() . '/.phpcs.xml'
  if filereadable(fpath)
    return '-s -n --report=csv --standard=' . fpath
  endif
endfunction

" Only enable scss linter if there is a config in root
function! ScssChecker()
  if filereadable(getcwd() . '/.scss-lint.yml')
    return ['scss_lint']
  else
    return []
  endif
endfunction

let g:syntastic_enable_signs = 1
let g:syntastic_stl_format = '%E{E%e}%B{, }%W{W%w}'  "Parsed by lightline
let g:syntastic_style_error_symbol = "››"
let g:syntastic_error_symbol = "››"
let g:syntastic_warning_symbol = "››"
let g:syntastic_style_warning_symbol = "››"
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_yaml_checkers=['yamllint']
let g:syntastic_scss_checkers = ScssChecker()
let g:syntastic_html_checkers = ['']
let g:syntastic_php_phpcs_args = PhpcsArgs()
let g:syntastic_yaml_yamllint_args = '-d "{extends: default, rules: {line-length: {max: 220} } }"'
let g:syntastic_javascript_checkers = JavascriptCheckers()
let g:syntastic_aggregate_errors = 1


augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.js,*.php call s:syntastic()
augroup END

" Update lightline
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

" }}}
"~~~~~~~~~~~~~~~~  RESOURCES ~~~~~~~~~~~~~~~~ {{{
" Learn Vim the hard way: http://learnvimscriptthehardway.stevelosh.com/
" }}}
