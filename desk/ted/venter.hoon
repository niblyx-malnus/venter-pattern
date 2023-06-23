/-  spider, *venter
/+  *strandio
=,  strand=strand:spider
^-  thread:spider
|=  arg=vase
=/  m  (strand ,vase)
|^  ^-  form:m
:: process args
::
=/  input=(unit [desk mark dock *])  !<((unit [desk mark dock *]) arg)
?~  input  (strand-fail %no-arg ~)
=/  [=desk =req=mark =dock axn=*]  u.input
:: define the vent id
::
;<  our=@p   bind:m  get-our
;<  now=@da  bind:m  get-time
=/  vid=vent-id  [our now]
:: listen for updates along this path
::
=/  =wire  /vent/(scot %p p.vid)/(scot %da q.vid)
;<  ~      bind:m  (watch wire dock wire)
:: poke the agent on the destination ship with the vent id and action
:: (assumes a request is a vent-id and an action)
::
;<  =req=dais:clay  bind:m  (scry dais:clay /cb/[desk]/[req-mark]) 
=/  req-cage=cage   [req-mark (vale:req-dais [vid axn])]
;<  ~               bind:m  (poke dock req-cage)
:: if received response, return contents
:: if instantly kicked, automatically ack
::
;<  rep-cage=(unit cage)  bind:m  (take-fact-or-kick wire)
?~  rep-cage  (pure:m !>([%ack ~]))
;<  ~  bind:m  (take-kick wire)
(pure:m q.u.rep-cage)
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
