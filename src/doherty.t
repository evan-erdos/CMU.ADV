/* Ben Scott - bescott@andrew.cmu.edu - 2015-09-20 - CMU.ADV - doherty */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

dh_entrance : OutdoorRoom 'building' 'Doherty Hall (Outside)'
"This is the entrance to Doherty Hall.  Cold, black marble walls rise up above you to meet at a strange ironwork globe set in the ceiling.  Clamshell lights shine dimly upward into the darkness. " {
	east = cut_walkway_1;
	west = dh_1_east;
	in asExit(west);
}

dh_1_east : Room 'doherty' 'Doherty Hall (Atrium)'
"This is the east end of the first floor of Doherty Hall.  Locked classroom and laboratory doors line the hallway, which ends to the west but runs east into the building entrance.  A well-lit stairwell is nearby. " {
	east = dh_entrance;
}

