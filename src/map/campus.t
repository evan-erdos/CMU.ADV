/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-19 * Campus */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"
#pragma newline_spacing(preserve)


campus : Area 'Carnegie Mellon Campus' 'campus'
['''
A <<one of>>serene<<or>>gentle<<at random>> wind moseys in from the <<one of>>east<<or>>west<<at random>>.
''','''
The grass wavers about.
''','''
<<one of>>It gets a bit dark.<<at random>> Some clouds pass overhead. <<one of>>Droplets of rain fall sparsely here and there.<<at random>>
''','''
Individual drops of rain patter the concrete buildings, making the faintest tapping noise.
''','''
A class lets out across the way, and people mosey out.
''','''
A <<one of>>serene<<or>>balmy<<at random>> breeze rolls over the lawn and eddies overtop the buildings. <<one of>>The campus's small trees dance and turn in the wind.<<at random>>''','''
The grass waves at you; slow shockwaves of wind propagate from the south lawn.
''','''
The grass twirls around you in the wind.
''','''
It gets slightly darker for a short time. <<one of>>You feel a single drop of rain.<<or>>It passes.<<at random>>
''','''
Some clouds come and go.
''','''
A <<one of>>freshman<<or>>sophomore<<or>>junior<<at random>> passes you, and you overhear him saying "<<one of>>112<<or>>122<<or>>213<<at random>> is <<one of>><b>harrrddd-duh</b><<or>>like, totally below me, br0h<<or>>a course here<<at random>>."
''','''
A <<user.engender(
    'gaggle of freshmen girls giggle at you',
    'bunch of sophomore boys put their noses deeper into textbooks')>> as they walk by.
''','''
The grass twirls in the breeze.
''','''
It gets a bit darker as some clouds pass overhead. <<one of>>Pinpricks of tiny raindrops surprise you for a short while.<<or>><<at random>>
''','''
You hear chirping somewhere.
''','''
A swarm of angry protesters march by, shouting something that sounds like "Bagpipe manchoir!"
''','''
A student jogs by in a suit and brandishing a resume, muttering a long string of corporate buzzwords.
''','''
A <<one of>>snappily-dressed lady<<or>>scruffy guy<<or>>elderly woman<<at random>> marches by you with a <<one of>>German shepherd<<or>>scotty dog<<or>>malamute<<or>>husky<<or>>cat on a leash<<or>>misbehaving maltese<<at random>> in tow.
''',
{: print(uniqueEvents.doScript()) }]
"""
You're on campus.
""";

fence : MultiLoc, Fixture, Readable
'(painted) wall/paint/fence*fences' 'The Fence'
"""
You can see the fence from here, covered with thousands of layers of paint. It looks a bit rickety, but it always has. You're reasonably confident that the paint will hold it up for at least another seven years.
""" {
    locationList = [
        forbes_cut, cut_north, cut_south, the_cut,
        cut_walkway_0, cut_walkway_0_5, cut_walkway_1,
        cut_walkway_2, cut_walkway_3,
        dh_entrance, bh_entrance,
        hh_entrance, cfa_field];

    readDesc =
        """
        The paint on the fence reads:
        <blockquote>
        <b>PARTY ALL NIGHT, YEAH, DRINK BEER.</b>
        </blockquote>
        It is very ugly.
        """;

    initSpecialDesc { isInInitState = null;
        """
        From here you can see <b>The Fence</b>, painted in the famous CMU tradition.
        """; readDesc;
    }

    specialDesc { fence_list.doScript(); }

    fence_list : Ambiance {
        ['''
        You can see The Fence from here.
        ''','''
        It'll last forever, that fence.
        ''','''
        A hundred years, Fence and Doherty!
        ''','''
        www.FenceAndDoherty, www.FenceAndDohertyAdventures.com!
        ''','''
        ...Fence and Doherty, Fence, Doher... 2.0! Hundred years!
        ''']['''
        Man, what a fence we have here.
        ''','''
        It'll last forever, that fence.
        ''','''
        The paint on the fence beckons to you to repaint it.
        ''','''
        You can still see The Fence, just keepin' it fresh on the Cut.
        ''']
    }
}

cfa_entrance : OutdoorRoom, AreaRoom -> cfa 'Entrance'
"""
The forward-facing façade of the College of Fine Arts is a thriving example of Renaissance architecture, with vaulting, Victorian alcoves embedded into its stone visage.
""" {
    east = cfa_atrium;
    in asExit(east);
}

forbes_morewood : FakeConnector
"""
You'd be squished flat in a second! Why don't you just wait for the walk signal at the intersection?
""";

forbes_cut : OutdoorRoom, AreaRoom -> campus
'The Cut (near Forbes Ave.)'
"""
You are at the intersection of Forbes and Morewood. To the north is Forbes Avenue, with hundreds of cars racing along at high speed.
""" {
    north = forbes_morewood;
    south = cut_north;
}

//******************<The Cut>*******************

cut_north : OutdoorRoom, AreaRoom -> campus
'The Cut (North)'
"""
You are on the north end of the Cut. The impressive, boxlike silhouette of Warner Hall to the west somehow fails to impress you. There is the sound of traffic to the north, while Skibo looms to the southeast.
""" {
    north = forbes_cut;
    south = the_cut;
    se = skibo_plaza;
    east = skibo_lot;
    down = cut_grating_1;
    west = warner_entrance;
}

+ cut_grating_1 : Lockable, SecretDoor
'(metal) grate/grating/hatch' 'metal grating'
"""
A metal grating is set in the ground here.
""" {
    isLocked = true;
}

the_cut : OutdoorRoom, AreaRoom -> campus
'The Cut'
"""
You at the center of the cut. The grass here is lush and green -- sort of the Prime Cut, you might say. Skibo is to the east and a stairway leading down is to the southeast.
""" {
    north = cut_north;
    east = skibo_plaza;
    southeast = kiltie_front;
    south = cut_south;
    west = cut_walkway_0;
    down asExit(southeast);
}

cut_south : OutdoorRoom, AreaRoom -> campus
'The Cut (South)'
"""
You are on the south end of the Cut, that fantabulously grassy area in the center of campus. From here you can see Hunt Library a little ways to the south, and Forbes Avenue far to the north.  It's almost as if they planned it that way, you know?
""" {
    north = the_cut;
    east = maggie_courts;
    southeast = cfa_lot;
    south = cfa_field;
    southwest = cut_walkway_2;
    west = cut_walkway_1;
    northwest = cut_hill;
}

cut_walkway_0 : OutdoorRoom, AreaRoom -> campus
'Walkway (North)'
"""
You're on a walkway, running north and south. Warner hall lies to the west, and Skibo is across the Cut to the east. The flowers in the planters nearby are in full bloom.
""" {
    north = forbes_cut;
    east = the_cut;
    south = cut_walkway_0_5;
    west = warner_entrance;
}

+ cut_flowers : Decoration
'(pretty) flower/plant*flowers plants' 'some flowers'
"""
Aren't they beautiful?
""" isPlural = true;

cut_walkway_0_5: OutdoorRoom, AreaRoom -> campus
'Walkway (Near Pausch)'
"""
You are on a walkway running north and south. To your west is the majestic Randy Pausch Memorial Bridge that leads to Gates.
""" {
    north = cut_walkway_0;
    south = cut_walkway_1;
    west = pausch_bridge_entrance;
}

cut_walkway_1 : OutdoorRoom, AreaRoom -> campus
'Walkway (Near Doherty)'
"""
This is a walkway running north and south. The ornate stonework of the Doherty Hall entrance is west from here, and the fence is directly east.
""" {
    north = cut_walkway_0_5;
    east = cut_south;
    south = cut_walkway_2;
    southwest = cut_hill;
    west = dh_entrance;
}

cut_walkway_2 : OutdoorRoom, AreaRoom -> campus
'Walkway (South)'
"""
You are on a walkway which continues to the north and south. To the west lies the grassy expanse of the Mall. To the east is the College of Fine Arts lawn.
""" {
    north = cut_walkway_1;
    northeast = cut_south;
    south = cut_walkway_3;
    east = cfa_field;
    west = mall_east;
}

+ cut_grating_0 : SecretDoor -> cut_grating_1
'(metal) grate/grating' 'the hatch'
"""
It's your standard, corrugated hatch, it leads up to the main viewing platform.
""";

cut_walkway_3 : OutdoorRoom, AreaRoom -> campus
'Walkway (Near Baker)'
"""
You are at the south end of a walkway leading north. To the west is the stately face of Baker Hall, its freshly scrubbed bricks shining like new -- which is odd, because the last time you looked at them, they were covered with a half-century of soot.
""" {
    north = cut_walkway_2;
    south = frew_st_east;
    east = hh_plaza;
    west = bh_entrance;
}

+ root_door_1 : AutoClosingDoor -> root_door_0
'(wooden) portal/porthole/exit/door*doors' 'door'
"""
The door to your dormitory shimmers like a vision before you.
""" {
    reportAutoClose { "You close the door behind you, and suddenly you're near Baker Hall... "; };
}

//******************<The Mall>*******************

mall_east : OutdoorRoom, AreaRoom -> campus
'The Mall (East)'
"""
You stand at the top of the gently-sloping lawn to your west, at the end of which lies Hamerschlag Hall. To your north, east, and south is the Cut walkway, which runs north and south from Forbes to Frew St. To your west lies the middle of the Mall.
""" {
    north = cut_walkway_1;
    east = cut_walkway_2;
    south = cut_walkway_3;
    west = mall_mid;
}

mall_mid : OutdoorRoom, AreaRoom -> campus
'The Mall'
"""
This is the middle of the mall. To your north lies an oft-ignored entrance to Doherty, and to your south is a side entrance to Baker. The westmost side of the Mall lies to your west, and the eastmost side lies to your east.
""" {
    //north = ...
    //south = ...
    east = mall_east;
    west = mall_west;
}

mall_west : OutdoorRoom, AreaRoom -> campus
'The Mall (West)'
"""
You are at the end of the mall, in the shadow of Hamerschlag Hall. The Fence is obscured by the upwards-sloping lawn to the east.
""" {
    north = wh_entrance;
    east = mall_mid;
}

//******************<Pausch Bridge>*******************

pausch_bridge_entrance : OutdoorRoom, AreaRoom -> campus
'The Pausch Bridge (near Purnell)'
"""
You're in the shelter of the Purnell Center rotunda.
""" {
    northeast = cut_south;
    southeast = cut_walkway_1;
    west = pausch_bridge_0;
}

pausch_bridge_0 : OutdoorRoom
'The Pausch Bridge (Beginning)' 'the Pausch Bridge'
"""
You're at the start of the Pausch Bridge. It's like nothing you've ever seen. <b>It's 1986, remember? Jeez, is this guy even paying attention right now?</b>
""" {
    west = pausch_bridge_1;
    east = pausch_bridge_entrance;
}

pausch_bridge_1 : OutdoorRoom
'The Pausch Bridge (Middle)' 'the Pausch Bridge'
"""
You're in the middle of the Pausch Bridge. To the east is the part of the bridge that goes to the campus. To the west is the part of the bridge that goes to the Gates Hillman Center. At some point, you'd think some of this would sink in.
""" {
    west = pausch_bridge_2;
    east = pausch_bridge_0;
}

pausch_bridge_2 : OutdoorRoom
'The Pausch Bridge (End)' 'the Pausch Bridge'
"""
You're at the other end of the Pausch Bridge.
""" {
    in = ghc_5_entrance;
    west asExit(in);
    east = pausch_bridge_1;
}

//DangerousVerifyResult.showMessage
cut_hill : TravelMessage -> pausch_bridge_entrance
"""
It's a long way down the hill... maybe you'd better stay here. Well, who cares! You won't just go there, you'll JUMP!

Miraculously, you survive, and you find yourself...
""";

skibo_plaza : FakeConnector
"You don't want to go to the Skibo Plaza! ";

skibo_lot : FakeConnector
"You don't want to go to the Skibo Lot! ";

kiltie_front : FakeConnector
"That's not even on campus anymore, AFAIK! How am I supposed to include that, huh? ";

maggie_courts : FakeConnector
"If there's one thing you're not, it's 'in the mood for tennis'";

frew_st_east : FakeConnector
"You look at Frew St., and decide that ultimately, it's just not worth it. ";

ucc_atrium : FakeConnector
"""
You are standing outside the UCC on Forbes. High up above, you see a pair of weathered pink flamingoes. An entrance lies south. Well, an entrance would be there if I implemented any of this. BACK TO WARNER FOR YOU.
""";

uniqueEvents : Ambiance [
'''
In the distance you can hear some people laughing, but then they become quiet all of a sudden.
''','''
A lone figure darts around a corner, his head and face obscured by a hat and a huge backpack.
''','''
A car horn gives a short blip of noise to someone near the intersection, insomuch as you can tell.
''','''
At a distance you can see a student jump in surprise, having just unwittingly stepped in a deep puddle. <i>Get it together, Cindy.</i>
''','''
Two people walk by, speaking a language you can't even identify (and you're pretty worldly!). You both realize that you're staring at them. You stop.
''']['',''];



