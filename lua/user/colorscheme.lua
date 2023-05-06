vim.cmd [[
try
  colorscheme github_dark_tritanopia
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
