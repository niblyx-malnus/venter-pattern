/-  spider, *synapse
/+  *ventio, synapse
=>  |%
    +$  state-0  [%0 data=(map id datum)]
    +$  card     card:agent:gall
    +$  dude     dude:gall
    +$  gowl     bowl:gall
    +$  sowl     bowl:spider
    --
=,  strand=strand:spider
^-  thread:spider
|=  arg=vase
=/  m  (strand ,vase)
^-  form:m
::
=/  req=(unit [gowl request])  !<((unit [gowl request]) arg)
?~  req  (strand-fail %no-arg ~)
=/  [=gowl vid=vent-id =mark =noun]  u.req
;<  =vase         bind:m  (unpage mark noun)
;<  =sowl  bind:m  get-bowl
:: only you can command your own %synapse
::
?>  =(src our):gowl
:: scry the whole state
::
=+  .^  state-0  %gx
      /(scot %p our.sowl)/[dap.gowl]/(scot %da now.sowl)/state/noun
    ==
=*  state  -
=*  syn    ~(. synapse [gowl state])
::
|^
?+    mark  (punt [our dap]:gowl mark vase) :: poke normally
    %synapse-vent-read
  (pure:m !>((handle-vent-read:syn !<(vent-read vase))))
  ::
    %synapse-async-create
  =+  !<(cmd=async-create vase)
  ?-    -.cmd
      %tag
    =/  =tag-id  (unique-tag-id name.cmd)
    :: poke %synapse to create tag with new id
    ::
    =+  synapse-tag-command+!>([tag-id %create [name description]:cmd])
    ;<  ~              bind:m  (poke [our dap]:gowl -)
    :: vent the id
    ::
    (pure:m !>(tag-id+tag-id))
    ::
      %pin
    =/  =pin  (unique-pin ship.cmd)
    :: poke %synapse to create tag with new id
    ::
    =+  synapse-pin-command+!>([[ship.cmd pin] %create-pin weight.cmd])
    ;<  ~              bind:m  (poke [our dap]:gowl -)
    :: vent the id
    ::
    (pure:m !>(pin+pin))
  ==
==
++  unique-pin
  |=  =ship
  ^-  pin
  =/  get  (~(get by source) ship)
  |-
  =/  =pin  (sham [now eny]:sowl)
  ?~  get  pin
  ?.  (~(has by weights.u.get) pin)
    pin
  $(now.sowl +(now.sowl))
::
++  unique-tag-id
  |=  name=@t
  |^  `tag-id`(uniquify (tasify name))
  ++  uniquify
    |=  =term
    ^-  tag-id
    ?.  (~(has by tags) [our.sowl term])
      [our.sowl term]
    =/  num=@t  (numb (end 4 eny.sowl))
    $(term (rap 3 term '-' num ~)) :: add random number to end
  ++  numb :: from numb:enjs:format
    |=  a=@u
    ?:  =(0 a)  '0'
    %-  crip
    %-  flop
    |-  ^-  ^tape
    ?:(=(0 a) ~ [(add '0' (mod a 10)) $(a (div a 10))])
  ++  tasify
    |=  name=@t
    ^-  term
    =/  =tape
      %+  turn  (cass (trip name))
      |=(=@t `@t`?~(c=(rush t ;~(pose nud low)) '-' u.c))
    =/  =term
      ?~  tape  %$
      ?^  f=(rush i.tape low)
        (crip tape)
      (crip ['x' '-' tape])
    ?>(((sane %tas) term) term)
  --
--
