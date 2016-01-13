/* Ben Scott * bescott@andrew.cmu.edu * 2015-12-29 * Steam Tunnels */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"
#pragma newline_spacing(preserve)


steam_tunnels : Area 'Steam Tunnels'
['''
You feel a <<one of>>slight<<or>>gentle<<at random>> wind from somewhere <<one of>>behind<<or>>to your left<<or>>to your right<<or>>in front of you<<at random>>.
''','''
You hear a rumbling noise come from somewhere.
''','''
Something made a splashing noise, but you can't tell what.
''','''
A weird sound echoes in from an unknown direction.
''','''
You hear the faint sound of footsteps coming from somewhere above.
''']
"""
You're in a very dangerous situation. You're wandering through active steam tunnels. You have a hard time differentiating directions, and there's quite a smell in the air.
""";


steam : Vaporous, MultiLoc
'steam' 'the steam'
"""
Although this <i>is</i> a steam tunnel, there isn't much steam to be found. You don't much fancy the idea of waiting around for to see any steam, neither. You sensibly begin to look for a way out.
""" {
    locationList = [
        steam_tunnels_0, steam_tunnels_1, steam_tunnels_2];
    initSpecialDesc { isInInitState = null;
        """
        You notice steam, latent in the air. It alights from creases and cracks in the tunnel wall.
        """;
    }

    sightPresence { "Holy shit! You can see steam rushing towards you! Y-y-you gotta... gotta get outta there! "; }

    specialDesc { steam_list.doScript(); }

    steam_list : RandomFiringScript, ShuffledEventList {
        startEvents = [
            '''
            Everything's quiet, for now.
            ''','''
            You hear strange clanging noises, and rumbles, emanating from all around you.
            ''','''
            You feel air starting to move past you.
            ''','''
            It's become very windy, and also, much warmer.
            ''','''
            The steam is almost upon you.
            '''];

        eventList = [
            'AHhhhh holy SHITTTT the steam! AHHHH!!',
            'IT BURNS! IT BURNS! AHHH STEAMY STEAM OUCH! ',
            'GOOD GOD YOU ARE BURNING ALIVE FROM ALL THIS STEAM ALL OVER THE PLACE AHHHHHH',
            'THE HORROR. THE <b>HORROR<\b>.'];
        eventPercent = 40;
    }
}


steam_tunnels_end : DeadEndConnector
'Steam Tunnels (Dead End)'
"""
You wander out into a smaller tunnel which seems to wind away forever into steamy darkness. You sense that wandering around side-tunnels is an awful idea, and you turn around.
""";

steam_tunnels_back : TravelMessage -> steam_tunnels_end
"WOw! GOIn baCK huH>!/#";


steam_tunnels_0 : AreaRoom -> steam_tunnels 'Forbes Ave.'
"""
Overhead, you can hear the quiet rumbling of engines, and the rolling of rubber tires over asphault.
""" {
    north = steam_tunnels_3;
    east = steam_tunnels_end;
    south = steam_tunnels_1;
    west = steam_tunnels_end;
}

steam_tunnels_1 : AreaRoom -> steam_tunnels 'Warner Hall'
"""
You're closer to the surface here. Every now and then, you can hear the faint pitter-patter of someone walking down a vinyl-floored corridor.
""" {
    north = steam_tunnels_0;
    east = steam_tunnels_end;
    south = steam_tunnels_2;
    west = steam_tunnels_end;
}

steam_tunnels_2 : AreaRoom -> steam_tunnels 'the Cut'
"""
You can't hear much from above, but you imagine you're somewhere under the campus lawn.
""" {
    north = steam_tunnels_1;
    east = steam_tunnels_end;
    south = steam_tunnels_end;
    west = steam_tunnels_4;
}

+ cut_grating_2 : Lockable, SecretDoor
'(metal) grate/grating/hatch' 'metal grating'
"""
A metal grating is set in the roof here, as well.
""" {
    isLocked = true;
}

steam_tunnels_3 : AreaRoom -> steam_tunnels 'E Tower' {
    north = steam_tunnels_1;
}

steam_tunnels_4 : AreaRoom -> steam_tunnels 'Doherty Hall' {
    east = steam_tunnels_2;
}

//+ cut_grating_0 : SecretDoor -> cut_grating_1 'grating' 'the hatch'
//"It's your standard, corrugated hatch, it leads up to the main viewing platform." { }


