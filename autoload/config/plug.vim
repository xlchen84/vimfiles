" vim: ft=vim ts=2 sw=2 et

let g:coc_disable_startup_warning = 1
let s:file = expand('<sfile>')
let s:plugins_disabled = uniq(get(g:, 'plugins_disabled', []))

function! config#plug#home() abort
  let vimfiles = fnamemodify(s:file, ':p:h:h:h')
  let plug_home = fnamemodify(vimfiles . '\bundle', ':p:h')
  return get(g:, 'plug_home', plug_home)
endfunction

function! config#plug#new_plugin(repo) abort
  let path = fnamemodify(a:repo, ':p:h')
  let config = expand(path . '/config')
  if filereadable(config)
    let gitdir = fnamemodify(path, ':t')
    if gitdir ==? '.git'
      let lines = readfile(config)
      let origin_section = match(lines, '\[remote "origin"\]')
      if !exists('g:plugins_dict')
        let g:plugins_dict = {}
      endif
      let name = fnamemodify(path, ':h:t')
      if has_key(g:plugins_dict, name)
        call config#debug('plugin {} has been registered.', name)
      else
        let plugin = {}
        let plugin.name = name
        let plugin.url = lines[origin_section + 1][7:]
        let plugin.short = substitute(plugin.url, '.*github.com/\(\S\+/[^.]\+\)\(\.git\)\?', '\1', '')
        let plugin.load = function('config#plug#load_plugin', [], plugin)
        let g:plugins_dict[name] = plugin
        return plugin
      endif
    endif
  endif
endfunction

function! config#plug#load_plugin() dict
  call config#debug('load plugin {}', self.short)
  if index(g:plugins_disabled, self.short) < 0
    call plug#(self.short)
    let self.loaded = v:true
  else
    call config#debug('plugin ' . self.short . ' is disabled')
    let self.loaded = v:false
  endif
endfunction


function! config#plug#list_plugins() abort
  call config#debug('list_plugins')
  let plug_home = config#plug#home()
  let repos = glob(plug_home . '\*\.git', v:true, v:true)
  let g:plugin_list = map(repos, {_, val -> config#plug#new_plugin(val)})
  call config#debug('list_plugins sucess.')
  return g:plugin_list
endfunction

function! config#plug#init() abort
  let plugins = config#plug#list_plugins() 
  call plug#begin(config#plug#home())
  call map(plugins, {_, val -> val.load()})
  call plug#end()
endfunction

