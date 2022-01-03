vim9script

if exists("g:loaded_toggle_header")
  finish
endif
g:loaded_toggle_header = 1

command! ToggleHeader call g:toggle_header#toggle_header()
