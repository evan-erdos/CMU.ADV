/* Ben Scott * bescott@andrew.cmu.edu * 2015-05-14 * Vividity * rooms */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

RoomConnector template @room1 @room2 "desc"?;
//Passage template -> masterObject 'vocabWords' 'name' @location? "desc"?
//Door template 'name' @room1 @room2;

root : Room 'Your Quarters' 'your quarters'
"It's a standard-issue dwelling, designed for the unusually harsh conditions of the Terrace. It is made of many alloys of metal, and is joisted by slender titanium trusses. It's defining feature is the central, dome-shaped foyer from which the more traditional, rectangular rooms branch off." {
	out = root_door_0;
	west asExit(out);
}

+ root_door_0 : AutoClosingDoor {
	reportAutoClose { "You close the porthole behind you."; };
	desc { "Your door leads out, and you can see it's bright outside through it's circular window. Curved rails carry it a few degrees around the inside of the dome. "; }
	name = 'Quarters Porthole';
	vocabWords = 'door/doors/portal/porthole/exit';
}

+ drafting_table : Surface, Fixture 'desk'
"You've been using this old-style drafting table as a desk for as long as you've needed a desk. It's edged with a dented but sturdy aluminum frame. It has a hefty steel pivot, its arc stretching 135° or more. Four triangularly trussed legs extend to spherical rubber feet which match perfectly your dented floor." {
	vocabWords = 'desk/desks/table/surface';
}


outside_quarters : OutdoorRoom 'Outside Your Quarters' 'near your quarters'
"You're outside your Quarters, which used to be quite well-kept. You haven't applied the sealant in months, and the wind-facing surface has become pitted and slightly rusty. The rails girding your catwalks look better, but the bluing is getting worn. Behind your house is a small dropoff. About half of your dome hangs over the edge, and there's a nice, shady area inside the supporting rods, with herringbone metal steps leading down and around it." {
	in = root_door_1;
	east asExit(in);
	southwest = seaside_cliffs;

	atmosphereList : ShuffledEventList {
		['A <<one of>>serene<<or>>gentle<<at random>> wind moseys in from the east.',
		'You hear waves breaking in the distance.',
		'A gust of wind blows some chalk dust out of a nearby patch of rock.',
		'The grass wavers about.',
		'<<one of>>It gets a bit dark.<<at random>> Some clouds pass overhead. <<one of>>Droplets of rain fall sparsely here and there.<<at random>>',
		'You hear crickets, talking back and forth in rhyme.',
		'Individual drops of rain patter your roof, making the faintest pinging noise.', null,null,null,null]
	}
}

+ root_door_1 : AutoClosingDoor ->root_door_0 {
	reportAutoClose { "You close the porthole behind you."; };
	desc { "Your door leads in, and you can see your foyer through it's circular window. Curved rails carry it a few degrees around the inside of the dome. "; }
	name = 'Quarters Porthole';
	vocabWords = 'door/doors/portal/porthole/exit';
}

seaside_cliffs : OutdoorRoom 'Seaside Cliffs' 'the cliffs'
"The seaside terrace is far enough above the patchy trees and dells to afford a remarkable view of the ocean and sky. A ragged moon dusts some drying marshes to the southwest, and to the west lies a cascade of lavender and mahogany flora, gushing from marble cliffsides." {
	north : FakeConnector { "You start off towards the dry valley between the low side of the Terrace and the road to Harston, despite that you've wandered around out there enough times to know there's nothing much to look at. You waste some time and kick some rocks around, and return to the cliffs." }
	northwest = harston_road;
	northeast = outside_quarters;
	southeast = forest_overlook;
	south = outside_dwelling;
	southwest = cliffs_edge;

	atmosphereList : ShuffledEventList {
		['A <<one of>>serene<<or>>balmy<<at random>> breeze rolls over the terrace and eddies overtop the northwest trees, which are almost flush with the plateau. <<one of>>They dance and turn in the wind.<<at random>>',
		'You <<one of>>hear a few breakers try to climb<<or>>see some flecks of foamy water crest<<at random>> the east cliffside.',
		'The grass waves at you; slow shockwaves of wind propagate from the cliffs.',
		'The grass twirls around you in the wind.',
		'It gets slightly darker for a short time. <<one of>>You feel a single drop of rain.<<or>>It passes.<<at random>> ',
		'You hear the fluttering of wings from somewhere in the distance.',
		'Some clouds come and go.', null,null,null,null]
	}
}

cliffs_edge : OutdoorRoom 'Cliff\'s Edge' 'the edge of the terrace'
"There's enough of a wind coming up the edge of the cliff to lift a small animal. Looking down over the white and vaguely purple chalk, you see an isolated cove, locked on two sides by tall rocks. There is a sand dune in front of a ravine-like opening, which seems to run under the cliffs somewhere to the north." {
	northwest = seaside_cliffs;
	east : FakeConnector { "It's a long way down, but not far enough to be a sure thing. If you're going to commit suicide, you'd want something more certain. " }

	atmosphereList : ShuffledEventList {
		['A <<one of>>sharp<<or>>gentle<<at random>> wind comes up from the sea.<<one of>> You smell salt.<<at random>>',
		'Waves roll into the cove below<<one of>>, making a weird, resonant cracking sound<<at random>>.',
		'The chalky cliffside spreads some of it\'s sand around in the wind.',
		'The grass twirls in the breeze.',
		'It gets a bit darker as some clouds pass overhead. <<one of>>Pinpricks of tiny raindrops suprise you for a short while.<<or>><<at random>>',
		'You hear chirping somewhere.',
		'A small rock was dislodged from some other rock nearby; it rattles downhill.', null,null,null,null]
	}
}

outside_dwelling : OutdoorRoom 'Outside Dwelling' 'the dwelling'
"Halfway to the edge of the plateau is a small, dome-like dwelling, with some paths running between it and a small garden behind it, and another area downhill. It is noisily rusted around the rounded main roof, but the seaside wind has somewhat polished the east hemisphere." {
	north = seaside_cliffs;
	in = inside_dwelling;
	southwest asExit(in);

	atmosphereList : ShuffledEventList {
		['A <<one of>>serene<<or>>balmy<<at random>> breeze floats in from the east.',
		'You listen as distant waves come to shore.',
		'The grass waves at you; slow shockwaves of wind propagate from the cliffs.',
		'The grass flutters.',
		'It gets a bit overcast, and then goes back to normal again.<<one of>> You feel a single drop of rain.<<at random>>',
		'It grows unusually quiet for a moment, but then the cacophony of the Terrace resumes, and you catch yourself smiling.',
		'Shadows break over your head.', null,null,null,null]
	}
}

inside_dwelling : Room 'Inside Dwelling' 'into the dwelling'
"The interior of the main room is quite cozy. It is lit dimly, with globes of light forming a lurid image of the inside." {
	out = outside_dwelling;
	northeast asExit(out);
}

forest_overlook : OutdoorRoom 'Forest Overlook' 'the forest overlook'
"At a gentle angle, the ocean-facing side of the plateau slides down to form a nice, shady spot beneath the trees. From here, the gargantuan arbors string all the way up above the raised rock of the terrace. There are tufts of branches almost within reach at the edge of the cliff." {
	northeast = seaside_cliffs;

}

harston_road : OutdoorRoom 'The Road to Harston' 'the main road to Harston'
"By some wonder of igneous intrusion, the northern edge of the Terrace has a set of 6 stair-like stone batholiths, all following the Terrace's ragged edge.With one exception, they even descend in order. An amalgam of small shops and transportation businesses have made themselves right at home on the terrace surface, and a small residential sector spreads down to the first step." {
	southeast = seaside_cliffs;
	north = town_harston;

}

town_harston : OutdoorRoom 'The Town of Harston' 'Harston'
"This little boomtown has dug itself into the hard sandstone surface of the Terrace. Most of the shops are brimming with life, and the stone streets have been worn to the bare rock by thick rubber wheels and the foot traffic of a very busy people. The stores to the east are so crowded that you'd likely be injured if you tried to buy something there, but the west end is quieter. There is a utilities shop to the west, a closed, nondescript shop to the southwest, and a cablecar service to the northwest." {
	north = store_cablecar;
	west = store_harold;
	south = harston_road;
}

store_harold : Room 'Harold\'s Utility Store' 'Harold\'s store'
"This is a store full of the sorts of things that can keep you alive, or get out of a tight spot. It's a bit cluttered." {
	east = town_harston;
}

store_cablecar : Room 'The Cablecar Company' 'the cablecar building'
"A large, round atrium opens to a chamber which sends and receives cars from a lower stop. The cars arrive in a wide, off-center slot in the dome, and the loading platform wraps around it." {
	south = town_harston;
	down = canyon_gallery;
}

canyon_gallery : OutdoorRoom 'The Canyon Gallery' 'the canyon gallery' {
	up = store_cablecar;
	down = under_gallery;
	//special_message =
	initialDesc =
		"A hallowed thing— - to drop a life -
		Into the purple well— -
		Too plummetless— - that it return— -
		Eternity— until— -
		F 307 (1862) 271";
	desc {
		"This is where it happened. It could'nt've been more than a month ago. There's a small crowd on the deck. \nVery few people come to see the canyon now, but it is still beautiful. Most of the visitors are here because they don't know much about what happened. Some are here by sheer force of memory: the nostalgia they hold for this place allays the thought of what happened to that man, how... <b>brutal</b>... It is almost too much for you.";
	}
}

+ platform_hatch_0: SecretDoor 'hatch' 'panel'
"A small hatch <<isOpen ?'is unlocked but still closed, presumably so people don\'t fall into it and die.':'can be seen in the corner.'>>";

under_gallery : OutdoorRoom 'Under the Canyon Gallery' 'under the platform'
"This is a somewhat unsafe place to be: You're beneath the canyon's main viewing platform, amongst boulders which border you from a very steep drop into the gulley." {
	up = canyon_gallery;
	brightness = ((platform_hatch_1.isOpen)?3:1);
}

+ platform_hatch_1: SecretDoor -> platform_hatch_0 'hatch' 'panel' "It's your standard, corrugated hatch, it leads up to the main viewing platform.";


abandoned_park : OutdoorRoom 'The Abandoned Park' 'the park'
"You stalk through the closed amusement park you remember so vividly from your childhood. It was a bustling, busy place, with all shapes and colors of people represented, walking around in what would else be socially unacceptable clothing. Those memories stand strong against the erosion of time, but seeing this place now, so broken as it is... it's quite unsettling." {

}








