vim9script

const source_extensions: list<string> = [".c", ".cc", ".cpp"]
const header_extensions: list<string> = [".h", ".hpp"]

def SplitExtension(path: string): list<string>
  return [strpart(path, 0, strridx(path, ".")), strpart(path, strridx(path, "."))]
enddef

def FindExtension(path: string, extensions: list<string>): string
  for extension in extensions
    var possible_path = path .. extension
    if filereadable(possible_path)
      return possible_path
    endif
  endfor
  return ""
enddef

def g:toggle_header#toggle_header()
  var working_directory = getcwd()
  var current_absolute_path = expand("%:p")
  var current_relative_path = strpart(substitute(current_absolute_path, working_directory, "", ""), 1)

  var current_split = SplitExtension(current_relative_path)
  var target_relative_path = ""
  if index(source_extensions, current_split[1]) != -1
    target_relative_path = FindExtension(current_split[0], header_extensions)
  elseif index(header_extensions, current_split[1]) != -1
    target_relative_path = FindExtension(current_split[0], source_extensions)
  endif

  if target_relative_path != ""
    execute("e " .. target_relative_path, "")
  endif
enddef
