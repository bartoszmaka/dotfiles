vim.cmd [[
let g:ycm_lsp_dir = '/Users/bartoszmaka/.repos/lsp-examples'
let g:ycm_language_server = []
let g:ycm_language_server += [
\   { 'name': 'docker',
\     'filetypes': [ 'dockerfile' ],
\     'cmdline': [ expand( g:ycm_lsp_dir . '/docker/node_modules/.bin/docker-langserver' ), '--stdio' ]
\   },
\ ]
let s:pip_os_dir = 'bin'
if has('win32')
  let s:pip_os_dir = 'Scripts'
end

let g:ycm_language_server += [
  \   {
  \     'name': 'cmake',
  \     'cmdline': [ expand( g:ycm_lsp_dir . '/cmake/venv/' . s:pip_os_dir . '/cmake-language-server' )],
  \     'filetypes': [ 'cmake' ],
  \    },
  \ ]
let g:ycm_language_server += [
  \   { 'name': 'vue',
  \     'filetypes': [ 'vue' ],
  \     'cmdline': [ expand( g:ycm_lsp_dir . '/vue/node_modules/.bin/vls' ) ]
  \   },
  \ ]
let g:ycm_language_server += [
  \   { 'name': 'vim',
  \     'filetypes': [ 'vim' ],
  \     'cmdline': [ expand( g:ycm_lsp_dir . '/viml/node_modules/.bin/vim-language-server' ), '--stdio' ]
  \   },
  \ ]
let g:ycm_language_server += [
  \   { 'name': 'purescript',
  \     'filetypes': [ 'purescript' ],
  \     'cmdline': [ expand( g:ycm_lsp_dir . '/purescript/node_modules/.bin/purescript-language-server' ), '--stdio' ]
  \   },
  \ ]
let g:ycm_language_server += [
  \   {
  \     'name': 'angular',
  \     'cmdline': [ 'node' ,
  \        expand( g:ycm_lsp_dir . '/angular/node_modules/@angular/language-server' ),
  \        '--ngProbeLocations',
  \        expand( g:ycm_lsp_dir . '/angular/node_modules/' ),
  \        '--tsProbeLocations',
  \        expand( g:ycm_lsp_dir . '/angular/node_modules/' ),
  \        '--stdio' ],
  \     'filetypes': [ 'ts','html' ],
  \   },
  \ ]
let g:ycm_language_server += [
  \   { 'name': 'kotlin',
  \     'filetypes': [ 'kotlin' ],
  \     'cmdline': [ expand( g:ycm_lsp_dir . '/kotlin/server/build/install/server/bin/server' ) ],
  \   },
  \ ]
let g:ycm_language_server += [
  \   {
  \     'name': 'haskell-language-server',
  \     'cmdline': [ 'haskell-language-server-wrapper', '--lsp' ],
  \     'filetypes': [ 'haskell', 'lhaskell' ],
  \     'project_root_files': [ 'stack.yaml', 'cabal.project', 'package.yaml', 'hie.yaml' ],
  \   },
  \ ]
" Windows: `/path/to/lua-language-server/bin/Windows/lua-language-server.exe`
" Linux: `/path/to/lua-language-server/bin/Linux/lua-language-server`
" macOS: `/path/to/lua-language-server/bin/macOS/lua-language-server`
py3 << EOF
def LuaLSPGetOS():
  import sys
  if sys.platform == 'Windows':
    return "Windows"
  elif sys.platform == 'darwin':
    return 'macOS'
  else:
    return 'Linux'
EOF

let g:ycm_language_server += [
  \   { 'name': 'lua',
  \     'filetypes': [ 'lua' ],
  \     'cmdline': [ expand( g:ycm_lsp_dir . '/lua/lua-language-server/root/extension/server/bin/' . py3eval( 'LuaLSPGetOS()' ) . '/lua-language-server'),
  \                  expand( g:ycm_lsp_dir . '/lua/lua-language-server/root/extension/server/main.lua' ) ]
  \   },
  \ ]
let g:ycm_language_server += [
  \   {
  \     'name': 'bash',
  \     'cmdline': [ 'node', expand( g:ycm_lsp_dir . '/bash/node_modules/.bin/bash-language-server' ), 'start' ],
  \     'filetypes': [ 'sh', 'bash' ],
  \   },
  \ ]
let g:ycm_language_server += [
  \   {
  \     'name': 'json',
  \     'cmdline': [ 'node', expand( g:ycm_lsp_dir . '/json/node_modules/.bin/vscode-json-languageserver' ), '--stdio' ],
  \     'filetypes': [ 'json' ],
  \     'capabilities': { 'textDocument': { 'completion': { 'completionItem': { 'snippetSupport': v:true } } } },
  \   },
  \ ]
let g:ycm_language_server += [
  \   { 'name': 'scala',
  \     'filetypes': [ 'scala' ],
  \     'cmdline': [ 'metals-vim' ],
  \     'project_root_files': [ 'build.sbt' ]
  \   },
  \ ]
let g:ycm_language_server += [
  \   {
  \     'name': 'yaml',
  \     'cmdline': [ 'node', expand( g:ycm_lsp_dir . '/yaml/node_modules/.bin/yaml-language-server' ), '--stdio' ],
  \     'filetypes': [ 'yaml' ],
  \     'capabilities': { 'textDocument': { 'completion': { 'completionItem': { 'snippetSupport': v:true } } } },
  \   },
  \ ]
let g:ycm_language_server += [
  \   { 'name': 'fortran',
  \     'filetypes': [ 'fortran' ],
  \     'cmdline': [ 'fortls' ],
  \   },
  \ ]
let g:ycm_language_server += [
  \   {
  \     'name': 'groovy',
  \     'cmdline': [ 'java', '-jar', expand( g:ycm_lsp_dir . '/groovy/groovy-language-server/build/libs/groovy-language-server-all.jar' ) ],
  \     'filetypes': [ 'groovy' ]
  \   },
  \ ]
let g:ycm_language_server += [
  \   { 'name': 'd',
  \     'filetypes': [ 'd' ],
  \     'cmdline': [ expand( g:ycm_lsp_dir . '/d/serve-d' ) ],
  \   },
  \ ]
let g:ycm_language_server += [
  \   {
  \     'name': 'ruby',
  \     'cmdline': [ expand( g:ycm_lsp_dir . '/ruby/bin/solargraph' ), 'stdio' ],
  \     'filetypes': [ 'ruby' ],
  \   },
  \ ]
let g:ycm_language_server += [
  \   {
  \     'name': 'godot',
  \     'filetypes': [ 'gdscript' ],
  \     'project_root_files': [ 'project.godot' ],
  \     'port': 6008
  \   },
  \ ]
]]
