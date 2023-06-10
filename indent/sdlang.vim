" Vim indent file for the sdlang language.
" Language:	sdlang
" Maintainer: Alisa Lain
" Last Change:	2023 May 09
" Version:	0.1
"
" Please email me with bugs, comments, and suggestion. Put vim in the subject
" to ensure the email will not be marked has spam.
"

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif

let b:did_indent = 1

" SDL indenting is a lot like the built-in C indenting.
setlocal cindent

let b:undo_indent = "setl cin<"

" vim: ts=8 noet
