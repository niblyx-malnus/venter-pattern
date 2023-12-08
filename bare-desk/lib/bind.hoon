::  bind: agent wrapper to connect your agent to %eyre bindings
::
::    initialize agent-bind somewhere:
::      |%  ++  agent-bind  (agent:bind & ~[[`/path &]])  --
::      +agent:bind accepts a verbosity flag and a list of
::      $binding / force-flag pairs. %.y to forcefully
::      overwrite a binding which already exist
::
::    usage: %-(agent-bind your-agent)
::
/+  server, agentio, default-agent
|%
+$  card  card:agent:gall
::
++  binding-to-cord
  |=  binding:eyre
  ^-  cord
  (rap 3 ?~(site '' u.site) '/' (join '/' path))
::
++  existing
  |=  =bowl:gall
  ^-  (map binding:eyre [duct action:eyre])
  =+  .^  bindings=(list [binding:eyre duct action:eyre])
          %e  /(scot %p our.bowl)/bindings/(scot %da now.bowl)
      ==
  (~(gas by *(map binding:eyre [duct action:eyre])) bindings)
::
++  ours
  |=  =bowl:gall
  ^-  (set binding:eyre)
  =+  .^  bindings=(list [binding:eyre duct action:eyre])
          %e  /(scot %p our.bowl)/bindings/(scot %da now.bowl)
      ==
  %-  ~(gas in *(set binding:eyre))
  %+  murn  bindings
  |=  [=binding:eyre * =action:eyre]
  ^-  (unit binding:eyre)
  ?.  ?=(%app -.action)  ~
  ?.  =(dap.bowl app.action)  ~
  `binding
::
++  bind-cards
  |=  $:  verb=?
          =bowl:gall
          cards=(list card)
          bindings=(list [=binding:eyre force=?])
      ==
  ^-  (list card)
  ?~  bindings
    cards
  =+  i.bindings
  ?:  (~(has in (ours bowl)) binding)
    ~?  >>  verb
      `@t`(rap 3 dap.bowl ': ' (binding-to-cord binding) ' is already bound to us' ~)
    $(bindings t.bindings)
  =/  bound=?  (~(has by (existing bowl)) binding)
  ~?  >>  &(verb bound)
    `@t`(rap 3 dap.bowl ': ' (binding-to-cord binding) ' is already bound to something else' ~)
  ~?  >>  &(verb force bound)   'overriding binding'
  ~?  >>  &(verb !force bound)  'not overriding binding'
  =?  cards  |(force !bound) 
    :_(cards (~(connect ~(pass agentio bowl) /connect) binding dap.bowl))
  $(bindings t.bindings)
::
++  agent
  |=  [verb=? bindings=(list [=binding:eyre force=?])]
  |=  =agent:gall
  ^-  agent:gall
  !.
  |_  =bowl:gall
  +*  this  .
      ag    ~(. agent bowl)
      def   ~(. (default-agent this %|) bowl)
  ::
  ++  on-init
    =^  cards  agent  on-init:ag
    :_(this (bind-cards verb bowl cards bindings))
  ::
  ++  on-save   on-save:ag
  ::
  ++  on-load
    |=  old-state=vase
    =^  cards  agent  (on-load:ag old-state)
    =/  new-cards  (bind-cards verb bowl cards bindings)
    [new-cards this]
  ::
  ++  on-poke
    |=  [=mark =vase]
    ?.  ?=(%handle-http-response mark)
      =^  cards  agent  (on-poke:ag mark vase)
      [cards this]
    =+  !<([eyre-id=@ta pay=simple-payload:http] vase)
    :_(this (give-simple-payload:app:server eyre-id pay))
  ::
  ++  on-peek
    |=  =path
    ^-  (unit (unit cage))
    ?.  ?=([@ %bind *] path)
      (on-peek:ag path)
    ?+    path  [~ ~]
        [%x %bind %our ~]
      :-  ~  :-  ~  :-  %json  !>
      :-  %a
      %+  turn  ~(tap in (ours bowl))
      |=  =binding:eyre
      ^-  json
      [%s (binding-to-cord binding)]
      ::
        [%x %bind %all ~]
      :-  ~  :-  ~  :-  %json  !>
      %-  pairs:enjs:format
      %+  turn  ~(tap by (existing bowl))
      |=  [=binding:eyre * =action:eyre]
      ^-  [@t json]
      :-  (binding-to-cord binding)
      ?-  -.action
        %gen             [%s (crip "desk: {<desk.generator.action>}")]
        %app             [%s (crip "app: {<app.action>}")]
        %authentication  [%s '%authentication']
        %logout          [%s '%logout']
        %channel         [%s '%channel']
        %scry            [%s '%scry']
        %name            [%s '%name']
        %four-oh-four    [%s '%four-oh-four']
        %eauth           [%s '%eauth']
        %host            [%s '%host']
      ==
    ==
  ::
  ++  on-watch
    |=  =path
    ?:  ?=([%http-response *] path)
      [~ this]
    =^  cards  agent  (on-watch:ag path)
    [cards this]
  ::
  ++  on-leave
    |=  =path
    =^  cards  agent  (on-leave:ag path)
    [cards this]
  ::
  ++  on-agent
    |=  [=wire =sign:agent:gall]
    =^  cards  agent  (on-agent:ag wire sign)
    [cards this]
  ::
  ++  on-arvo
    |=  [=wire =sign-arvo]
    ?.  ?=([%eyre %bound *] sign-arvo)
      =^  cards  agent  (on-arvo:ag wire sign-arvo)
      [cards this]
    ~?  >>  verb
      ^-  @t
      ?:  accepted.sign-arvo
        %:  rap  3
          dap.bowl  ': '
          (binding-to-cord binding.sign-arvo)
          ' successfully bound!'
          ~
        ==
      %:  rap  3
        dap.bowl  ': '
        (binding-to-cord binding.sign-arvo)
        ' failed to bind!'
        ~
      ==
    [~ this]
  ::
  ++  on-fail
    |=  [=term =tang]
    =^  cards  agent  (on-fail:ag term tang)
    [cards this]
  --
--
