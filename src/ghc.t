/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-20 * GHC */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

ghc_9_entrance : Room 'The Gates Hillman Center (9th Floor)' 'the window'
"It's the elevator part. It's like all the other elevator parts, except for this one is on the 9th floor. " {
    in = ghc_9_elevator;
    west = ghc_9_window;
}

ghc_9_window : Room
'The Gates Hillman Center (9th Floor, near Windows)' 'the 9th floor'
"You find yourself in an oddly-angled room, with a study area in a corner alcove, arranged around a full-height window. Whats more, it's sunset: warm clouds frame the Cathedral of Learning, as lights blink in the hills beyond. " {
    east = ghc_9_entrance;
}

ghc_5_entrance : Room 'The Gates Hillman Center (5th Floor)' 'main area'
"It's the fifth floor common area. It's where the plebians who can't get to the upper floors sit. The elevator is here, and the Pausch Bridge leads out. " {
    in = ghc_5_elevator;
    out = pausch_bridge_2;
}

ghc_1_entrance : Room 'The Gates Hillman Center (1st Floor)' 'first floor'
"It's the first floor. You're not sure what goes on here. " {
    in = ghc_1_elevator;
    out = ghc_1_root;
}

ghc_1_root : FakeConnector "You're not sure you WANT to know what goes on here, either. ";

ghc_elevator : object { /* start elevator */
    sharedDesc = "This is the GHC Elevator, with service to probably all the floors. It has never done you wrong. You are close personal friends with this elevator, whatever, just pick a floor. ";
}

ghc_9_elevator : Room
'The Gates Hillman Center (Elevator, 9th Floor)' 'the elevator' {
    desc = ghc_elevator.sharedDesc;
    out = ghc_9_entrance;
    down = ghc_5_elevator;
}

ghc_5_elevator : Room
'The Gates Hillman Center (Elevator, 5th Floor)' 'the elevator' {
    desc = ghc_elevator.sharedDesc;
    out = ghc_5_entrance;
    up = ghc_9_elevator;
    down = ghc_1_elevator;
}

ghc_1_elevator : Room
'The Gates Hillman Center (Elevator, 1st Floor)' 'the elevator' {
    desc = ghc_elevator.sharedDesc;
    out = ghc_1_entrance;
    up = ghc_5_elevator;
}

+ ghc_button : Fixture
'button/switch/thing' 'button'
"There's a small button, just like the rest of them, hidden in plain sight on the metal frame of this floor's elevator frame. " {
    achievement : Achievement { +3 "finding the secret elevator button!"; }
}

/* end elevator */