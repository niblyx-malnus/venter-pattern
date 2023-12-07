|%
++  agent
  |=  =agent:gall
  ^-  agent:gall
  !.
  |_  =bowl:gall
  +*  this  .
      ag    ~(. agent bowl)
  ::
  ++  on-poke
    |=  [=mark =vase]
    ~>  %bout.[0 (cat 3 dap.bowl ' +on-poke')]
    =^  cards  agent  (on-poke:ag mark vase)
    [cards this]
  ::
  ++  on-peek
    |=  =path
    ~>  %bout.[0 (cat 3 dap.bowl ' +on-peek')]
    (on-peek:ag path)
  ::
  ++  on-init
    ~>  %bout.[0 (cat 3 dap.bowl ' +on-init')]
    =^  cards  agent  on-init:ag
    [cards this]
  ::
  ++  on-save   ~>(%bout.[0 (cat 3 dap.bowl ' +on-save')] on-save:ag)
  ::
  ++  on-load
    |=  old-state=vase
    ~>  %bout.[0 (cat 3 dap.bowl ' +on-load')]
    =^  cards  agent  (on-load:ag old-state)
    [cards this]
  ::
  ++  on-watch
    |=  =path
    ~>  %bout.[0 (cat 3 dap.bowl ' +on-watch')]
    =^  cards  agent  (on-watch:ag path)
    [cards this]
  ::
  ++  on-leave
    |=  =path
    ~>  %bout.[0 (cat 3 dap.bowl ' +on-leave')]
    =^  cards  agent  (on-leave:ag path)
    [cards this]
  ::
  ++  on-agent
    |=  [=wire =sign:agent:gall]
    ~>  %bout.[0 (cat 3 dap.bowl ' +on-agent')]
    =^  cards  agent  (on-agent:ag wire sign)
    [cards this]
  ::
  ++  on-arvo
    |=  [=wire =sign-arvo]
    ~>  %bout.[0 (cat 3 dap.bowl ' +on-arvo')]
    =^  cards  agent  (on-arvo:ag wire sign-arvo)
    [cards this]
  ::
  ++  on-fail
    |=  [=term =tang]
    ~>  %bout.[0 (cat 3 dap.bowl ' +on-fail')]
    =^  cards  agent  (on-fail:ag term tang)
    [cards this]
  --
--
