/-  spider
/+  *strandio
=,  strand=strand:spider
|%
+$  vent-id  (pair @p @da)
++  en-path  |=(vid=vent-id /vent/(scot %p p.vid)/(scot %da q.vid))
++  send-vent-request
  |=  [=req=mark =dock axn=*]
  =/  m  (strand ,vase)
  ^-  form:m
  :: define the vent id
  ::
  ;<  =bowl:strand  bind:m  get-bowl
  =/  vid=vent-id   [our now]:bowl
  :: listen for updates along this path
  ::
  =/  vent-path=path  (en-path vid)
  ;<  ~  bind:m  (watch vent-path dock vent-path)
  :: poke the agent on the destination ship with the vent id and action
  :: (assumes a request is a vent-id and an action)
  ::
  ;<  =req=dais:clay  bind:m  (scry dais:clay /cb/[q.byk.bowl]/[req-mark]) 
  =/  req-cage=cage   [req-mark (vale:req-dais [vid axn])]
  ;<  ~               bind:m  (poke dock req-cage)
  :: if received response, return contents
  :: if instantly kicked, automatically ack
  ::
  ;<  rep-cage=(unit cage)  bind:m  (take-fact-or-kick vent-path)
  ?~  rep-cage  (pure:m !>([%ack ~]))
  ;<  ~  bind:m  (take-kick vent-path)
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
