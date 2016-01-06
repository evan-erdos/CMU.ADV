/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-19 * Hammerschlag */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"
#pragma newline_spacing(preserve)


hh_entrance : Room
'Hammerschlag Entrance' 'Hammerschlag'
"""
This is the entrance to Hammerschlag Hall, that tower
of engineering power.  Before you is a corridor leading west to the
stairway that winds its way up inside the former smokestack of the
building.  A small staircase leads up here to the second floor,
and the double doors of the entrance are east.
""" {
    west = hh_1_hall;
    up = hh_2_lounge;
}

hh_1_hall : Room
'Hammerschlag Hall' 'Hammerschlag'
"""
You are in a short hall that leads east-west down
the center of Hammerschlag.  Locked office doors line the hall to the north and south.
There are bulletin boards between every two doors, it seems, crammed with
posters for IEEE meetings, ads for vacation trips to Europe, and class announcements.
""" {
    east = hh_entrance;
    west = hh_1_stairs;
}

+ bulletin_board : Fixture
'board' 'Bulletin Board'
"Leave it alone. It's not important.";


hh_1_stairs : Room
'First Floor Stairwell' 'the first floor'
"""
You are standing near the stairwell that leads up and down into the core of the building.  An ancient IBM clock is set into the wall.  Glass doors lead north and south into laboratory corridors, and the entrance hall goes east from here.
The elevator is also here, but a sign hanging on the button announces that it is
currently out of order.
""" {
    //up = hh_2_stairs;
    //north = hh_1_labs_north;
    //south = hh_1_labs_south;
    east = hh_1_hall;
}

hh_2_lounge : FakeConnector "NOPE! ";

hh_plaza : FakeConnector
"""
"<b>Ah, jeez, Rick, you know, I'm looking around this place, a-and I'm beginning to work up some anxieties about this whole thing. </b>"
""";

