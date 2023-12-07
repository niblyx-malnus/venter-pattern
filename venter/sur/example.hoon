|%
+$  id     @uv
+$  datum  @t
+$  example-vent
  $@  ~
  $%  [%new-id =id]
      [%dlog log=@t] :: returns the current delete log
  ==
+$  transition
  $%  [%create-datum =id =@t]
      [%delete-datum =id]
  ==
+$  action
  $%  [%create-datum =@t]
      [%delete-datum =id]
      [%create-and-delete =@t]
  ==
--
