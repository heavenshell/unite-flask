let s:save_cpo = &cpo
set cpo&vim

" Variables  "{{{
call unite#util#set_default('g:unite_source_flask_ignore_pattern',
      \'^\%(/\|\a\+:/\)$\|\%(^\|/\)\.\.\?$\|empty$\|\~$\|\.\%(o|pyc|exe|dll|bak|sw[po]\)$')
"}}}
"
function! s:flask_app()
  let dir = finddir("static" , ".;")
  if dir == ""
    return finddir("templates" , ".;")
  endif
  return dir
endfunction

function! s:flask_root()
  let dir = s:flask_app()
  if dir == "" | return "" | endif
  return fnamemodify(dir, ":p:h:h")
endfunction

let s:app = fnamemodify(s:flask_app(), ":t:r")

let s:places = [
      \ {'name': ''         , 'path': ''          },
      \ {'name': 'configs'  , 'path': '/configs'  },
      \ {'name': 'i18n'     , 'path': '/i18n'     },
      \ {'name': 'plugins'  , 'path': '/plugins'  },
      \ {'name': 'templates', 'path': '/templates'},
      \ {'name': 'utils'    , 'path': '/utils'    },
      \ {'name': 'forms'    , 'path': '/forms'    },
      \ {'name': 'models'   , 'path': '/models'   },
      \ {'name': 'static'   , 'path': '/static'   },
      \ {'name': 'tests'    , 'path': '/tests'    },
      \ {'name': 'views'    , 'path': '/views'    },
      \  ]
if exists('g:unite_source_flask')
  s:places = g:unite_source_flask
endif

let s:source = {}

function! s:source.gather_candidates(args, context)
  return s:create_sources(self.path)
endfunction

" flask/command
"   history
"   [command] flask

let s:source_command = {}

function! unite#sources#flask#define()
  return map(s:places,
        \   'extend(copy(s:source),
        \    extend(v:val, {"name": "flask/" . v:val.name,
        \   "description": "candidates from history of " . v:val.name}))')
endfunction

function! s:create_sources(path)
  let root = s:flask_root()
  if root == "" | return [] | end
  let files = map(split(globpath(root . a:path , '**') , '\n') , '{
        \ "name" : fnamemodify(v:val , ":t:r") ,
        \ "path" : v:val
        \ }')

  let list = []
  for f in files
    if isdirectory(f.path) | continue | endif

    if g:unite_source_flask_ignore_pattern != '' &&
          \ f.path =~  string(g:unite_source_flask_ignore_pattern)
        continue
    endif

    call add(list , {
          \ "abbr" : substitute(f.path , root . a:path . '/' , '' , ''),
          \ "word" : substitute(f.path , root . a:path . '/' , '' , ''),
          \ "kind" : "file" ,
          \ "action__path"      : f.path ,
          \ "action__directory" : fnamemodify(f.path , ':p:h:h') ,
          \ })
  endfor
  return list
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
