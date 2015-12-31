/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-19 * maps */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"


RoomConnector template @room1 @room2 "desc"?;


class CampusOutdoorRoom : OutdoorRoom {
    atmosphereList = campus_atmosphere;
}


root : Room 'dorm' 'your dorm room'
"It's a standard-issue dwelling: there's random furniture crammed into all sorts of odd angles, and the effects of a roommate you haven't seen in months, not including his wallet, unfortunately. " {
    out = root_door_0;
    west asExit(out);
}

+ root_bed : Heavy, Bed 'bed/bedding/cot/mattress' 'your bed'
"It's your bed. Nice bed. It's so... mmmm... NO! Wait! THHERE WAHS THAT, THING YOU... did you alre.. NO! You didn't! It's probably due tomorrow! You can't sleep now. " { }

+ root_door_0 : AutoClosingDoor {
    reportAutoClose { "You close the door behind you. "; };
    desc { "Your door leads out. "; }
    name = 'Dormitory Door';
    vocabWords = 'door/doors/portal/porthole/exit';
}

+ drafting_table : Surface, Fixture 'desk'
"You've been using this old-style drafting table as a desk for as long as you've needed a desk. It's edged with a dented but sturdy aluminum frame. It has a hefty steel pivot, its arc stretching 135° or more. Four triangularly trussed legs extend to spherical rubber feet which match perfectly your dented floor." {
    vocabWords = 'desk/desks/table/surface';
}

limbo : Room 'limbo' 'Limbo'
"You are in limbo.  There is nothing but foggy grey matter as far as the eye can see. Ghosts of ancient hackers wander around and through you. " {
    specialDesc = "You can't seem to get out of here. ";
    east = limbo;
    northeast asExit(east);
    north asExit(east);
    northwest asExit(east);
    south asExit(east);
    southeast asExit(east);
    southwest asExit(east);
    west asExit(east);
}

into_limbo : TravelMessage -> limbo "You are taken to... " { }

