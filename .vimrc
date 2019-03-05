" ***************** 全局设置 ************** "  
" 开启文件类型侦测  
filetype on  
" 根据侦测到的不同类型加载对应的插件  
filetype plugin on  
  
" 自动缩进  
filetype indent on
  
" 开启语法高亮功能  
syntax enable  
" 允许用指定语法高亮配色方案替换默认方案  
syntax on  
set nocompatible "关闭兼容模式
set incsearch "开启实时搜索功能  
set ignorecase "搜索忽略大小写
set wildmenu "vim命令自动补全  
set autoread "文件自动更新
set mouse=a "终端光标定位 
set gcr=a:block-blinkon0 "禁止关闭闪烁  
set laststatus=2 "总是显示状态栏  
set ruler "显示光标位置  
set number "显示行号
set guifont=Menlo\ Regular:h16"设置字体大小  
set cursorline "高亮显示当前行  
"set cursorcolumn "高亮显示当前列  
set hlsearch "高亮显示搜索结果  
"set nowrap "禁止折行 
set backspace=2 "回退键生效  
"set backspace=indent,eol,start  
set novisualbell 
set encoding=utf-8 
  
" 禁止显示滚动条  
set guioptions-=l  
set guioptions-=L  
set guioptions-=r  
set guioptions-=R  
  
" 禁止显示菜单和工具条  
set guioptions-=m  
set guioptions-=T  
  
" 将制表符扩展为空格  
set expandtab  
" 设置编辑时制表符占用空格数  
set tabstop=4  
" 设置格式化时制表符占用空格数  
set shiftwidth=4  
" 让 vim 把连续数量的空格视为一个制表符  
set softtabstop=4  
" 基于缩进或语法进行代码折叠  
set foldmethod=syntax  
" 启动 vim 时关闭折叠代码  
set nofoldenable  
" 交互式打开shell  
set shell=bash\ -i  
  
  
" *************** 设置全局快捷键 *****************  
  
" 定义快捷键的前缀，即<Leader>  
let mapleader=" " 
  
" 设置快捷键将选中文本块复制至系统剪贴板  
vnoremap <Leader>y "+y  
  
" 设置快捷键将系统剪贴板内容粘贴至 vim  
nmap <Leader>p "+p  
  
" 定义快捷键关闭当前分割窗口  
nmap <Leader>q :q<CR>  
  
" 定义快捷键保存当前窗口内容  
nmap <Leader>w :w<CR>  
  
" 定义快捷键保存所有窗口内容并退出 vim  
"nmap <Leader>WQ :wa<CR>:q<CR>  
  
" 不做任何保存，直接退出 vim  
"nmap <Leader>Q :qa!<CR>  
  
" 依次遍历子窗口  
nnoremap nw <C-W><C-W>  
  
" 跳转至右方的窗口  
nnoremap <Leader>l <C-W>l  
  
" 跳转至左方的窗口  
nnoremap <Leader>h <C-W>h  
  
" 跳转至上方的子窗口  
nnoremap <Leader>k <C-W>k  
  
" 跳转至下方的子窗口  
nnoremap <Leader>j <C-W>j  
  
" 定义快捷键在结对符之间跳转  
nmap <Leader>M %  
  
nnoremap <Leader>g <C-]>  
nnoremap <Leader>b <C-t> 

  """"""""""""""""""""""
    "Quickly Run
    """""""""""""""""""""" 

imap <F5> <ESC>:call Compile()<CR>
func Compile()
	exec "w"
	if &filetype == 'c'
		exec "!gcc % -o %<"
	elseif &filetype == "cpp"
		exec "!g++ % -o %<"
	elseif &filetype == 'java' 
		exec "!javac %" 
	endif
endfunc

imap <F6> <ESC>:call CompileRun()<CR>
func CompileRun()
    	exec "w"
    	if &filetype == 'c'
		exec "!gcc % -o %<"
		exec "!./%<"
	elseif &filetype == "cpp"
		exec "!g++ % -o %<"
		exec "!./%<"
	elseif &filetype == 'java' 
		exec "!javac %" 
		exec "!java %<"
	elseif &filetype == 'ruby'
		exec "!ruby %"
	elseif &filetype == 'python'
		exec "!python3 %"
    	elseif &filetype == 'html'
        	exec "call ViewInBrowser(\"gc\")"
	elseif &filetype == 'sh'
		:!zsh %
    	elseif &filetype == 'go'
        	exec "!go build %<"
        	exec "!go run %"
    	elseif &filetype == 'mkd'
        	exec "!~/.vim/markdown.pl % > %.html &"
        	exec "!firefox %.html &"
	endif
endfunc

func ViewInBrowser(name)
    let file = expand("%:p")
    let l:browsers = {
        \"gc":"open -a \"Google Chrome\"",
	\"sfr":"open -a \Safari",
    \}
    let htdocs='/Users/george/'
    let strpos = stridx(file, substitute(htdocs, '\\\\', '\', "g"))
    let file = '"'. file . '"'
    exec ":update " .file
    "echo file .' ## '. htdocs
    exec ":silent ! ". l:browsers[a:name] ." file://". file
endfunc


""""""""""""""""""""""

map <F3> :call SetTitle()<CR> " <F3>与:之间必须有空格
func SetTitle()
    let l = 0
    let l = l + 1 | call setline(l,'#include<iostream>')
    let l = l + 1 | call setline(l,'using namespace std;')
    let l = l + 1 | call setline(l,'int main()')
    let l = l + 1 | call setline(l,'{')
    let l = l + 1 | call setline(l,'    ios::sync_with_stdio(false);')
    let l = l + 1 | call setline(l,'    return 0;')
    let l = l + 1 | call setline(l,'}')
    exec "w"
endfunc

  
" ************** 插件管理与设置 ************ "  
  
" vundle 环境设置  
filetype off  
set rtp+=~/.vim/bundle/Vundle.vim
" vundle 管理的插件列表必须位于 vundle#begin() 和 vundle#end() 之间  
call vundle#begin()  
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-ruby/vim-ruby' 
Plugin 'Lokaltog/vim-powerline' "status 美化
Plugin 'Valloric/YouCompleteMe'
Plugin 'octol/vim-cpp-enhanced-highlight' "对c++语法高亮增强  
Plugin 'majutsushi/tagbar' "taglist的增强版，查看标签，依赖于ctags
Plugin 'scrooloose/nerdcommenter' "多行注释，leader键+cc生成, leader+cu删除注释  
Plugin 'scrooloose/nerdtree' "文件浏览  
Plugin 'kien/ctrlp.vim' "搜索历史打开文件，在命令行模式下按ctrl+p触发  
Plugin 'vim-scripts/grep.vim' "在命令行模式使用grep命令，:Grep  
Plugin 'Lokaltog/vim-easymotion' "快速跳转，按两下leader键和f组合  
Plugin 'vim-scripts/ShowTrailingWhitespace.git' "高亮显示行尾的多余空白字符  
Plugin 'vim-scripts/indentpython.vim.git'   
Plugin 'nathanaelkane/vim-indent-guides.git' "缩进对齐显示  
Plugin 'vim-scripts/indexer.tar.gz' "自动生成标签  
Plugin 'vim-scripts/DfrankUtil' "indexer 依赖  
Plugin 'vim-scripts/vimprj' "indexer 依赖   
Plugin 'vim-scripts/Markdown'  
Plugin 'tpope/vim-surround'  
Plugin 'ekalinin/Dockerfile.vim'
 
" 插件列表结束  
call vundle#end()  
filetype on  
  
" Powerline 设置  
" 设置状态栏主题风格  
let g:Powerline_colorscheme='solarized256'  
  
  
  
" 设置tagbar  
" 设置 tagbar 子窗口的位置出现在主编辑区的左边  
let tagbar_left=1  
" " 设置显示／隐藏标签列表子窗口的快捷键。速记：identifier list by tag  
nnoremap <Leader>t :TagbarToggle<CR>  
" " 设置标签子窗口的宽度  
let tagbar_width=32  
" " tagbar 子窗口中不显示冗余帮助信息  
let g:tagbar_compact=1  
" " 设置 ctags 对哪些代码标识符生成标签  
  
" signature设置  
let g:SignatureMap = {  
        \ 'Leader'             :  "m",  
        \ 'PlaceNextMark'      :  "m,",  
        \ 'ToggleMarkAtLine'   :  "m.",  
        \ 'PurgeMarksAtLine'   :  "m-",  
        \ 'DeleteMark'         :  "dm",  
        \ 'PurgeMarks'         :  "mda",  
        \ 'PurgeMarkers'       :  "m<BS>",  
        \ 'GotoNextLineAlpha'  :  "']",  
        \ 'GotoPrevLineAlpha'  :  "'[",  
        \ 'GotoNextSpotAlpha'  :  "`]",  
        \ 'GotoPrevSpotAlpha'  :  "`[",  
        \ 'GotoNextLineByPos'  :  "]'",  
        \ 'GotoPrevLineByPos'  :  "['",  
        \ 'GotoNextSpotByPos'  :  "mn",  
        \ 'GotoPrevSpotByPos'  :  "mp",  
        \ 'GotoNextMarker'     :  "[+",  
        \ 'GotoPrevMarker'     :  "[-",  
        \ 'GotoNextMarkerAny'  :  "]=",  
        \ 'GotoPrevMarkerAny'  :  "[=",  
        \ 'ListLocalMarks'     :  "ms",  
        \ 'ListLocalMarkers'   :  "m?"  
        \ }  
  
" 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list  
nmap <Leader>f :NERDTreeToggle<CR>
" 打开vim时自动打开NERDTree
" autocmd VimEnter * NERDTree
" 设置NERDTree子窗口宽度  
let NERDTreeWinSize=25
" 设置NERDTree子窗口位置  
let NERDTreeWinPos="left"
" 显示隐藏文件  
let NERDTreeShowHidden=0
" NERDTree 子窗口中不显示冗余帮助信息  
let NERDTreeMinimalUI=1  
" 删除文件时自动删除文件对应 buffer  
let NERDTreeAutoDeleteBuffer=1
" 快捷键映射
map <F4> :NERDTree<CR>
" YCM 补全菜单配色  
" 菜单  
"highlight Pmenu ctermfg=2 ctermbg=3 guifg=#005f87 guibg=#EEE8D5  
" 选中项  
"highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900  
" 补全功能在注释中同样有效  
let g:ycm_complete_in_comments=1  
" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示  
let g:ycm_confirm_extra_conf=0  
" 开启 YCM 标签补全引擎  
let g:ycm_collect_identifiers_from_tags_files=1  
" 引入 C++ 标准库tags  
set tags+=/data/misc/software/misc./vim/stdcpp.tags  
" YCM 集成 OmniCppComplete 补全引擎，设置其快捷键  
"inoremap <leader>; <C-x><C-o>  
" 补全内容不以分割子窗口形式出现，只显示补全列表  
set completeopt-=preview  
" 从第一个键入字符就开始罗列匹配项  
let g:ycm_min_num_of_chars_for_completion=1  
" 禁止缓存匹配项，每次都重新生成匹配项  
let g:ycm_cache_omnifunc=0  
" 语法关键字补全  
let g:ycm_seed_identifiers_with_syntax=1  
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'  
  
  """ color settings  
hi clear

if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="solarized"

if exists("g:solarized_original")
    let s:solarized_original = g:solarized_original
else
    let s:solarized_original = 0
endif


hi Boolean         guifg=#AE81FF
hi Character       guifg=#E6DB74
hi Number          guifg=#AE81FF
hi String          guifg=#E6DB74
hi Conditional     guifg=#F92672               gui=bold
hi Constant        guifg=#AE81FF               gui=bold
hi Cursor          guifg=#000000 guibg=#F8F8F0
hi iCursor         guifg=#000000 guibg=#F8F8F0
hi Debug           guifg=#BCA3A3               gui=bold
hi Define          guifg=#66D9EF
hi Delimiter       guifg=#8F8F8F
hi DiffAdd                       guibg=#13354A
hi DiffChange      guifg=#89807D guibg=#4C4745
hi DiffDelete      guifg=#960050 guibg=#1E0010
hi DiffText                      guibg=#4C4745 gui=italic,bold

hi Directory       guifg=#A6E22E               gui=bold
hi Error           guifg=#E6DB74 guibg=#1E0010
hi ErrorMsg        guifg=#F92672 guibg=#232526 gui=bold
hi Exception       guifg=#A6E22E               gui=bold
hi Float           guifg=#AE81FF
hi FoldColumn      guifg=#465457 guibg=#000000
hi Folded          guifg=#465457 guibg=#000000
hi Function        guifg=#A6E22E
hi Identifier      guifg=#FD971F
hi Ignore          guifg=#808080 guibg=bg
hi IncSearch       guifg=#C4BE89 guibg=#000000

hi Keyword         guifg=#F92672               gui=bold
hi Label           guifg=#E6DB74               gui=none
hi Macro           guifg=#C4BE89               gui=italic
hi SpecialKey      guifg=#66D9EF               gui=italic

hi MatchParen      guifg=#000000 guibg=#FD971F gui=bold
hi ModeMsg         guifg=#E6DB74
hi MoreMsg         guifg=#E6DB74
hi Operator        guifg=#F92672

" complete menu
hi Pmenu           guifg=#66D9EF guibg=#000000
hi PmenuSel                      guibg=#808080
hi PmenuSbar                     guibg=#080808
hi PmenuThumb      guifg=#66D9EF

hi PreCondit       guifg=#A6E22E               gui=bold
hi PreProc         guifg=#A6E22E
hi Question        guifg=#66D9EF
hi Repeat          guifg=#F92672               gui=bold
hi Search          guifg=#000000 guibg=#FFE792
" marks
hi SignColumn      guifg=#A6E22E guibg=#232526
hi SpecialChar     guifg=#F92672               gui=bold
hi SpecialComment  guifg=#7E8E91               gui=bold
hi Special         guifg=#66D9EF guibg=bg      gui=italic
if has("spell")
    hi SpellBad    guisp=#FF0000 gui=undercurl
    hi SpellCap    guisp=#7070F0 gui=undercurl
    hi SpellLocal  guisp=#70F0F0 gui=undercurl
    hi SpellRare   guisp=#FFFFFF gui=undercurl
endif
hi Statement       guifg=#F92672               gui=bold
hi StatusLine      guifg=#455354 guibg=fg
hi StatusLineNC    guifg=#808080 guibg=#080808
hi StorageClass    guifg=#FD971F               gui=italic
hi Structure       guifg=#66D9EF
hi Tag             guifg=#F92672               gui=italic
hi Title           guifg=#ef5939
hi Todo            guifg=#FFFFFF guibg=bg      gui=bold

hi Typedef         guifg=#66D9EF
hi Type            guifg=#66D9EF               gui=none
hi Underlined      guifg=#808080               gui=underline

hi VertSplit       guifg=#808080 guibg=#080808 gui=bold
hi VisualNOS                     guibg=#403D3D
hi Visual                        guibg=#403D3D
hi WarningMsg      guifg=#FFFFFF guibg=#333333 gui=bold
hi WildMenu        guifg=#66D9EF guibg=#000000

hi TabLineFill     guifg=#1B1D1E guibg=#1B1D1E
hi TabLine         guibg=#1B1D1E guifg=#808080 gui=none

if s:solarized_original == 1
   hi Normal          guifg=#F8F8F2 guibg=#272822
   hi Comment         guifg=#75715E
   hi CursorLine                    guibg=#3E3D32
   hi CursorLineNr    guifg=#FD971F               gui=none
   hi CursorColumn                  guibg=#3E3D32
   hi ColorColumn                   guibg=#3B3A32
   hi LineNr          guifg=#BCBCBC guibg=#3B3A32
   hi NonText         guifg=#75715E
   hi SpecialKey      guifg=#75715E
else
   hi Normal          guifg=#F8F8F2 guibg=#1B1D1E
   hi Comment         guifg=#7E8E91
   hi CursorLine                    guibg=#293739
   hi CursorLineNr    guifg=#FD971F               gui=none
   hi CursorColumn                  guibg=#293739
   hi ColorColumn                   guibg=#232526
   hi LineNr          guifg=#465457 guibg=#232526
   hi NonText         guifg=#465457
   hi SpecialKey      guifg=#465457
end

"
" Support for 256-color terminal
"
if &t_Co > 255
   if s:solarized_original == 1
      hi Normal                   ctermbg=234
      hi CursorLine               ctermbg=235   cterm=none
      hi CursorLineNr ctermfg=208               cterm=none
   else
      hi Normal       ctermfg=252 ctermbg=233
      hi CursorLine               ctermbg=234   cterm=none
      hi CursorLineNr ctermfg=208               cterm=none
   endif
   hi Boolean         ctermfg=135
   hi Character       ctermfg=144
   hi Number          ctermfg=135
   hi String          ctermfg=144
   hi Conditional     ctermfg=161               cterm=bold
   hi Constant        ctermfg=135               cterm=bold
   hi Cursor          ctermfg=16  ctermbg=253
   hi Debug           ctermfg=225               cterm=bold
   hi Define          ctermfg=81
   hi Delimiter       ctermfg=241

   hi DiffAdd                     ctermbg=24
   hi DiffChange      ctermfg=181 ctermbg=239
   hi DiffDelete      ctermfg=162 ctermbg=53
   hi DiffText                    ctermbg=102 cterm=bold

   hi Directory       ctermfg=118               cterm=bold
   hi Error           ctermfg=219 ctermbg=89
   hi ErrorMsg        ctermfg=199 ctermbg=16    cterm=bold
   hi Exception       ctermfg=118               cterm=bold
   hi Float           ctermfg=135
   hi FoldColumn      ctermfg=67  ctermbg=16
   hi Folded          ctermfg=67  ctermbg=16
   hi Function        ctermfg=118
   hi Identifier      ctermfg=208               cterm=none
   hi Ignore          ctermfg=244 ctermbg=232
   hi IncSearch       ctermfg=193 ctermbg=16

   hi keyword         ctermfg=161               cterm=bold
   hi Label           ctermfg=229               cterm=none
   hi Macro           ctermfg=193
   hi SpecialKey      ctermfg=81

   hi MatchParen      ctermfg=233  ctermbg=208 cterm=bold
   hi ModeMsg         ctermfg=229
   hi MoreMsg         ctermfg=229
   hi Operator        ctermfg=161

   " complete menu
   hi Pmenu           ctermfg=81  ctermbg=16
   hi PmenuSel        ctermfg=255 ctermbg=242
   hi PmenuSbar                   ctermbg=232
   hi PmenuThumb      ctermfg=81

   hi PreCondit       ctermfg=118               cterm=bold
   hi PreProc         ctermfg=118
   hi Question        ctermfg=81
   hi Repeat          ctermfg=161               cterm=bold
   hi Search          ctermfg=0   ctermbg=222   cterm=NONE

   " marks column
   hi SignColumn      ctermfg=118 ctermbg=235
   hi SpecialChar     ctermfg=161               cterm=bold
   hi SpecialComment  ctermfg=245               cterm=bold
   hi Special         ctermfg=81
   if has("spell")
       hi SpellBad                ctermbg=52
       hi SpellCap                ctermbg=17
       hi SpellLocal              ctermbg=17
       hi SpellRare  ctermfg=none ctermbg=none  cterm=reverse
   endif
   hi Statement       ctermfg=161               cterm=bold
   hi StatusLine      ctermfg=238 ctermbg=253
   hi StatusLineNC    ctermfg=244 ctermbg=232
   hi StorageClass    ctermfg=208
   hi Structure       ctermfg=81
   hi Tag             ctermfg=161
   hi Title           ctermfg=166
   hi Todo            ctermfg=231 ctermbg=232   cterm=bold

   hi Typedef         ctermfg=81
   hi Type            ctermfg=81                cterm=none
   hi Underlined      ctermfg=244               cterm=underline

   hi VertSplit       ctermfg=244 ctermbg=232   cterm=bold
   hi VisualNOS                   ctermbg=238
   hi Visual                      ctermbg=235
   hi WarningMsg      ctermfg=231 ctermbg=238   cterm=bold
   hi WildMenu        ctermfg=81  ctermbg=16

   hi Comment         ctermfg=59
   hi CursorColumn                ctermbg=236
   hi ColorColumn                 ctermbg=236
   hi LineNr          ctermfg=250 ctermbg=236
   hi NonText         ctermfg=59

   hi SpecialKey      ctermfg=59

   if exists("g:rehash256") && g:rehash256 == 1
       hi Normal       ctermfg=252 ctermbg=234
       hi CursorLine               ctermbg=236   cterm=none
       hi CursorLineNr ctermfg=208               cterm=none

       hi Boolean         ctermfg=141
       hi Character       ctermfg=222
       hi Number          ctermfg=141
       hi String          ctermfg=222
       hi Conditional     ctermfg=197               cterm=bold
       hi Constant        ctermfg=141               cterm=bold

       hi DiffDelete      ctermfg=125 ctermbg=233

       hi Directory       ctermfg=154               cterm=bold
       hi Error           ctermfg=222 ctermbg=233
       hi Exception       ctermfg=154               cterm=bold
       hi Float           ctermfg=141
       hi Function        ctermfg=154
       hi Identifier      ctermfg=208

       hi Keyword         ctermfg=197               cterm=bold
       hi Operator        ctermfg=197
       hi PreCondit       ctermfg=154               cterm=bold
       hi PreProc         ctermfg=154
       hi Repeat          ctermfg=197               cterm=bold

       hi Statement       ctermfg=197               cterm=bold
       hi Tag             ctermfg=197
       hi Title           ctermfg=203
       hi Visual                      ctermbg=238

       hi Comment         ctermfg=244
       hi LineNr          ctermfg=239 ctermbg=235
       hi NonText         ctermfg=239
       hi SpecialKey      ctermfg=239
   endif
end

" Must be at the end, because of ctermbg=234 bug.
" https://groups.google.com/forum/#!msg/vim_dev/afPqwAFNdrU/nqh6tOM87QUJ
set background=dark
  
" indent guides  
"let g:indent_guides_enable_on_vim_startup=1  
" 从第二层开始可视化显示缩进  
let g:indent_guides_start_level=2  
"let g:indent_guides_auto_colors = 0  
"hi IndentGuidesOdd  guibg=red   ctermbg=3  
"hi IndentGuidesEven guibg=green ctermbg=4  
" 色块宽度  
let g:indent_guides_guide_size=1  
" 快捷键 i 开/关缩进可视化  
noremap <Leader>sj :IndentGuidesToggle<CR>
