/* Ben Scott * bescott@andrew.cmu.edu * 2016-01-16 * WEAN */
/* Jocelyn Huang * jocelynh@andrew.cmu.edu * 2016-01-26 * WEH Rooms */

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
You stand in the shadow of the most disgusting building on campus. A cheeto used to occupy this space.
""" {
    out = mall_west;
    north = wh_5000_elev;
    in = wh_5000_elev;
}

//******************<WEH 5th Floor>**********************

wh_5000_elev : AreaRoom -> wean '5000 Area, Near Elevators'
"""
You're just inside the entrance. Two elevators are before you, and hallways run past them, into the concrete wings of the turtle-shaped building. La Prima lies to your east.
""" {
	north = wh_5000_stairs;
	east = la_prima;
    south = wh_entrance;
    out = wh_entrance;
    //in for elevators?
}

wh_5000_stairs : AreaRoom -> wean '5000 Area, Near Stairs'
"""
You're in the slightly cramped area in between the stairs and the bathrooms on the fifth floor. Several students are banging their fists on the tired and weary printer, which staunchy refuses to spit out their documents.

The 5200 corridor is to your west, and the 5300 corridor lies to your east. To your south lies the elevator and entrance area.
""" {
	east = wh_5300;
	south = wh_5000_elev;
}

+ Printer : Fixture
'(Wean) printer' 'printer'
"""
Mostly reliable but sometimes finicky.
"""{
	specialDesc { printer_list.doScript(); }

	printer_list : Ambiance {
	['''
	doopadoop test
	''']
	}
};

la_prima : AreaRoom -> wean '5000 Area, La Prima'
"""
You're just inside the entrance. A long, snaking line of people waiting to buy an assortment of baked goods and caffeine products from La Prima (home of weird carbonated coffee) blocks half of the hallway. You'd consider waiting in line, but the weird Experimental music is driving you nuts. ("GWEEERARARARGHHHHHH" *instrumental screeching* "WAAAAARARRARGH")

The elevators lie to your west, and the WEH 5400 corridor lies to your east.
""" {
	east = wh_5400;
	south = wh_entrance;
	west = wh_5000_elev;
}

// Might move this to separate file later depending on what happens with her.
+ la_prima_employee : Person
	'la prima employee/cashier' '<b>La Prima Employee</b>'
	"""
	A cheerful La Prima employee bustles around trilling out customers' orders to her underlings, who scramble to make coffee.
	""" {
		isHer = true;
		globalParamName = "la prima employee";
	}

++ melee : Thing
'melee/pastry' 'melee'
"""
A delicious pocket of fluffy pastry and Nutella.
""";

++ frizz_coffee : Thing
'frizz/coffee/carbonated coffee' 'cup of frizz coffee'
"""
A cup of bizarre carbonated coffee that stocks rarely and sells out quickly.
""";

//*****<5th Floor Corridors>*****

wh_5100 : FakeConnector
"""
What even happens here? No one knows. Back to the center of Wean 5 you go.
""";

wh_5200 : FakeConnector
"""
Clusters! Classrooms! The suffering of 213 students waiting in ungodly long office hour queues! Let's leave.
""";

wh_5300 : AreaRoom -> wean '5300 Corridor'
"""
Classrooms (including the Computer Club GBM room) line one side of the hallway, while offices line the other. Corkboards line both.

To your east is the weird connecting hallway into Doherty's A-level, and to your west lies the stair area in the central hub of Wean.
""" {
	//east = ...
	west = wh_5000_stairs;
}

wh_5400 : AreaRoom -> wean '5400 Corridor'
"""
This is a place with lecture halls. Computer Club talks take place in one of these classrooms. To your west lies La Prima, near the entrance of Wean. To your east is a weird connecting hallway into Doherty's A-level.
""" {
	//east = ...
	west = la_prima;
}