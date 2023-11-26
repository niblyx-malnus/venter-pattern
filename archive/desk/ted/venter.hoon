/-  spider
/+  *ventio
=,  strand=strand:spider
^-  thread:spider
|=  arg=vase
=/  m  (strand ,vase)
^-  form:m
=/  pak=(unit package)  !<((unit package) arg)
?~  pak  (strand-fail %no-arg ~)
=+  u.pak :: expose dock, input, output, and body
;<  =page  bind:m  (unpackage body input)
((vent-dyn output) dock page)
