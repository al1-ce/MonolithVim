" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif

let b:did_indent = 1

" Vala indenting is a lot like the built-in C indenting.
setlocal cindent

let b:undo_indent = "setl cin<"

" vim: ts=8 noet


