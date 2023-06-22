/-  *venter
/+  dbug, verb, default-agent
|%
+$  state-0  [%0 data=(map id datum)]
+$  card  card:agent:gall
--
=|  state-0
=*  state  -
%-  agent:dbug
%+  verb  |
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %|) bowl)
++  on-init
  ^-  (quip card _this)
  `this
++  on-save   !>(state)
::
++  on-load
  |=  ole=vase
  ^-  (quip card _this)
  =/  old=state-0  !<(state-0 ole)
  =.  state  old
  `this
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+    mark  (on-poke:def mark vase)
      %venter-action
    :: unwrapped actions are re-interpreted as requests
    ::
    =/  =request  [[our now]:bowl !<(action vase)]
    =/  =cage     venter-request+!>(request)
    :_(this [%pass / %agent [our dap]:bowl %poke cage]~)
    ::
      %venter-request
    |^
    ?>  =(src our):bowl
    =/  [vid=vent-id axn=action]  !<(request vase)
    :: handle request, then kick the vent subscription
    ::
    =^  cards  state  (handle-request vid axn)
    =/  kick=card  [%give %kick ~[(en-path vid)] ~]
    :_(this (welp cards [kick]~))
    :: process the request and optionally send a vent update
    ::
    ++  handle-request
      |=  [vid=vent-id axn=action]
      ?-    -.axn
        %delete-datum  `state(data (~(del by data) id.axn))
        ::
          %create-datum
        =/  =id  (sham eny.bowl)
        :_  state(data (~(put by data) id t.axn))
        [%give %fact ~[(en-path vid)] venter-vent+!>([%new-id id])]~
      ==
    ++  en-path  |=(vid=vent-id /vent/(scot %p p.vid)/(scot %da q.vid))
    --
  ==
::
++  on-watch
  |=  =(pole knot)
  ^-  (quip card _this)
  ?+    pole  (on-watch:def pole)
      [%vent p=@ q=@ ~]
    ?>  =(src.bowl (slav %p p.pole))
    `this
  ==
  
++  on-leave  on-leave:def
++  on-peek   on-peek:def
++  on-agent  on-agent:def
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--
