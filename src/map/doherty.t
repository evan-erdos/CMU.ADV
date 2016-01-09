/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-20 * Doherty */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"
#pragma newline_spacing(preserve)


dh_entrance : OutdoorRoom
'Doherty Hall East 1 (Front Entrance)' 'right outside Doherty'
"""
This is the entrance to Doherty Hall. Cold, black marble walls rise up above you to meet at a strange ironwork globe set in the ceiling. Clamshell lights shine dimly upward into the darkness.
""" {
    east = cut_walkway_1;
    west = dh_1_east;
    in asExit(west);
}

dh_1_east : Room
'Doherty Hall East 1 (Foyer)' 'Doherty Foyer'
"""
This is the east end of the first floor of Doherty Hall.  Locked classroom and laboratory doors line the hallway, which ends to the west but runs east into the building entrance.  A well-lit stairwell lies to the south.
""" {
    east = dh_entrance;
    west = dh_1100_1200_area;
    south = dh_stairwell_1_floor_1;
}

dh_1100_1200_area : Room
'Doherty Hall East 1 (1100-1200 area)' 'the 1100-1200 area'
"""
This is the Doherty 1100-1200 area. More locked classrooms surround you. A wide flight of stairs leads upward, and behind them is an elevator.
""" {
    up = dh_2_east;
    east = dh_1_east;
    west = dh_east_old_elevator;
}

dh_2_east : Room
'Doherty Hall East 2 (Hallway)' 'Doherty 2 East'
"""
You are on the second floor of Doherty East. A narrow hallway on the east side expands to a wider one to the west. Locked classrooms lie on either side. You can descend the stairs, helpfully pointed out by a sign. A large lecture hall lies to the south beyond the stairs.
""" {
    down = dh_1100_1200_area;
    west = dh_east_old_elevator;
}

dh_stairwell_1_floor_1 : FakeConnector
"You don't want to go up the stairwell right now. ";

dh_east_old_elevator : FakeConnector
"The elevator looks unsafe. ";
