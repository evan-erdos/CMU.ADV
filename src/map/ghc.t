/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-20 * GHC */
/* Jocelyn Huang * jocelynh@andrew.cmu.edu * 2015-11-21 * GHC */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"
#pragma newline_spacing(preserve)


ghc : Area 'The Gates Hillman Center'
['''
You hear a noise, just kidding. It's very quiet.
''','''
You stop in place for a moment, turn <<one of>>180<<or>>135<<or>>90<<at random>> degrees, and find yourself facing the direction you wanted to be facing.
''']
"""
The layout of this building is unusual, as it was designed to have no right angles in the floor plan. You have a hard time keeping your bearings.
""";


/**************<Floor 9>***************/

ghc_9_entrance : AreaRoom -> ghc '9th Floor'
"""
It's the elevator part. It's like all the other elevator parts, except for this one is on the 9th floor.
""" {
    in = ghc_9_elevator;
    west = ghc_9_window;
}

ghc_9_window : AreaRoom -> ghc '9th Floor, Alcove'
"""
You find yourself in a corner alcove, arranged around a full-height window. Whats more, it's sunset: warm clouds frame the Cathedral of Learning, as lights blink in the hills beyond.
""" {
    east = ghc_9_entrance;
}

/**************<Floor 5>***************/

ghc_5_entrance : AreaRoom -> ghc '5th Floor'
"""
It's the fifth floor common area. It's where the plebians who can't get to the upper floors sit. To your east lies the eternally overcrowded Citadel Commons. The elevator is here, and the Pausch Bridge leads out. The Helix is to your west, if you want to waste some time meandering down the spiral.
""" {
    east = ghc_citadel_commons;
    west = ghc_helix_5;
    in = ghc_5_elevator;
    out = pausch_bridge_2;
}

ghc_citadel_commons : AreaRoom -> ghc 'Citadel Commons'
"""
It's crowded here as always, and people are chattering about everything from graph theory to frogs. Eyeballing the crowd, you estimate that about fifteen different classes are holding TA Office Hours here at once, or everyone is here for 112. You'd be hard-pressed to find anywhere to sit.

A sad-looking TA sits at an especially crowded table, where everyone is ignoring her.
""" {
    west = ghc_5_entrance;
}

/**************<Floor 4>***************/

ghc_4_entrance : AreaRoom -> ghc '4th Floor, Helix'
"""
You have wandered over to the area near the Helix on the fourth floor. There is not much here, except for some offices, classrooms that are a bit too small for the crowds that CS office hours tend to draw, and a bulletin board. A particularly interesting event called <b>Demosplash</b> is advertised, and you make a mental note to visit the site: <b>"www.demosplash.org"</b>. You can hear quiet murmuring from the common area to the east, and you briefly consider walking into the Helix.
""" {
    east = ghc_4_common_area;
    in = ghc_helix_4;
}

ghc_4_common_area : AreaRoom -> ghc '4th Floor, Common Area'
"""
The tables down here are packed, mostly with international students chattering and chowing down on sketchy back-of-van Chinese food that some family sells out near the back entrance of Gates sometimes. You peer through the window of Rashid Auditorium to your north and see that a 15-251 lecture seems to be in progress. Ahh, the smell of burning CS (and non-CS) students. To your west lies the entrance to the Helix. There is an elevator here.
""" {
    north = ghc_rashid;
    west = ghc_4_entrance;
    in = ghc_4_elevator;
    out = ghc_4_entrance;
}

ghc_rashid : AreaRoom -> ghc 'Rashid Auditorium'
"""
The biggest lecture hall in the GHC. You seem to have walked in on a 15-251 lecture, which you remember crying through a lot of. Sure enough, some freshmen in the back row are weeping quietly whilst diligently copying down some cellular automata.

An especially sad student cries silently by himself.
""" {
    out = ghc_4_common_area;
}

/**************<Floor 3>***************/

ghc_3_entrance : AreaRoom -> ghc '3rd Floor'
"""
It's the third floor, home of Tazza, which is home of wonderful brownies, which are home to probably way too much sugar for anyone who wants a working pancreas. Oh, and the mysterious Gates 3K cluster. The elevator is here, as is the Helix to your east.
""" {
    in = ghc_3_elevator;
    east = ghc_helix_3;
    southeast = gates_3k;
    south = tazza_d_oro;
}

tazza_d_oro : AreaRoom -> ghc '''Tazza d' Oro'''
"""
Here is the source of an empirically proven 97% of the good smells in Gates. Brownies, cookies, coffee, tea, paninis... From sizzling grills to baked goods, it's got it all. If only they didn't want you to sell your firstborn child to afford any food, it's so prohibitively expensive.
""" {
    in = gates_3k;
    north = ghc_3_entrance;
}

gates_3k : AreaRoom -> ghc 'Gates 3K'
"""
The fabled and unofficially favored lounge of KGB members, masquerading as just another Gates cluster. The first thing that strikes you is the abundance of floor-to-ceiling whiteboards that are covered in drawings, quotes, and other interesting doodles that range from Picasso to stick figure. People with outlandishly dyed hair click furiously at their mice and murmur to each other.
""" {
    out = tazza_d_oro;
}

/**************<Floor 1>***************/

ghc_1_entrance : AreaRoom -> ghc '1st Floor'
"It's the first floor. You're not sure what goes on here. " {
    in = ghc_1_elevator;
    out = ghc_1_root;
}

ghc_1_root : FakeConnector "You're not sure you WANT to know what goes on here, either. ";

/* begin elevator */

ghc_elevator : Area 'GHC Elevator' 'the elevator'
"""
This is the GHC Elevator, with service to probably all the floors. It has never done you wrong. You are close personal friends with this elevator, whatever, just pick a floor.
""";

ghc_9_elevator : AreaRoom -> ghc_elevator '9th Floor' {
    out = ghc_9_entrance;
    down = ghc_5_elevator;
}

ghc_5_elevator : AreaRoom -> ghc_elevator '5th Floor' {
    out = ghc_5_entrance;
    up = ghc_9_elevator;
    down = ghc_4_elevator;
}

ghc_4_elevator : AreaRoom -> ghc_elevator '4th Floor' {
    out = ghc_4_common_area;
    up = ghc_5_elevator;
    down = ghc_3_elevator;
}

ghc_3_elevator : AreaRoom -> ghc_elevator '3rd Floor' {
    out = ghc_3_entrance;
    up = ghc_4_elevator;
    down = ghc_1_elevator;
}

ghc_1_elevator : AreaRoom -> ghc_elevator '1st Floor' {
    out = ghc_1_entrance;
    up = ghc_3_elevator;
}

+ ghc_button : Fixture
'(small) button/switch/thing' 'button'
"""
There's a small button, just like the rest of them, hidden in plain sight on the metal frame of this floor's elevator frame.
""" {
    achievement : Achievement { +3 "finding the secret elevator button!"; }
}

/* end elevator */

/* start helix */

ghc_helix : Area 'Gates Helix' 'the Helix'
['''
Peering over the railing gives you a nice view of Tazza d'Oro and its corresponding tables, which are completely occupied by students or crumbs, or both.
''','''
The smell of coffee and cookies tempts you from below.
''','''
You can hear the occasional whirring of coffeemakers, emanating from below.
''']
"""
This is the Gates Helix. The smell of freshly brewed coffee and baked goods waft up from <i>Tazza d' Oro</i>, and when you look down over the wooden railing you can see students bustling around and making Paninis.
""";


ghc_helix_5 : AreaRoom -> ghc_helix '5th Floor'
"""
You can continue down the Helix, or go back to the entrance of the fifth floor.
""" {
    down = ghc_helix_4;
    east = ghc_5_entrance;
    out = ghc_5_entrance;
}

ghc_helix_4 : AreaRoom -> ghc_helix '4th Floor'
"""
From here, you can disembark from the Helix Wild Ride™, or go up or down.
""" {
    up = ghc_helix_5;
    down = ghc_helix_overlook;
    out = ghc_4_entrance;
}

ghc_helix_overlook : AreaRoom -> ghc_helix '3rd Floor Overlook'
"""
You're along the helix, between the 3rd and 4th floors.
""" {
    up = ghc_helix_4;
    down = ghc_helix_3;
}

+ ghc_helix_projector : Fixture
'projector/projection/video' 'the Projector'
"""
A projector nearly directly under you is playing some student-created clip of a moonrise. After a few seconds, the animation starts glitching out and jerking madly. You should probably move on.
""";


ghc_helix_3 : AreaRoom -> ghc_helix '3rd Floor'
"""
You are at the bottom of the Helix. Peering over the railing gives you a nice view of Tazza d'Oro and its corresponding tables, which are completely occupied by students or crumbs, or both.
""" {
    up = ghc_helix_overlook;
    west = ghc_3_entrance;
    out = ghc_3_entrance;
}

/* end helix */







