# WARNING: README under construction

# the "venter" pattern

## Principles
1. [Agents are state machines](https://urbit.org/blog/io-in-hoon), and this is ALL they should be.
2. "Actions" (i.e. something you want an agent to "do" for you) usually involve asynchronous computation,
   especially when they interact with and compose with other agents.
3. "Actions" should be able to return a response with meaningful data.
4. Crashes which occur while an "action" is being performed should be
   propagated to whoever called the "action" -- even if the crash occurs in a
   computation which has been delegated to another agent or vane.

## The Main Ideas

### Venting
### Vines

## Important Files
- For The Venter Pattern
  - `/lib/ventio.hoon`
  - `/lib/vent.hoon`
  - `/ted/vines/...`
  - `/app/[desk-name]-venter.hoon`
  - `/ted/venter.hoon`
  - `/mar/vent-package.hoon`
  - `/mar/vent-request.hoon`
  - `/mar/goof.hoon`
- For This Example
  - `/sur/example.hoon`
  - `/app/venter-example.hoon`
  - `/ted/vines/venter-example.hoon`

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


## Use in your app
