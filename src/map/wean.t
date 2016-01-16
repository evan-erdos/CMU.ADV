/* Ben Scott * bescott@andrew.cmu.edu * 2016-01-16 * WEAN */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"
#pragma newline_spacing(preserve)


wean : Area 'Wean Hall' 'Wean'
"""
You are in the embodiment of sadness that is Wean Hall. Concrete walls with bottle-cap sized holes envelop you as you wander through its halls.
""";


wh_entrance : AreaRoom -> wean 'Entrance'
"""
You stand in the shadow of the most disgusting building on campus.
""" {
    down = the_cut;
    west = wh_5000_elev;
}


wh_5000_elev : AreaRoom -> wean '5000 Area, Near Elevators'
"""
You're just inside the entrance. Two elevators are before you, and hallways run past them, into the concrete wings of the turtle-shaped building.
""" {
    east = wh_entrance;
}

