/-  spider, *venter
/+  *strandio
=,  strand=strand:spider
^-  thread:spider
|=  arg=vase
=/  m  (strand ,vase)
|^  ^-  form:m
:: process args
::
=/  input=(unit [ship action])  !<((unit [ship action]) arg)
?~  input  (strand-fail %no-arg ~)
=/  [snk=ship axn=action]  u.input
::
;<  our=@p   bind:m  get-our
;<  now=@da  bind:m  get-time
:: define the vent id
::
=/  vid=vent-id  [our now]
:: listen for updates along this path
::
=/  =wire   /vent/(scot %p p.vid)/(scot %da q.vid)
;<  ~       bind:m  (watch wire [snk %venter] wire)
:: poke the agent on snk with the id and action
::
;<  ~       bind:m  (poke [snk %venter] venter-request+!>([vid axn]))
:: if received response, return contents
:: if instantly kicked, automatically ack
::
;<  cage=(unit cage)  bind:m  (take-fact-or-kick wire)
?~  cage  (pure:m !>([%ack ~]))
;<  ~  bind:m  (take-kick wire)
(pure:m q.u.cage)
::
++  take-fact-or-kick
  |=  =wire
  =/  m  (strand ,(unit cage))
  ^-  form:m
  |=  tin=strand-input:strand
  ?+  in.tin  `[%skip ~]
      ~  `[%wait ~]
    ::
      [~ %agent * %fact *]
    ?.  =(watch+wire wire.u.in.tin)
      `[%skip ~]
    `[%done (some cage.sign.u.in.tin)]
    ::
      [~ %agent * %kick *]
    ?.  =(watch+wire wire.u.in.tin)
      `[%skip ~]
    `[%done ~]
  ==
--
