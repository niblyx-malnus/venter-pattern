/-  spider, *venter
/+  *strandio, *ventio
=,  strand=strand:spider
^-  thread:spider
|=  arg=vase
=/  m  (strand ,vase)
^-  form:m
=/  axn=(unit action)  !<((unit action) arg)
?~  axn  (strand-fail %no-arg ~)
;<  our=ship  bind:m  get-our
(send-vent-request %venter-request [our %venter] u.axn)
