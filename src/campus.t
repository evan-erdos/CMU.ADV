/* Ben Scott - bescott@andrew.cmu.edu - 2015-09-19 - CMU.ADV - campus */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

//RoomConnector template @room1 @room2 "desc"?;

fence : MultiLoc, Fixture, Readable 'fence' 'The Fence'
"The fence can be seen from here. It has recently been painted. " {
	locationList = [cut_south,the_cut,cut_north];
	readDesc = "The paint on the fence reads: \"<b>PARTY ALL NIGHT, YEAH, DRINK BEER.</b>\" It's very ugly. ";
	initSpecialDesc { isInInitState = null;
		"From here you can see <b>The Fence</b>, painted in the famous CMU tradition. It looks a bit rickety, but it always has. You're reasonably confident that the paint will hold it up for at least another seven years. "; readDesc;
	}
}

forbes_cut : OutdoorRoom 'forbes' 'The Cut (near Forbes Ave.)'
"You are at the intersection of Forbes and Morewood. To the north is Forbes Avenue, with hundreds of cars racing along at high speed." {
	north = forbes_morewood;
	south = cut_north;
}

forbes_morewood : FakeConnector "You'd be squished flat in a second! Why don't you just wait for the walk signal at the intersection?" {  }

cut_north : OutdoorRoom 'cut' 'The Cut (North)'
"You are on the north end of the Cut.  The impressive, boxlike silhouette of Warner Hall to the west somehow fails to impress you.  There is the sound of traffic to the north, while Skibo looms to the southeast. " {
	north = forbes_cut;
	south = the_cut;
	se = skibo_plaza;
	east = skibo_lot;
	down = cut_grating_1;
	west = warner_entrance;
}

+ cut_grating_1 : Lockable, SecretDoor
'(metal) grate/grating/hatch' 'metal grating'
"A metal grating is set in the ground here, as well. " { isLocked = true; }

the_cut : OutdoorRoom 'cut' 'The Cut'
"You at the center of the cut.  The grass here is lush and green -- sort of the Prime Cut, you might say. Skibo is to the east and a stairway leading down is to the southeast." {
	north = cut_north;
	east = skibo_plaza;
	southeast = kiltie_front;
	south = cut_south;
	west = cut_walkway_0;
	down asExit(southeast);
}

cut_south : OutdoorRoom 'cut' 'The Cut (South)'
"You are on the south end of the Cut, that fantabulously grassy area in the center of campus.  From here you can see Hunt Library a little ways to the south, and Forbes Avenue far to the north.  It's almost as if they planned it that way, you know?  The fence is here as well, covered with thousands of layers of paint. Walkways parallel the Cut to the east and west. " {
	north = cut_north;
	east = maggie_courts;
	southeast = cfa_lot;
	south = cfa_field;
	southwest = cut_walkway_2;
	west = cut_walkway_1;
	northwest = cut_hill;
}

cut_walkway_0 : OutdoorRoom 'walkway' 'Walkway (North)'
"You're on a walkway, running north and south. Warner hall lies to the west, and Skibo is across the Cut to the east. The flowers in the planters nearby are in full bloom. " {
	north = forbes_cut;
	east = the_cut;
	south = cut_walkway_1;
	west = warner_entrance;
}

+ cut_flowers : Decoration '(pretty) flowers/plants' 'flowers'
	"Aren't they beautiful? " { }

cut_walkway_1 : OutdoorRoom 'walkway' 'Walkway (Near Doherty)'
"This is a walkway running north and south. The ornate stonework of the Doherty Hall entrance is west from here, and the fence is directly east." {
	north = cut_walkway_0;
	east = cut_south;
	south = cut_walkway_2;
	southwest = cut_hill;
	west = dh_entrance;
}

cut_walkway_2 : OutdoorRoom 'walkway' 'Walkway (South)'
"You are on a walkway which continues to the north and south. To the west lies the grassy expanse of the Mall. To the east is the College of Fine Arts lawn." {
	north = cut_walkway_1;
	northeast = cut_south;
	south = cut_walkway_3;
	east = cfa_field;
	west = mall_east;
}

+ cut_grating_0 : SecretDoor -> cut_grating_1 'hatch' 'panel' "It's your standard, corrugated hatch, it leads up to the main viewing platform." { }

cut_walkway_3 : OutdoorRoom 'walkway' 'Walkway (Near Baker)'
"You are at the south end of a walkway leading north. To the west is the stately face of Baker Hall, its freshly scrubbed bricks shining like new -- which is odd, because the last time you looked at them, they were covered with a half-century of soot." {
	north = cut_walkway_2;
	south = frew_st_east;
	east = hh_plaza;
	west = bh_entrance;
}

cut_hill : FakeConnector "It's a long way down the hill... maybe you'd better stay here. " {  }

skibo_plaza : FakeConnector "You don't want to go to the Skibo Plaza! " { }

skibo_lot : FakeConnector "You don't want to go to the Skibo Lot! " { }

kiltie_front : FakeConnector "That's not even on campus anymore, AFAIK! How am I supposed to include that, huh? " { }

maggie_courts : FakeConnector "If there's one thing you're not, it's 'in the mood for tennis'" { }

mall_east : FakeConnector "You don't want to go to the East Lawn! " { }

frew_st_east : FakeConnector "You look at Frew St., and decide that ultimately, it's just not worth it. " { }

ucc_atrium : FakeConnector "You are standing outside the UCC on Forbes. High up above, you see a pair of weathered pink flamingoes. An entrance lies south. Well, an entrance would be there if I implemented any of this. BACK TO WARNER FOR YOU. " { }


