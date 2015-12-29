/* Ben Scott * bescott@andrew.cmu.edu * 2015-12-29 * Steam Tunnels */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

steam : Vaporous, MultiLoc 'steam' 'the steam'
"Although this <i>is</i> a steam tunnel, there isn't much steam to be found. You don't much fancy the idea of waiting around for to see any steam, neither. You sensibly begin to look for a way out. " {
    locationList = [
        steam_tunnels_0, steam_tunnels_1, steam_tunnels_2];
    initSpecialDesc { isInInitState = null;
        "You notice steam, latent in the air. It alights from creases and cracks in the tunnel wall. ";
    }

    sightPresence { "Holy shit! You can see steam rushing towards you! Y-y-you gotta... gotta get outta there! "; }

    specialDesc { steam_list.doScript(); }

    steam_list : RandomFiringScript, ShuffledEventList {
        startEvents = [
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


steam_tunnels : object {
    sharedDesc = "You're in a very dangerous situation. You're wandering through active steam tunnels. You have a hard time differentiating directions, and there's quite a smell in the air. ";
}


steam_tunnels_end : DeadEndConnector 'Steam Tunnels (Dead End)'
"You wander out into a smaller tunnel which seems to wind away forever into steamy darkness. You sense that wandering around side-tunnels is an awful idea, and you turn around. " { }

steam_tunnels_back : TravelMessage -> steam_tunnels_end
"WOw! GOIn baCK huH>!/#";


steam_tunnels_0 : Room 'Steam Tunnels (Under Forbes Ave.)' 'steam tunnels' {
    desc = steam_tunnels.sharedDesc;
    north = steam_tunnels_3;
    east = steam_tunnels_end;
    south = steam_tunnels_1;
    west = steam_tunnels_end;
}

steam_tunnels_1 : Room 'Steam Tunnels (Under Warner Hall)' 'steam tunnels' {
    desc = steam_tunnels.sharedDesc;
    north = steam_tunnels_0;
    east = steam_tunnels_end;
    south = steam_tunnels_2;
    west = steam_tunnels_end;
}

steam_tunnels_2 : Room 'Steam Tunnels (Under the Cut)' 'steam tunnels' {
    desc = steam_tunnels.sharedDesc;
    //west = steam_tunnels_end;
}

+ cut_grating_2 : Lockable, SecretDoor
'(metal) grate/grating/hatch' 'metal grating'
"A metal grating is set in the roof here, as well. " {
    isLocked = true;
}

steam_tunnels_3 : Room 'Steam Tunnels (Under Morewood E Tower)' 'steam tunnels' {
    desc = steam_tunnels.sharedDesc;
    north = steam_tunnels_1;
}

//+ cut_grating_0 : SecretDoor -> cut_grating_1 'grating' 'the hatch'
//"It's your standard, corrugated hatch, it leads up to the main viewing platform." { }


steam_tunnels_atmosphere : Ambience [
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
    'It gets a bit darker as some clouds pass overhead. <<one of>>Pinpricks of tiny raindrops suprise you for a short while.<<or>><<at random>>',
    'You hear chirping somewhere.'];

steam_tunnel_uniqueEvents : RandomFiringScript, EventList [
    'In the distance you can hear some people laughing, but then they become quiet all of a sudden. ',
    'A lone figure darts around a corner, his head and face obscured by a hat and a huge backpack. ',
    'A car horn gives a short blip of noise to someone near the intersection, insomuch as you can tell. ',
    'At a distance you can see a student jump in suprise, having just unwittingly stepped in a deep puddle. <i>Get it together, Cindy.</i> ',
    'Two people walk by, speaking a language you can\'t even identify (and you\'re pretty worldly!). You both realize that you\'re staring at them. You stop. '] eventPercent = 80;



