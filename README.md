# myvimrc

Download vimrc
Move it ~/
Rename it as .vimrc

Change '/home/lhuang' 

```
249 set undodir=/home/lhuang/.vim/undo/
```

to what your home directory.

It seems that it does not support relative path, that is, it does accept "~/"

ctrl+j and ctrl+k is defined switch to next/previous buffer as stated beblow
```
289 " map ctrl+j and k to move to next/previous buffer
290 nnoremap <C-j> :bn<Enter>
291 nnoremap <C-k> :bp<Enter>
```

F4: switch between header and source file, more concisely, .h and .cpp files

Ctrl+N : open window for files/folder exploring

F8: open side window to show class/function

Create your customzied function in vimrc as already defined MyHello

