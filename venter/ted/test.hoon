/-  *example, spider
/+  *ventio
=,  strand=strand:spider
^-  thread:spider
|=  arg=vase
=/  m  (strand ,vase)
^-  form:m
=+  !<(axn=(unit action) arg)
?~  axn  (strand-fail %no-arg ~)
;<  our=@p            bind:m  get-our
;<  vnt=example-vent  bind:m
  ((vent ,example-vent) [our %venter-example] example-action+u.axn)
(pure:m !>(vnt))
