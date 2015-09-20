/* Ben Scott - bescott@andrew.cmu.edu - 2015-09-19 - CMU.ADV - rooms */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

RoomConnector template @room1 @room2 "desc"?;
//Passage template -> masterObject 'vocabWords' 'name' @location? "desc"?
//Door template 'name' @room1 @room2;

root : Room 'dorm' 'your dorm room'
"It's a standard-issue dwelling: there's random furniture crammed into all sorts of odd angles, and the effects of a roommate you haven't seen in months, not including his wallet, unfortunately. " {
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

