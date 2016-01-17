/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-20 * Doherty */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"
#pragma newline_spacing(preserve)


doherty : Area 'Doherty Hall' 'Doherty'
"""
Traditional trimmings adorn these halls. A modicum of wrought-iron decorations frame the marble stairwells and sloped corridors.
""";

dh_entrance : OutdoorRoom, AreaRoom -> campus '1st Floor, East'
"""
Cold, black marble walls rise up above you to meet at a strange ironwork globe set in the ceiling. Clamshell lights shine dimly upward into the darkness.
""" {
    east = cut_walkway_1;
    west = dh_1_east;
    in asExit(west);
}

dh_1_east : AreaRoom -> doherty '1st Floor, East Foyer'
"""
Locked classroom and laboratory doors line the hallway, which ends to the west but runs east into the building entrance.  A well-lit stairwell lies to the south.
""" {
    east = dh_entrance;
    west = dh_1100_1200_area;
    south = dh_stairwell_1_floor_1;
}

dh_1100_1200_area : AreaRoom -> doherty '1st Floor, 1100-1200'
"""
More locked classrooms surround you. A wide flight of stairs leads upward, and behind them is an elevator.
""" {
    up = dh_2_east;
    east = dh_1_east;
    west = dh_east_old_elevator;
}

dh_2_east : AreaRoom -> doherty '2nd Floor, East'
"""
A narrow hallway on the east side expands to a wider one to the west. Locked classrooms lie on either side. You can descend the stairs, helpfully pointed out by a sign. A large lecture hall lies to the south beyond the stairs.
""" {
    down = dh_1100_1200_area;
    west = dh_east_old_elevator;
}

dh_stairwell_1_floor_1 : FakeConnector
"You don't want to go up the stairwell right now. ";

dh_east_old_elevator : FakeConnector
"The elevator looks unsafe. ";
