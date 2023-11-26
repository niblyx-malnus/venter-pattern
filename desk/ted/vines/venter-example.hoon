/-  *example, spider
/+  *ventio
=,  strand=strand:spider
^-  thread:spider
::
=<
:: a $vine accepts a bowl:gall, vent-id and a cage
:: and returns a shed:khan (a _*form:(strand ,vase))
:: +vine-thread takes a $vine and returns a $thread
::
%-  vine-thread
|=  [=gowl vid=vent-id =mark =vase]
^-  form-m
?+    mark  (just-poke [our dap]:gowl mark vase) :: poke normally
    %example-action
  ?>  =(src our):gowl
  =+  !<(axn=action vase)
  ?-    -.axn
      %create-datum
    :: generate a unique id
    ::
    ;<  =id  bind-m  get-unique-id
    :: poke the %venter-example agent to create the datum
    ::
    =/  =cage  example-transition+!>([%create-datum id t.axn])
    ;<  ~    bind-m  (poke [our dap]:gowl cage)
    :: return the new id
    ::
    (pure-m !>(new-id+id))
    ::
      %delete-datum
    :: delete the datum associated with an id
    :: 
    =/  =cage  example-transition+!>([%delete-datum id.axn])
    ;<  ~    bind-m  (poke [our dap]:gowl cage)
    :: log the deletion of the datum in /delete-log.txt
    ::
    ;<  =sowl                bind-m  get-bowl :: spider bowl
    ;<  data=(map id datum)  bind-m  get-data :: data in agent state
    =/  =datum  (~(got by data) id.axn)       :: get datum
    :: read the current /delete-log.txt file
    ::
    =/  dlog=path  /delete-log/txt
    ;<  =^cage               bind-m  (read-file byk.sowl dlog)
    =+  !<(file=wain q.cage)
    :: append a new line logging the deletion
    ::
    =.  file  
      %+  snoc  file
      %+  rap  3
      :~  (scot %uv id.axn)    ' | '
          (scot %da now.sowl)  ' | '
          datum
      ==
    ;<  ~  bind-m  (mutate-file q.byk.sowl dlog txt+!>(file))
    :: return null
    ::
    (pure-m !>(~))
    :: create and then delete a datum, logging the deletion
    :: (useless, but showcases the utility of "venting" in a "vine")
    ::
      %create-and-delete
    :: create a datum and get the id of the created id
    :: like a poke, but it returns a value
    :: (it also takes a page instead of a cage)
    :: 
    =/  =page  example-action+[%create-datum t.axn]
    ;<  vnt=example-vent  bind-m
      ((vent ,example-vent) [our dap]:gowl page)
    :: delete the datum associated with the created id
    ::
    ?>  ?=(%new-id -.vnt)
    =/  =^page  example-action+[%delete-datum id.vnt]
    ;<  *  bind-m  ((vent ,*) [our dap]:gowl page)
    :: return null
    ::
    (pure-m !>(~))
  ==
==
::
|%
++  get-data
  =/  m  (strand ,(map id datum))
  ^-  form:m
  :: a scry which won't crash %spider; see /lib/ventio.hoon
  (scry-hard ,(map id datum) /gx/venter-example/data/noun)
::
++  get-unique-id
  =/  m  (strand ,id)
  ^-  form:m
  ;<  data=(map id datum)  bind:m  get-data
  ;<  now=@da              bind:m  get-time
  |-
  =/  =id  (sham now)
  ?.  (~(has by data) id)
    (pure:m id)
  $(now (add now ~s0..0001))
--
