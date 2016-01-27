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
    north = wh_5000_elev;
}


wh_5000_elev : AreaRoom -> wean '5000 Area, Near Elevators'
"""
You're just inside the entrance. Two elevators are before you, and hallways run past them, into the concrete wings of the turtle-shaped building.
""" {
	east = la_prima;
    south = wh_entrance;
}

la_prima : AreaRoom -> wean '5000 Area, La Prima'
"""
You're just inside the entrance. A long, snaking line of people waiting to buy an assortment of baked goods and caffeine products from La Prima (home of weird carbonated coffee) blocks half of the hallway.
""" {
	west = wh_5000_elev;
	south = wh_entrance;
}

+ la_prima_employee : Person
	'la prima employee/cashier' '<b>La Prima Employee</b>'
	"""
	A cheerful La Prima employee bustles around trilling out customers' orders to her underlings, who scramble to make coffee.
	""" {
		isHer = true;
		globalParamName = "la prima employee";
	}