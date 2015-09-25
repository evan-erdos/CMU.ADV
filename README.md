
CMU.ADV
=======

A "Multi-User Dungeon" (if you think CMU is a dungeon...) Text Adventure!

[![mit-license](http://img.shields.io/:license-MIT-blue.svg?style=plastic)](http://bescott.mit-license.org)

---

```lisp
;CMU.ADV
;An adventure...
;

(adventure cmu 1)

(define welcome
    "That was some party last night... you must have had about twenty
    beers.  Or was it thirty?  As you try to recall, the night becomes
	a giant blur, swimming around and around in your head.  It spins
	faster, and you feel dizzy.  Don't worry, though, you're lying down.
	On the ground...\n
\n
<The CMU adventure, version 1.0>\n
<by Galloway & Kuehner & Pawliger>\n\n")
```

Above are the first few lines of cmu.adv, a file which probably still exists on the CMU afs server. Apparently, a similar attempt at writing a CMU text adventure was made in 1986, in some arcane, lisp-like language.

This is a repository for the soon-to-be coolest text adventure on campus! *CMU.ADV* is written in TADS3, and compiles to a *.t3 format, readable by the [frob](https://github.com/realnc/frobtads "FrobTADS") interpreter.

---
You can play this online! Click the image below!
[![cmu_adv](https://cloud.githubusercontent.com/assets/6759009/9998540/992f043c-605f-11e5-8adc-c47a9f166ded.png)](http://gs.tads.io/?storyfile=http://www.andrew.cmu.edu/user/bescott/cmu.adv/cmu_adv.t3)
---

Todo:
- ~~Add to map~~
- do literally anthing

Todo (Original):

- Need message printing routines that are smart about when messages
   should be printed.  This is to avoid messages like "<noun> taken"
   when non-adventurer actors do things.
   There is already a 'complain' function; I want to add these:
   (error <string>) -- print string and abort if %errmsg,
		       else return nil
   (mesg <string>) --  print message and return normally if %errmsg,
                       else return nil
   (mesg3 <string> <np> <string>) -- etc etc etc as needed
   [ccg]

- ~~add verbose-mode, brief-mode~~
- ~~need verbs: read, run~~
  - yell -> silly message?  maybe do something? echo from frat quad?
  - xyzzy -> ?
  - plugh -> ?
- ~~need nouns: wearable, wear remove, other people~~
- ~~need "hidden" things that only appear after a search.~~
- ~~throw things into other rooms.~~
- ~~get/drop all~~
- weight/volume limits for things.
- jolt cola (silly)

- ~~need read verb (property readable?)~~
- fix map around ucc and warner
- ~~make go in action~~
- ~~Each building should have an `outside' and then you go in.~~
- ~~cop shouldn't wait so long.~~

- phone # for pizza place. 687-1189  (who else?)
- clock minutes messed up
- can't read watch
- have door in entropy supply only open every ten minutes to get clerk away.
- ~~How put things in each other?~~
- At dread.  Say, there is dread here, and pick it u?
- buggy hazard on frew?
- clawed crate in basement of maggie mo?
- rotc marchers?
- basement level z in HH, hacker room? need chip to get there from chip lab.
- old wean cave?
- sei people as paranoids.
- dick cyert
- financial aid people chasing
- frat quad gazorching
- mudslide in IM field
- hideous sculpture behind warner holding a clue
- pitt student
- o's?
- steam tunnels
- clue in tower atop HH, hard to get to.
- physical plant abuse - manure?
- check `traditions' in freshman word.
- Get paint thinner and strip fence - must be night - add timed events?  Each - entry loop
- increments a timer? and find clue.
	--I will implement timed events Real Soon Now [ccg]
- get a tool from buggy builders in exchange for a midget?
- go to cluster, log in and play this game recursively?

- tartan food as weapon
- Panther Hollow Diving Club sign
- abuse Jay Libove? (not in release version)
	--how about secret verb (like 'be wizard') for
	--things like this? [ccg]

- lookup any book in hunt library (on computer) but can't find it on shelf
- most workstations say "Vice 1 through 53 are down"
- workstation with teeny print.. unreadable
- wean hall 9th floor.. get key from someone
	----Access from Elevator on DH end of wean or, from DH roof. [SGW]
- love of two oranges is alien pod/other weirdness
- tar pits
- doherty ceramic labs
- glycol spray and explosions in ucc
- banner letters useful
- RAIN
- stuff in CFA
	--Working on Descriptions (sorry I couldn't get to it later)  [SGW]
- spring carnival?
- badges instead of keys to get around?
- find floppy disk- does it go in RT or PC? (or both?) (or neither?)
- ~~redo, again on command~~
- ~~if command ambiguous,  method to tell which one in next command~~

- elevator in wean - use fedba1 chip to get to steam tunnels?  Or via HH?  Close - manhole on tunnel and get out somewhere else?

- ladder in ph closet - method climb passes move up to actor
- Banner by skibo.  Tie to ladder, still can walk away.  Should confirm.
- The banner is tied to the ladder.  Also, if banner dropped and say tie banner says don't know which banner
