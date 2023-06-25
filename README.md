# the "venter" pattern

Use this pattern to get an immediate response from a poke.

## Important Files
- `/app/venter.hoon`
- `/ted/venter.hoon`
- `/lib/ventio.hoon`
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
1. Enter `-venter!venter [%create-datum 'hello!']` in the dojo.

   You should get a response like: `vent=[%new-id id=0v6.4mje9.todhv.940lu.p1k2d.hqcco]`

3. Check the state of the agent with `:venter +dbug`

   You should see: 

   `[%0 data=[n=[p=0v6.4mje9.todhv.940lu.p1k2d.hqcco q='hello!'] l=~ r=~]]`

4. Now, using the `id` you received in step 2, try:

   `-venter!venter [%delete-datum 0v6.4mje9.todhv.940lu.p1k2d.hqcco]`

   You should get a response that says: `ack`

5. Check the state of the agent with `:venter +dbug`

   Your state should be empty again: `[%0 data=~]`

## Use in your app
1. Copy `lib/ventio.hoon` into your desk.
2. Copy and modify `ted/venter.hoon` to suit your needs.
3. Define the `$vent-id` type as a `(pair @p @da)`.
4. Define the `$request` type as a `(pair vent-id action)` for your action.
5. Define your custom `$vent` update type, making sure it has an `[%ack ~]` case.
6. Create marks in the `mar` folder corresponding to `$request`, `$action` and `$vent`.
7. Replicate the request-handling logic in `app/venter.hoon` in your agent.
8. Replicate the `on-watch` subscription logic in `app/venter.hoon` in your agent.
