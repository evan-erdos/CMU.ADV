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
"It's the fifth floor common area. It's where the plebians who can't get to the upper floors sit. The elevator is here, and the Pausch Bridge leads out. The Helix is to your north, if you want to waste some time meandering down the spiral." {
    north = ghc_helix_5;
    in = ghc_5_elevator;
    out = pausch_bridge_2;
}

ghc_4_entrance : Room 'The Gates Hillman Center (Helix Area, 4th Floor)' 'fourth floor' /** **/
"You have wandered over to the area near the Helix on the fourth floor. There is not much here, except for offices and classrooms that are a bit too small for the crowds that CS office hours tend to draw, and a bulletin board. A particularly interesting event called <b>Demosplash</b> is advertised, and you make a mental note to visit the site: <b>\"www.demosplash.org\"</b>. You can hear quiet murmuring from the common area to the east, and you briefly consider walking into the Helix." {
    east = ghc_4_common_area;
    in = ghc_helix_4;
}

ghc_4_common_area : Room 'The Gates Hillman Center (Common Area, 4th Floor)' 'fourth floor' /** **/
"The tables down here are packed, mostly with international students chowing down on sketchy back-of-van Chinese food that some family sells out near the back entrance of Gates sometimes. You can see Rashid Auditorium to your north, where a 15-251 lecture seems to be in progress. Ahh, the smell of burning CS (and non-CS) students. To your west lies the entrance to the Helix." {
    west = ghc_4_entrance;
    out = ghc_4_entrance;
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

ghc_helix_5 : Room 'Gates Helix (5th Floor)' 'helix'
"You are standing at the top of the Gates Helix. The smell of freshly brewed coffee and baked goods waft up from Tazza, and when you look down over the wooden railing you can see the Tazzagoers bustling around making Paninis. You can continue down the Helix, or go back to the entrance of the fifth floor." {
    down = ghc_helix_4;
    south = ghc_5_entrance;
    out = ghc_5_entrance;
}

ghc_helix_4 : Room 'Gates Helix (4th Floor)' 'helix' /** **/
"You are at the middle of the Helix, wondering why this thing was ever built. You can see an office with a pink inflatable flamingo from here. You can disembark from the Helix Wild Ride (TM) on the fourth floor, or go up or down the Helix." {
    up = ghc_helix_5;
    down = ghc_helix_3;
    out = ghc_4_entrance;
}

ghc_helix_3 : Room 'Gates Helix (3rd Floor)' 'helix' /** **/
"You are at the bottom of the Helix. Peering over the railing gives you a nice view of Tazza d'Oro and its corresponding tables, which are completely occupied by students or crumbs, or both." {
    up = ghc_helix_4;
}

+ ghc_button : Fixture
'button/switch/thing' 'button'
"There's a small button, just like the rest of them, hidden in plain sight on the metal frame of this floor's elevator frame. " {
    achievement : Achievement { +3 "finding the secret elevator button!"; }
}

/* end elevator */