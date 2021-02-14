let s:hello = yarp#py3('hello')
let g:hello = s:hello
com! HelloSync call s:hello.request('greet')
com! HelloAsync call s:hello.notify('greet')

com! -nargs=1 Hello call s:hello.request(<f-args>)
