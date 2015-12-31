/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-19 * Campus */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"
#pragma newline_spacing(preserve)


fence : MultiLoc, Fixture, Readable
'The Fence' 'the Fence'
"You can see the fence from here, covered with thousands of layers of paint. It looks a bit rickety, but it always has. You're reasonably confident that the paint will hold it up for at least another seven years. " {
    locationList = [
        forbes_cut, cut_north, cut_south, the_cut,
        cut_walkway_0, cut_walkway_1,
        cut_walkway_2, cut_walkway_3,
        dh_entrance, bh_entrance,
        hh_entrance, cfa_field];

    readDesc = """
        The paint on the fence reads:
        <p>
        >
        > <b>PARTY ALL NIGHT, YEAH, DRINK BEER.</b>
        >
        </p>
        It is very ugly. """;

    initSpecialDesc { isInInitState = null;
        "From here you can see <b>The Fence</b>, painted in the famous CMU tradition."; readDesc;
    }

    specialDesc { fence_list.doScript(); }

    fence_list : RandomFiringScript, ShuffledEventList {
        firstEvents = [
            'You can see The Fence from here. ',
            'It\'ll last forever, that fence. ',
            'A hundred years, Fence and Doherty! ',
            'www.FenceAndDoherty, www.FenceAndDohertyAdventures.com! ',
            '...Fence and Doherty, Fence, Doher... 2.0! Hundred years!'];
        eventList = [
            'Man, what a fence we have here. ',
            'It\'ll last forever, that fence. ',
            'The paint on the fence beckons to you to repaint it. ',
            'You can still see The Fence, just keepin\' it fresh on the Cut.'];
        eventPercent = 40;
    }
}

forbes_morewood : FakeConnector
"You'd be squished flat in a second! Why don't you just wait for the walk signal at the intersection?" {  }

forbes_cut : CampusOutdoorRoom
'The Cut (near Forbes Ave.)' 'forbes'
"You are at the intersection of Forbes and Morewood. To the north is Forbes Avenue, with hundreds of cars racing along at high speed." {
    north = forbes_morewood;
    south = cut_north;
}

cut_north : CampusOutdoorRoom
'The Cut (North)' 'the Cut'
"You are on the north end of the Cut. The impressive, boxlike silhouette of Warner Hall to the west somehow fails to impress you. There is the sound of traffic to the north, while Skibo looms to the southeast. " {
    north = forbes_cut;
    south = the_cut;
    se = skibo_plaza;
    east = skibo_lot;
    down = cut_grating_1;
    west = warner_entrance;
}

+ cut_grating_1 : Lockable, SecretDoor
'(metal) grate/grating/hatch' 'metal grating'
"A metal grating is set in the ground here. " {
    isLocked = true;
}

the_cut : CampusOutdoorRoom
'The Cut' 'the Cut'
"You at the center of the cut. The grass here is lush and green -- sort of the Prime Cut, you might say. Skibo is to the east and a stairway leading down is to the southeast. " {
    north = cut_north;
    east = skibo_plaza;
    southeast = kiltie_front;
    south = cut_south;
    west = cut_walkway_0;
    up = steam_tunnels_0;
    down asExit(southeast);
}

cut_south : CampusOutdoorRoom
'The Cut (South)' 'the Cut'
"You are on the south end of the Cut, that fantabulously grassy area in the center of campus. From here you can see Hunt Library a little ways to the south, and Forbes Avenue far to the north.  It's almost as if they planned it that way, you know? " {
    north = the_cut;
    east = maggie_courts;
    southeast = cfa_lot;
    south = cfa_field;
    southwest = cut_walkway_2;
    west = cut_walkway_1;
    northwest = cut_hill;
}

cut_walkway_0 : CampusOutdoorRoom
'Walkway (North)' 'the walkway'
"You're on a walkway, running north and south. Warner hall lies to the west, and Skibo is across the Cut to the east. The flowers in the planters nearby are in full bloom. " {
    north = forbes_cut;
    east = the_cut;
    south = cut_walkway_1;
    west = warner_entrance;
}

+ cut_flowers : Decoration
'(pretty) flowers/plants' 'some flowers'
"Aren't they beautiful? " {  }

cut_walkway_1 : CampusOutdoorRoom
'Walkway (Near Doherty)' 'the walkway'
"This is a walkway running north and south. The ornate stonework of the Doherty Hall entrance is west from here, and the fence is directly east." {
    north = cut_walkway_0;
    east = cut_south;
    south = cut_walkway_2;
    southwest = cut_hill;
    west = dh_entrance;
}

cut_walkway_2 : CampusOutdoorRoom
'Walkway (South)' 'the walkway'
"You are on a walkway which continues to the north and south. To the west lies the grassy expanse of the Mall. To the east is the College of Fine Arts lawn." {
    north = cut_walkway_1;
    northeast = cut_south;
    south = cut_walkway_3;
    east = cfa_field;
    west = mall_east;
}

+ cut_grating_0 : SecretDoor -> cut_grating_1
'grating' 'the hatch'
"It's your standard, corrugated hatch, it leads up to the main viewing platform." { }

cut_walkway_3 : CampusOutdoorRoom
'Walkway (Near Baker)' 'the walkway'
"You are at the south end of a walkway leading north. To the west is the stately face of Baker Hall, its freshly scrubbed bricks shining like new -- which is odd, because the last time you looked at them, they were covered with a half-century of soot." {
    north = cut_walkway_2;
    south = frew_st_east;
    east = hh_plaza;
    west = bh_entrance;
}

+ root_door_1 : AutoClosingDoor -> root_door_0 {
    reportAutoClose { "You close the door behind you, and suddenly you're near Baker Hall... "; };
    desc { "The door to your dormitory shimmers like a vision before you. "; }
    vocabWords = 'door/doors/portal/porthole/exit';
}

pausch_bridge_entrance : CampusOutdoorRoom
'The Pausch Bridge (near Purnell)' 'the Pausch Bridge'
"You're in the shelter of the Purnell Center rotunda. " {
    northeast = cut_south;
    southeast = cut_walkway_1;
    west = pausch_bridge_0;
}

pausch_bridge_0 : OutdoorRoom
'The Pausch Bridge (Beginning)' 'the Pausch Bridge'
"You're at the start of the Pausch Bridge. It's like nothing you've ever seen. It's 1986, remember? Jeez, is this guy even paying attention right now?" {
    west = pausch_bridge_1;
    east = pausch_bridge_entrance;
}

pausch_bridge_1 : OutdoorRoom
'The Pausch Bridge (Middle)' 'the Pausch Bridge'
"You're in the middle of the Pausch Bridge. To the west is the part of the bridge that goes to the campus. To the east is the part of the bridge that goes to the Gates Hillman Center. At some point, you'd think some of this would sink in." {
    west = pausch_bridge_2;
    east = pausch_bridge_0;
}

pausch_bridge_2 : OutdoorRoom
'The Pausch Bridge (End)' 'the Pausch Bridge'
"You're at the other end of the Pausch Bridge. " {
    in = ghc_5_entrance;
    west asExit(in);
    east = pausch_bridge_1;
}

//DangerousVerifyResult.showMessage
cut_hill : TravelMessage -> pausch_bridge_entrance
"It's a long way down the hill... maybe you'd better stay here. Well, who cares! You won't just go there, you'll JUMP!\bMiraculously, you survive, and you find yourself... ";

skibo_plaza : FakeConnector
"You don't want to go to the Skibo Plaza! " { }

skibo_lot : FakeConnector
"You don't want to go to the Skibo Lot! " { }

kiltie_front : FakeConnector
"That's not even on campus anymore, AFAIK! How am I supposed to include that, huh? " { }

maggie_courts : FakeConnector
"If there's one thing you're not, it's 'in the mood for tennis'" { }

mall_east : FakeConnector
"You don't want to go to the East Lawn! " { }

frew_st_east : FakeConnector
"You look at Frew St., and decide that ultimately, it's just not worth it. " { }

ucc_atrium : FakeConnector
"You are standing outside the UCC on Forbes. High up above, you see a pair of weathered pink flamingoes. An entrance lies south. Well, an entrance would be there if I implemented any of this. BACK TO WARNER FOR YOU. " { }

campus_atmosphere : Ambiance [
    'A <<one of>>serene<<or>>gentle<<at random>> wind moseys in from the <<one of>>east<<or>>west<<at random>>.',
    'The grass wavers about.',
    '<<one of>>It gets a bit dark.<<at random>> Some clouds pass overhead. <<one of>>Droplets of rain fall sparsely here and there.<<at random>>',
    'Individual drops of rain patter the concrete buildings, making the faintest tapping noise.',
    {: print(uniqueEvents.doScript()) },
    'A class lets out across the way, and people mosey out. ',
    'A <<one of>>serene<<or>>balmy<<at random>> breeze rolls over the lawn and eddies overtop the buildings. <<one of>>The campus\'s small trees dance and turn in the wind.<<at random>>',
    'The grass waves at you; slow shockwaves of wind propagate from the south lawn.',
    'The grass twirls around you in the wind.',
    'It gets slightly darker for a short time. <<one of>>You feel a single drop of rain.<<or>>It passes.<<at random>> ',
    'Some clouds come and go.',
    'A <<one of>>freshman<<or>>sophomore<<or>>junior<<at random>> passes you, and you overhear him saying "<<one of>>112<<or>>122<<or>>213<<at random>> is <<one of>><b>harrrddd-duh</b><<or>>like, totally below me, br0h<<or>>a course here<<at random>>."',
    'A <<user.engender('gaggle of freshmen girls giggle at you','bunch of sophomore boys put their noses deeper into textbooks')>> as they walk by. ',
    'The grass twirls in the breeze.',
    'It gets a bit darker as some clouds pass overhead. <<one of>>Pinpricks of tiny raindrops surprise you for a short while.<<or>><<at random>>',
    'You hear chirping somewhere.'];

uniqueEvents : RandomFiringScript, EventList [
    'In the distance you can hear some people laughing, but then they become quiet all of a sudden. ',
    'A lone figure darts around a corner, his head and face obscured by a hat and a huge backpack. ',
    'A car horn gives a short blip of noise to someone near the intersection, insomuch as you can tell. ',
    'At a distance you can see a student jump in surprise, having just unwittingly stepped in a deep puddle. <i>Get it together, Cindy.</i> ',
    'Two people walk by, speaking a language you can\'t even identify (and you\'re pretty worldly!). You both realize that you\'re staring at them. You stop. '] eventPercent = 80;



