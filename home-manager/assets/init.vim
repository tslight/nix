set autochdir                             "silently change directory for each file
set autoindent                            "retain indentation on next lines
set autoread                              "reload when ext changes detected
set autowriteall                          "auto save when switching buffers
set backspace=indent,eol,start            "allow backspace past indent & eol
set backup                                "turn backups on
set backupdir=~/.cache                    "set backup directory
set clipboard=unnamedplus                 "allow copy/pasting to clipboard
set directory=~/.cache                    "set swap file directory
set expandtab                             "make tabs spaces
set history=4242                          "increase history
set hlsearch                              "highlight all matches
set ignorecase                            "ignore case in all searches...
set incsearch                             "lookahead as search is specified
set nohlsearch                            "turn off search highlight
set nomousehide                           "stop cursor from disappearing
set nowrap                                "turn line wrap off
set relativenumber                        "relative line numbers are awesome
set ruler                                 "turn on line & column numbers
set scrolloff=5                           "scroll when 5 lines from bottom
set shiftround                            "always indent to nearest tabstop
set shiftwidth=4                          "backtab size
set showcmd                               "display incomplete commands
set smartcase                             "unless uppercase letters used
set smartindent                           "turn on autoindenting of blocks
set smarttab                              "use shiftwidths only at left margin
set softtabstop=4                         "soft space size of tabs
set spelllang=en_gb                       "spellcheck language
set tabstop=4                             "space size of tabs
set undodir=~/.cache                      "set undo file directory
set undofile                              "turn undos on
set undolevels=4242                       "how far back to go
set wildchar=<tab> wildmenu wildmode=full "more verbose command tabbing
set wildcharm=<c-z>                       "plus awesome wildcard matching

let mapleader = " "

cmap w!! w !sudo tee %<cr>
map <leader>sv :source $MYVIMRC<CR>
map <leader><space> :b#<cr>
map <leader>b :b<space>
map <leader>d :bd<cr>
map <leader>i ggVG=<c-o><c-o>
map <leader>n :bn<cr>
map <leader>p :bp<cr>
map <leader>e :e<space>
map <leader>w :wall<cr>
map <leader>q :q!<cr>
map <leader>tc :tabnew<cr>
map <leader>td :tabclose<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprev<cr>
map <leader>tt :tablast<cr>
