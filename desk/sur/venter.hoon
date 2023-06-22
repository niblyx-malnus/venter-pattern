|%
+$  id       @uv
+$  datum    @t
+$  vent-id  (pair @p @da)
+$  vent
  $%  [%new-id =id]
      [%ack ~]
  ==
+$  action
  $%  [%create-datum =@t]
      [%delete-datum =id]
  ==
+$  request  (pair vent-id action)
--
