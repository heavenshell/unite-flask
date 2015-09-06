unite-flask
===========

A unite.vm plugin for Flask.

inspired by basyura's unite-rails and oppara's unite-cake
`unite-rails <https://github.com/basyura/unite-rails>`_
`vim-unite-cake <https://github.com/oppara/vim-unite-cake>`_

Example
-------

.. code::

  nnoremap <silent> [unite]a :<C-u>Unite -buffer-name=files flask/<CR>
  nnoremap <silent> [unite]v :<C-u>Unite -buffer-name=files flask/views<CR>
  nnoremap <silent> [unite]vt :<C-u>Unite -buffer-name=files flask/templates<CR>
  nnoremap <silent> [unite]vm :<C-u>Unite -buffer-name=files flask/models<CR>


Default directory
-----------------
Show default directory structure below.

.. code::

  yourproject/configs
  yourproject/i18n
  yourproject/extensions
  yourproject/templates
  yourproject/utils
  yourproject/forms
  yourproject/models
  yourproject/static
  yourproject/tests
  yourproject/views

If you want define your own project, use ``g:unite_source_flask``.

.. code::

  let g:unite_source_flask = [
    \ {'name': ''         , 'path': ''          },
    \ {'name': 'templates', 'path': '/templates'},
    \ {'name': 'forms'    , 'path': '/forms'    },
    \ {'name': 'models'   , 'path': '/models'   },
    \ {'name': 'static'   , 'path': '/static'   },
    \ {'name': 'tests'    , 'path': '/tests'    },
    \ {'name': 'views'    , 'path': '/views'    },
    \  ]
