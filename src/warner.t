/* Ben Scott - bescott@andrew.cmu.edu - 2015-09-19 - CMU.ADV - warner */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

warner_entrance : OutdoorRoom 'Warner Hall (Outside)' 'Warner'
"You are standing on a north-south walkway outside Warner Hall. The recently bought marble exterior ($180,000) impresses you beyond words. The cut is nearby, and you see a large black building to the west. " {
	east = cut_north;
	south = cut_walkway_0;
	west = ucc_atrium;
	in = warner_hall;
}

warner_forbes : OutdoorRoom 'Warner Hall (near Forbes Ave.)' 'Warner'
"You are by Warner hall on Forbes Avenue.  You notice the gleaming new marble exterior on the building. A high wall separates you from the building itself. " {
	in : FakeConnector "A high wall stops you from getting to Warner." { }
}

warner_hall : Room 'Warner Hall' 'warner'
"This is Warner Hall. The very air reeks of bureaucracy. You might want to exit. " { out = warner_entrance; }

