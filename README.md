# the "venter" pattern

Use this pattern to get an immediate response from a poke.

## Important Files
- `/app/venter.hoon`
- `/ted/venter.hoon`
- `/sur/venter.hoon`

## Installation
1. Clone this repo.
2. Boot up a ship (fakezod or moon or whatever you use).
4. `|new-desk %venter` to create a new desk called `%venter`.
5. `|mount %venter` to access the `%venter` desk from the unix command line.
6. At the unix command line `rm -rf [ship-name]/venter/*` to empty out the contents of the desk.
7. `cp -r venter/* [ship-name]/venter` to copy the contents of this repo into your new desk.
8. At the dojo command line `|commit %venter`.
9. Install with `|install our %venter`.

## Test it Out
1. In the dojo, create the helper function:

   `=args |=([=ship axn=*] [%venter %venter-request [ship %venter] axn])`

   (the thread accepts a `[desk mark dock axn=*]`)

2. Now enter `-venter!venter (args our %create-datum 'hello!')`

   You should get a response like: `vent=[%new-id id=0v6.4mje9.todhv.940lu.p1k2d.hqcco]`

3. Check the state of the agent with `:venter +dbug`

   You should see something like: 

   `[%0 data=[n=[p=0v6.4mje9.todhv.940lu.p1k2d.hqcco q='hello!'] l=~ r=~]]`

4. Now try `-venter!venter (args our %delete-datum 0v6.4mje9.todhv.940lu.p1k2d.hqcco)` (using the `id` you received in step 2).

   You should get a response that says: `ack`

5. Check the state of the agent with `:venter +dbug`

   Your state should be empty again: `[%0 data=~]`

## Use in your app
1. Copy `ted/venter.hoon` into your desk.
2. Define the `$vent-id` type as a `(pair @p @da)`.
3. Define the `$request` type as a `(pair vent-id action)` for your action.
4. Create a mark in the `mar` folder corresponding to this `$request` type (you probably will want a mark for `$action` and `$vent`, too).
5. Define your custom `$vent` update type, making sure it has an `[%ack ~]` case.
6. Replicate the request-handling logic in `app/venter.hoon` in your agent.
7. Replicate the `on-watch` subscription logic in `app/venter.hoon` in your agent.
8. Call the `venter` thread with `[your-desk your-request-mark [destination-ship destination-agent] your-action]`.
