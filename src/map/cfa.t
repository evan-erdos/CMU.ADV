/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-20 * CFA */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"
#pragma newline_spacing(preserve)


cfa : Area 'College of Fine Arts' 'CFA'
"""
This is the college of fine arts, where all the art students have their studios. It smells of unworked clay and paints.
""";

cfa_atrium : AreaRoom -> cfa 'Atrium'
"""
This building opens with a grand atrium, sporting a Renaissance-style painted ceiling, and you can see some nice moulding work on the walls of the hallway to the east.
""" {
    east = cfa_hallway;
}

cfa_hallway : FakeConnector "You can't go here yet!";


cfa_lot : FakeConnector
"*jedi hand* You don't want to go to the CFA parking lot. " { }


cfa_park : FakeConnector
"*jedi hand* You don't want to go to the CFA park. " { }


cfa_field : OutdoorRoom
'College of Fine Arts (Lawn)' 'the field'
"""
This is the lawn in front of CFA. The grass here is well-groomed, except for some strange indentaions in the ground.
""" {
    north = cut_south;
    northeast = cfa_lot;
    east = cfa_plaza;
    south = hh_plaza;
    west = cut_walkway_2;
}

+ hedge : Fixture
'(cut) shrubbery/gap/hedge/shrub*shrubs plants' 'hedges'
"They're shrubs. " {
    initSpecialDesc = "The shrubs at the east end have been cleverly arranged to spell <b>C-M-U</b>, only someone seems to have ripped out the <b>U</b>, leaving a big gap in the hedge.";
    specialDesc = "There seems to be something in the gap where the <b>U</b> was -- it looks like a bottle of Liquid Paper.";
}


cfa_plaza : OutdoorRoom
'College of Fine Arts (Plaza)' 'the plaza'
"""
Half-finished, vandalized statues and people with blue hair are strong indications that this must be - no, not Central Park, but the CFA plaza. CFA is to the east and open areas lie around you.
""" {
    north = cfa_lot;
    east = cfa_entrance;
    south = cfa_park;
    west = cfa_field;
}
