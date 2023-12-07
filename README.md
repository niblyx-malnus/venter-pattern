### WARNING: README under construction

# the "venter" pattern

## Table of Contents
1. [Important Files](#important-files)
2. [Principles](#principles)
3. [Motivating Use Cases](#motivating-use-cases)
4. [Core Ideas](#core-ideas)
5. [Explaining the Example](#explaining-the-example)
6. [Install and test it out](#install-and-test-it-out)
7. [Use in your app](#use-in-your-app)

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
  - `/ted/tube-warmer.hoon`
- For This Example
  - `/sur/example.hoon`
  - `/app/venter-example.hoon`
  - `/ted/vines/venter-example.hoon`
  - `/ted/test.hoon`
 
## Principles
1. [Agents are state machines](https://urbit.org/blog/io-in-hoon), and this is
   ALL they should be.
2. "Actions" (i.e. things you want an agent to "do" for you) usually involve
   asynchronous computation, especially when the agent interacts with and
   composes with other agents.
3. "Actions" should be able to return a response with meaningful data.
4. Crashes which occur while an "action" is being performed should be
   propagated to whoever called the "action" -- even if the crash occurs in a
   computation which has been delegated to another agent or vane.

## Motivating Use Cases

### Agent-side ID creation
Because writing request-response cycles on urbit is currently effortful,
clumsy, and mildly complicated, it is common  when adding data to an urbit 
"database" to require that a unique ID be
given with a new piece of data, instead of generating a unique ID and returning
it as a response. It would be more convenient on the client side to not have
to worry about the generation of a unique id (or worse, to wait to learn the
new id from a subscription update) and instead to be able to simply create
something and receive a response with the new ID.

![Generating ID Client-Side](https://raw.githubusercontent.com/niblyx-malnus/venter-pattern/main/diagrams/images/generate_ID_client_side.png "Generating ID Client-Side")

The above is the typical scenario for creating a datum with an ID on urbit.

![Generating ID Server-Side; Normal Sync Subscription](https://raw.githubusercontent.com/niblyx-malnus/venter-pattern/main/diagrams/images/server_side_normal_sync.png "Generating ID Server-Side; Normal Sync Subscription")

This can happen as well, where you don't generate an ID from the client, but you try to recognize an incoming update as the datum you created and retrieve the ID from that update.

![Ideal ID Request-Response Cycle](https://raw.githubusercontent.com/niblyx-malnus/venter-pattern/main/diagrams/images/ideal_ID_request_response.png "Ideal ID Request-Response Cycle")

This is the ideal case of generating an ID server-side and immediately returning it.

### Remote crash forwarding to the client
It is common to forward pokes relevant to data hosted on another ship to that
ship. However, in so doing, the client can no longer learn about crashes
related to that poke and only learns of the success or failure of its poke
to the local agent. A full request-response cycle that passes the remote
failure along to the original client would be more ideal.

![Poke Forwarding With Nack](https://raw.githubusercontent.com/niblyx-malnus/venter-pattern/main/diagrams/images/poke_forwarding_nack.png "Poke Forwarding With Nack")
![Ideal Poke Forwarding](https://raw.githubusercontent.com/niblyx-malnus/venter-pattern/main/diagrams/images/ideal_poke_forwarding.png "Ideal Poke Forwarding")

### Arbitrary nesting of complete request-response cycles
Once we can conceive of these complete request-response cycles, we naturally
want to make them available to one another, so one request-response cycle
can call maybe several others, which can call still more, and which always
guarantee either a substantive response or a crash.

## Core Ideas

### Venting

- The [Urbit Precepts](https://urbit.org/blog/precepts) specify that, in Urbit,
  "everything should be CQRS." CQRS stands for Command-Query Responsibility
  Segregation. In other words, Urbit organizes its program interfaces such that
  commands or "actions" are strongly differentiated from the retrieval of data
  from those programs.

- Gall agents satisfy CQRS in that pokes return only a n/ack and substantive
  data can only be retrieved from an agent via scries or subscriptions.

- Urbit's CQRS approach to program interfaces is versatile but can be
  impractical. A simple request-response pattern is often more ideal for
  routine tasks.

- Scries adhere to the request-response pattern, but they are limited.
  They cannot alter any underlying data and they are not well-suited to
  "actions" which require communication and coordination between multiple
  programs.

- The most common approach to creating a request-response cycle which can have
  effects within urbit and which can perform asynchronous communication is
  something we have taken to calling "venting". It's a pattern which exists
  in Eyre and in the `%spider` agent. In the context of a gall agent, it goes
  like this:
  1. Subscribe to a path along which a response is anticipated.
  2. Poke the agent, providing some data about where you are listening for a
     response.
  3. The agent performs the relevant computations, then returns one or more
     facts and a kick on the relevant subscription path.

- We formalize this like so:
  1. Subscribe to a "vent-path" `/vent/[vent-id]` on the agent.
  2. Poke the agent with a `$vent-request`, a pair of a `$vent-id` and your
     action.
  3. The agent performs the relevant computations and returns exactly one fact
     and a kick on the "vent-path". The fact contains a "vent", which is
     defined by the programmer and can be either `~` or a head-tagged union.
     The null case should be interpreted as a simple "ack".

![Venter Pattern](https://raw.githubusercontent.com/niblyx-malnus/venter-pattern/main/diagrams/images/venter_pattern.png "Venter Pattern")

### Introducing Threads
The whole pattern as we have described it is a tangled asynchronous rigmarole
which is tedious to perform directly from a client. By its asynchronous nature
it lends itself to a thread. Threads can be called via Eyre's external API and
are already set up as an intuitive request-response cycle. Therefore we can
call into a dedicated thread which is responsible for making "vent-request" to
agents and returning their responses.

![Venter Thread](https://raw.githubusercontent.com/niblyx-malnus/venter-pattern/main/diagrams/images/venter_thread.png "Venter Thread")

The Thread in this diagram is equivalent to `/ted/venter.hoon`.


### Vines
The idea of vines emerges now from two sources. First, suppose we want agents
in the process of "venting" to be able to make "vent-requests" to other agents.
We have already seen that the simplest way to contain this "venting" logic is
to delegate it to a thread. But we also notice that "venting" may not be the
only asynchronous logic we may want an action to result in. It is common for us
to want an agent to be responsible for an "action" which triggers multiple
asynchronous events. In the most complicated cases, it is already common to
delegate these to a thread. This suggests something interesting: the entire
"vented" logic can be placed in a dedicated thread.

It looks like this:
1. When an agent receives a $vent-request, it forwards it to a dedicated thread.
2. In the thread, we can switch on the "action" like we would in the case of a
   normal poke.
3. The thread returns a "vent". When the agent receives this result in its
   on-arvo, it returns it along the vent-path. If it receives a crash, it
   forwards this too.

If all venting agents do things this way, the result is that arbitrarily nested
"venting" request-response cycles will be guaranteed to either return a
response, to return a crash or to hang (hangs can be avoided with timeouts).
It also allows to start thinking in terms of asynchronous actions that agents
are "responsible for." The thread dedicated to a given agent is called a
"vine".

![Vine](https://raw.githubusercontent.com/niblyx-malnus/venter-pattern/main/diagrams/images/vine.png "Vine")

Our agent delegates the handling of this action to its vine because the vine,
as a thread, makes asynchronous computation much easier to reason about.

## Explaining The Example
`[Description and explanation of the example code, adding, deleting datum, etc]`

## Install and test it out
### Installation
1. Clone this repo.
2. Pull in the [urbit repo](https://github.com/urbit/urbit) submodule:
```
# have `git pull` also get the pinned commit of the Urbit submodule
$: git config --global submodule.recurse true
# init submodule, and then pull it
$: git submodule update --init --recursive
$: git pull
```
3. Boot up a ship (fakezod or moon or whatever you use).
4. `|new-desk %venter` to create a new desk called `%venter`.
5. `|mount %venter` to access the `%venter` desk from the unix command line.
6. At the unix command line `rm -rf [ship-name]/venter/*` to empty out the contents of the desk.
7. `cp -r venter/* [ship-name]/venter` to copy the contents of this repo into your new desk.
8. At the dojo command line `|commit %venter`.
9. Install with `|install our %venter`.

### Test From the Dojo
1. run `-venter!test create-datum+'some text'` in the dojo
2. receive `[%new-id id=0v6.00rd2.b1hl8.q2v45.k5vln.20tit]` with some ID of type `@uv`
3. run `-venter!test delete-datum+0v6.00rd2.b1hl8.q2v45.k5vln.20tit` with that ID
4. receive:
```
: /~tomsug-nalwet-niblyx-malnus/venter/50/delete-log/txt                                                            
[ %dlog                                                   
    log                                                   
  '===============================================================================\0aVENTER EXAMPLE DELETE LOG\0a===============================================================================\0a0v6.00rd2.b1hl8.q2v45.k5vln.20tit | ~2
023.11.29..21.36.54..0bc2 | hello'
]  
```
This shows that the file `/delete-log.txt` has been changed and returns its contents.

### Test From the Client
1. Go to the interface directory.
2. Edit the information `/src/api.ts` in `ship` and in `const urb` to reflect your ship and url setup.
3. Run `npm install`.
4. Run `nom start`.
5. Follow instructions in the interface.

## Use in your app

### Summary
1. Copy `/lib/vent.hoon` and `/lib/ventio.hoon` into your `/lib` directory.
2. Copy `/app/venter-venter.hoon` into your `/app` directory and change its
   name to be `[your-desk-name]-venter.hoon`, then put this name in your
   `desk.bill`.
3. Copy `/ted/venter.hoon` into your `/ted` directory.
4. Copy `/mar/vent-package.hoon`, `/mar/vent-request.hoon` and `/mar/goof.hoon`
   into your `/mar` directory.
5. Create your own marks in the `/mar` directory for your actions, as per usual.
6. Create a file in `/ted/vines` which shares the same name as your agent and
   modify it as described below.
7. Import the `/lib/vent.hoon` library into your agent and add `%-  agent:vent`
   immediately above or below where you typically put `%-  agent:dbug`.
8. Copy `/ted/tube-warmer.hoon` into your `/ted` directory.
9. Copy `/sur/spider.hoon`, `/lib/strand.hoon` and `/lib/strandio.hoon` into
   your `/sur` and `/lib` directories respectively.
10. Copy `/mar/thread-done.hoon`, `/mar/thread-fail.hoon` and `/mar/tang.hoon`
    into your `/mar` directory.

### The Libraries
Copy `/lib/vent.hoon` and `/lib/ventio.hoon` into your `/lib` directory.
- `/lib/vent.hoon` is a library which contains an agent transformer and some
helpers which you can apply to any agent in which you want to implement the
venter pattern.
- `/lib/ventio.hoon` contains most of the actual venting logic and some strand
functions that extend `/lib/strandio.hoon`.

### The %venter Agent
Copy `/app/venter-venter.hoon` into your `/app` directory and change its name
to be `[your-desk-name]-venter.hoon`, then put this name in your `desk.bill`.
`/app/[your-desk-name]-venter.hoon` is responsible for making sure `vent-id`s
are unique so that requests to the same agent from the same thread don't get
confused. Would it be nice to have a single canonical `%venter` agent?
Probably. Will this happen tomorrow? No. Would this be a hurdle to the adoption
and improvement of this pattern? Yes. Therefore, keep your own desk-specific
venter agent. This way it will never conflict with other venter agents that
adhere to this convention.

### Client Utilities
Copy `/ted/venter.hoon` into your `/ted` directory. This allows you to easily
make vent-requests to agents from the frontend and receive json responses.

### The Vent Marks
Copy `/mar/vent-package.hoon`, `/mar/vent-request.hoon` and `/mar/goof.hoon`
into your `/mar` directory. `vent-package.hoon` is a mark for the data
structure you give to the `/ted/venter.hoon` thread to make a `vent-request`
from the client. `vent-request.hoon` is a mark for the `vent-request` itself.
`goof.hoon` is a mark for the output of a typical crash report.

### Your Own Action and Vent Marks
Create your own marks in the `/mar` directory for your actions, as per usual.
Create your own marks for the `vent`s, i.e. the responses you want to return.
By convention `vent`s should be either `~` or a head-tagged union.

### Vines
Create a file in `/ted/vines` which shares the same name as your agent. If
your agent is in `/app/some-agent.hoon`, then your vine must be
`/ted/vines/some-agent.hoon`. Import the `ventio` library. You can write your
thread as a thread that takes a `[bowl:gall vent-id cage]` instead of a `vase`
and then pass it to `ventio`'s `vine-thread` function. The vine should return
a `vent` (`~` or head-tagged union, for which you have a mark).

### Modifying Your Agent
Import the `/lib/vent.hoon` library into your agent and add `%-  agent:vent`
immediately above or below where you typically put `%-  agent:dbug`.

### `+just-poke`s and `+poke-to-vent`s
If you want a poke to be redirected to a vine, add
`vnt  ~(. (utils:vent this) bowl)` under your agent's `+*  this  .` and use
`(poke-to-vent:vnt mark vase)`. If you want a `vent-request` in your
`/ted/vines/[agent-name].hoon` to simply poke an agent and do nothing else,
use the `(just-poke dock mark vase)` to poke the agent and return a `~` on
success. If you use these in tandem, take care not to create infinite loops.

### Tube Warming
Copy `/ted/tube-warmer.hoon` into your `/ted` directory. Because this pattern
involves a lot of mark conversions, performance is significantly improved when
these conversions are already built and available. The `[desk]-venter` agent
runs the `tube-warmer` thread everytime the desk changes.

### Dependencies
- Copy `/sur/spider.hoon`, `/lib/strand.hoon` and `/lib/strandio.hoon` into your 
  `/sur` and `/lib` directories respectively.
- Copy `/mar/thread-done.hoon`, `/mar/thread-fail.hoon` and `/mar/tang.hoon`
  into your `/mar` directory. These are useful thread related marks. These
  should be the same as the ones in `%base`. (These may have once been actively
  used as part of the venter pattern, they're not anymore...)
  
### Constraints
- The venter agent must be named `%[your-desk]-venter`.
- The `vine` associated with your agent must be in the `/ted/vines` directory
  and it must have the same name as its corresponding agent.

## Interfacing From the Client
`/interface/src/api.ts` shows how to create a simple API for venting from
an agent.
