"настройка табуляций
set expandtab
set smarttab
set tabstop=2
set softtabstop=2
set shiftwidth=2

set clipboard=unnamedplus

"добавляет нумерацию строк
set number

" Turn off modelines (в конец открываемых файлов можно поместить описание некоторых переменны.)
set modelines=0

"отступ от левой части окна
set foldcolumn=2

" Status bar
set laststatus=2

set scrolloff=6

" Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>

" Display different types of white spaces.
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" Display options
set showmode
set showcmd

"ищет теги вверх по направлению к корню, пока не найдет
set tags=./tags;/

"подсветка синтаксиса
syntax enable

"отключение звука при нажатии неверной клавиши
set noerrorbells
set novisualbell

"Режимы мыши:
"n - обычный режим;
"v - визуальный режим (режим выделения);
"i - режим вставки;
"c - режим командой строки;
"a - все перечисленные ранее режимы;
"r - для режима "Нажмите Enter" или запроса ввода информации.
"set mouse=a

"===--------------------------------statusline------------------------------------===

set statusline=
set statusline+=%{gitbranch#name()}
set statusline+=%#CursorColumn#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}

"===-----------------------------------key map-------------------------------------===
"для быстрого сохранения '\' + w
"nmap <leader>w :w!<cr>

"перемещение между открытыми вкладками
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l

inoremap <C-v> <ESC>"+pa
vnoremap <C-c> "+y
vnoremap <C-d> "+d

nnoremap gt :YcmCompleter GoTo<CR>

"открыть\закрыть меню навигации по файлам
map <C-n> :NERDTreeToggle<CR>
"===-------------------------------------------------------------------------------===

"===-----------------------------------поиск---------------------------------------===
"игнорирование регистра
set ignorecase
set smartcase

"подсветка результата поиска
set hlsearch

"включение подсказки первого вхождения при вводе шаблона
set incsearch
"===-------------------------------------------------------------------------------===

set termguicolors

" Call the .vimrc.plug file
if filereadable(expand("~/.vimrc.plug"))
source ~/.vimrc.plug
endif

" цветовая схема
"===-------------------------------------------------------------------------------===
autocmd vimenter * ++nested colorscheme gruvbox
set background=dark

let g:gruvbox_contrast_dark='medium'
let g:gruvbox_contrast_light='medium'
let g:gruvbox_italic='1'
let g:gruvbox_termcolors='256'

colorscheme gruvbox
"===-------------------------------------------------------------------------------===
