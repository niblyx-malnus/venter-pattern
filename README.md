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
1. In the dojo, enter `-venter!venter [our %create-datum 'hello!']`
2. You should get a response like: `vent=[%new-id id=0v6.4mje9.todhv.940lu.p1k2d.hqcco]`
3. Check the state of the agent with `:venter +dbug`
4. You should see something like: `[%0 data=[n=[p=0v6.4mje9.todhv.940lu.p1k2d.hqcco q='hello!'] l=~ r=~]]`
5. Now try `-venter!venter [our %delete-datum 0v6.4mje9.todhv.940lu.p1k2d.hqcco]`
6. You should get a response that says: `ack`
7. Check the state of the agent with `:venter +dbug`
8. Your state should be empty again: `[%0 data=~]`
