/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-20 * CFA */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

cfa_entrance : FakeConnector "It's fucking CFA! Why would you ever even... I mean come ON! " { }

cfa_lot : FakeConnector "You don't want to go to the CFA parking lot! " { }

cfa_park : FakeConnector "You don't want to go to the CFA park! " { }

cfa_field : OutdoorRoom 'CFA (Lawn)' 'the field'
"This is the lawn in front of CFA. The grass here is well-groomed,  except for some strange indentaions in the ground.  The shrubs at the east end have been cleverly arranged to spell \"C-M-U,\" only someone seems to have ripped out the \"U\", leaving a big gap in the hedge." {
    north = cut_south;
    northeast = cfa_lot;
    east = cfa_plaza;
    south = hh_plaza;
    west = cut_walkway_2;

    hedge : Fixture 'hedge/shrub*shrubs/shrubbery/gap' "They're shrubs. " {
        initSpecialDesc = "The shrubs at the east end have been cleverly arranged to spell \"C-M-U,\" only someone seems to have ripped out the \"U\", leaving a big gap in the hedge.";
        //desc { "There seems to be something in the gap where the \"U\" was -- it looks like a bottle of Liquid Paper."; }
    }
}

cfa_plaza : OutdoorRoom 'plaza' 'College of Fine Arts (Plaza)'
"Half-finished, vandalized statues and people with blue hair are strong indications that this must be - no, not Central Park, but the CFA plaza. CFA is to the east and open areas lie around you." {
    north = cfa_lot;
    east = cfa_entrance;
    south = cfa_park;
    west = cfa_field;
}
