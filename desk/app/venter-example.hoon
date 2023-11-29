/-  *example
/+  vent, dbug, verb, default-agent
/=  x  /ted/vines/venter-example
/=  x  /ted/test
/=  x  /mar/example/transition
/=  x  /mar/example/action
/=  x  /mar/example/vent
|%
+$  state-0  [%0 data=(map id datum)]
+$  card  card:agent:gall
--
=|  state-0
=*  state  -
:: apply the venter agent transformer
::
%-  agent:vent
%-  agent:dbug
%+  verb  |
^-  agent:gall
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %|) bowl)
    :: use the venter utils to redirect raw pokes to vents
    ::
    vnt   ~(. (utils:vent this) bowl)
::
++  on-init
  ^-  (quip card _this)
  `this
::
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
    %example-action  (poke-to-vent:vnt mark vase)
    ::
      %example-transition
    ?>  =(src our):bowl
    =+  !<(tan=transition vase)
    ?-    -.tan
      %delete-datum  `this(data (~(del by data) id.tan))
      %create-datum  `this(data (~(put by data) [id t]:tan))
    ==
  ==
::
++  on-peek
  |=  =(pole knot)
  ^-  (unit (unit cage))
  ?+    pole  (on-peek:def pole)
    [%x %data ~]  ``noun+!>(data)
  ==
::
++  on-watch  on-watch:def
++  on-leave  on-leave:def
++  on-agent  on-agent:def
++  on-arvo   on-arvo:def
++  on-fail   on-fail:def
--
