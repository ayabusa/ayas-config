" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Add numbers to each line on the left-hand side.
set number

" Enable mouse for selection n all
set mouse+=a

set tabstop=4      " Width of tab character
set shiftwidth=4   " Width for indent operations (like >> and <<)
set noexpandtab    " Use actual tab characters, not spaces
