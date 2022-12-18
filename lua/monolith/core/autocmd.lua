local cmd = vim.cmd;
local exec = vim.api.nvim_exec  -- execute Vimscript

cmd([[
" Autobind

augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end

" Disable highlight on entering insert
" autocmd InsertEnter * set nohlsearch

" errorformat entries:
"  - Errors from -verrors=spec (ignored)
"  - Uncaught exceptions (e.g., from unit tests)
"  - Errors in string mixins
"  - Normal compile errors
set errorformat^=\%-G\(spec:%*[0-9]\)\ %m
set errorformat^=\%*[^@]@%f\(%l\):\ %m
set errorformat^=\%f-mixin-%*[0-9]\(%l\\,%c\):\ %m
set errorformat^=\%f-mixin-%*[0-9]\(%l\):\ %m
set errorformat^=\%f\(%l\\,%c\):\ %t%*[^:]\:\ %m
set errorformat^=\%f\(%l\):\ %t%*[^:]\:\ %m

" Hide cursor when not in focused window
augroup cursorline
  autocmd!
  autocmd WinEnter,BufEnter * setlocal cursorline
  autocmd WinLeave,BufLeave * setlocal nocursorline
augroup END

" autocmd BufNewFile,BufRead * if getline(1) =~# '#!/usr/bin/env\ dub' | setf perl | endif
]])

--[[
DLang stuff
" Duplicating for "|| a/b/..." output
" Not needed anymore coz of PQF
" set errorformat^=\|\|\ \%f\(%l\\,%c\):\ %m
" set errorformat^=\%f\(%l\\,%c\):\ %m
" set errorformat^=\%f\(%l\):\ %m
]]


-- highlight copy for sec
exec([[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup end
]], false)