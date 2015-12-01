/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-20 * GHC */
/* Jocelyn Huang * jocelynh@andrew.cmu.edu * 2015-11/21 * GHC */

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
"It's the fifth floor common area. It's where the plebians who can't get to the upper floors sit. To your east lies the eternally overcrowded Citadel Commons. The elevator is here, and the Pausch Bridge leads out. The Helix is to your west, if you want to waste some time meandering down the spiral." {
    east = ghc_citadel_commons;
    west = ghc_helix_5;
    in = ghc_5_elevator;
    out = pausch_bridge_2;
}

ghc_citadel_commons : Room 'The Gates Hillman Center (Citadel Commons)' 'the fifth floor'
"It's crowded here as always, and people are chattering about everything from graph theory to frogs. Eyeballing the crowd, you estimate that about fifteen different classes are holding TA Office Hours here at once, or everyone is here for 112. You'd be hard-pressed to find anywhere to sit." {
    west = ghc_5_entrance;
}

ghc_4_entrance : Room 'The Gates Hillman Center (Helix Area, 4th Floor)' 'fourth floor' /** **/
"You have wandered over to the area near the Helix on the fourth floor. There is not much here, except for some offices, classrooms that are a bit too small for the crowds that CS office hours tend to draw, and a bulletin board. A particularly interesting event called <b>Demosplash</b> is advertised, and you make a mental note to visit the site: <b>\"www.demosplash.org\"</b>. You can hear quiet murmuring from the common area to the east, and you briefly consider walking into the Helix." {
    east = ghc_4_common_area;
    in = ghc_helix_4;
}

ghc_4_common_area : Room 'The Gates Hillman Center (Common Area, 4th Floor)' 'the fourth floor'
"The tables down here are packed, mostly with international students chattering and chowing down on sketchy back-of-van Chinese food that some family sells out near the back entrance of Gates sometimes. You peer through the window of Rashid Auditorium to your north and see that a 15-251 lecture seems to be in progress. Ahh, the smell of burning CS (and non-CS) students. To your west lies the entrance to the Helix. There is an elevator here." {
    north = ghc_rashid;
    west = ghc_4_entrance;
    in = ghc_4_elevator;
    out = ghc_4_entrance;
}

ghc_rashid : Room 'The Gates Hillman Center (Rashid Auditorium)' 'the fourth floor'
"The biggest lecture hall in the GHC. You seem to have walked in on a 15-251 lecture, which you remember crying through a lot of. Sure enough, some freshmen in the back row are weeping quietly whilst diligently copying down some cellular automata." {
    out = ghc_4_common_area;
}

ghc_3_entrance : Room 'The Gates Hillman Center (3rd Floor)' 'the third floor'
"It's the third floor, home of Tazza, which is home of wonderful brownies, which are home to probably way too much sugar for anyone who wants a working pancreas. Oh, and the mysterious Gates 3K cluster. The elevator is here, as is the Helix to your east." {
    in = ghc_3_elevator;
    east = ghc_helix_3;
    //southeast = gates_3k;
    //south = tazza_d_oro;
}

ghc_1_entrance : Room 'The Gates Hillman Center (1st Floor)' 'the first floor'
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
    down = ghc_4_elevator;
}

ghc_4_elevator : Room
'The Gates Hillman Center (Elevator, 4th Floor)' 'the elevator' {
    desc = ghc_elevator.sharedDesc;
    out = ghc_4_common_area;
    up = ghc_5_elevator;
    down = ghc_3_elevator;
}

ghc_3_elevator : Room
'The Gates Hillman Center (Elevator, 3rd Floor)' 'the elevator' {
    desc = ghc_elevator.sharedDesc;
    out = ghc_3_entrance;
    up = ghc_4_elevator;
    down = ghc_1_elevator;
}

ghc_1_elevator : Room
'The Gates Hillman Center (Elevator, 1st Floor)' 'the elevator' {
    desc = ghc_elevator.sharedDesc;
    out = ghc_1_entrance;
    up = ghc_3_elevator;
}

+ ghc_button : Fixture
'button/switch/thing' 'button'
"There's a small button, just like the rest of them, hidden in plain sight on the metal frame of this floor's elevator frame. " {
    achievement : Achievement { +3 "finding the secret elevator button!"; }
}

/* end elevator */

/* start helix */

ghc_helix_5 : Room 'Gates Helix (5th Floor)' 'the Helix'
"You are standing at the top of the Gates Helix. The smell of freshly brewed coffee and baked goods waft up from Tazza, and when you look down over the wooden railing you can see the Tazzagoers bustling around making Paninis. You can continue down the Helix, or go back to the entrance of the fifth floor." {
    down = ghc_helix_4;
    east = ghc_5_entrance;
    out = ghc_5_entrance;
}

ghc_helix_4 : Room 'Gates Helix (4th Floor)' 'the Helix'
"You are at the middle of the Helix, wondering why this thing was ever built. You can see an office with a pink inflatable flamingo from here. You can disembark from the Helix Wild Ride (TM) on the fourth floor, or go up or down the Helix." {
    up = ghc_helix_5;
    down = ghc_helix_overlook;
    out = ghc_4_entrance;
}

ghc_helix_overlook : Room 'Gates Helix (3rd Floor Overlook)' 'the Helix'
"The smell of coffee and cookies tempts you from below. A projector nearly directly under you is playing some student-created clip of a moonrise accompanied by occasional whirring of coffeemakers. After a few seconds, the animation starts glitching out and jerking madly. You should probably move on." {
    up = ghc_helix_4;
    down = ghc_helix_3;
}

ghc_helix_3 : Room 'Gates Helix (3rd Floor)' 'the Helix'
"You are at the bottom of the Helix. Peering over the railing gives you a nice view of Tazza d'Oro and its corresponding tables, which are completely occupied by students or crumbs, or both." {
    up = ghc_helix_overlook;
    west = ghc_3_entrance;
    out = ghc_3_entrance;
}

/* end helix */