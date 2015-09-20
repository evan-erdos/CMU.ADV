/* Ben Scott - bescott@andrew.cmu.edu - 2015-09-19 - CMU.ADV - items */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

class Plant : Thing {
	vocabWords = 'flora/leaf/leaves/shrub/plant/plants/flowers';
	identified = null;
	idDesc = "<<(identified)?'You\'ve seen this kind of plant before.':'You cant be sure what kind of plant this is. '>>";
}

class Herb : Food, Plant {
	//effect;
	count = 1;
	isPlural = true;
}

class Tree : Plant, Fixture {
	vocabWords = 'arbor/arbors/conifer/conifers/timber/tree/trees';
	desc = '\"I spy... something... green.\" \"Tree?\" \"ahh...\" \"Ok, my turn. I spy... eh, a vertical log-\" \"Tree.\" \"Yeah.\"';
}

backpack : BagOfHolding, StretchyContainer 'backpack' @root
"You've had this pack for awhile. It's somewhat old, but it still carries everything you need to go out adventuring." {
	initSpecialDesc = "Your tattered backpack is here. You typically don't leave home without it. ";
	bulkCapacity = 3000;
	minBulk = 1;
	vocabWords = 'back/backpack/pack/sack/bag';
	//affinityFor(obj) { return obj.ofKind(Tablet) ? 200 : inherited(obj); }
}

keyring : Keyring 'keyring' @root
"Your keyring is kindof barren. It\'s old enough that it\'s not as hard to separate it to put keys on, though. So, you\'ve got that going for you, which is nice." {

}

flashlight : Flashlight 'flashlight' @root
"Your flashlight is thin, and made from a very heavy metal. You would have a hard time breaking it, but the batteries don\'t last that long." {
	vocabWords = 'flash/flashlight/light/lamp/lantern/bulb/light/li';
	isLit = null;
	brightnessOn = 4;
	bulk = 2;
	weight = 2;
}

leaflet : Thing '(small) leaflet' 'the leaflet' @hh_entrance
"The leaflet is quite short, and has a tear along the top edge. It reads \"... the most amazing territory ever seen by mortals. No computer should be without one!\" At the end is what looks like a serial number, <b>69105</b>. Typical." {
	initSpecialDesc = "There's a leaflet here, held down by a rock. An edge flutters in the breeze.";
	initDesc = "It's just a small piece of paper. You have no idea how it hasn't blown away yet.";
}

futuristic_leaflet : Thing '(small) note/email' 'futuristic leaflet' @south_cut
"Hi guys, Homework 1 has been posted. Please start it right away. Note that, as opposed to other courses, you can think about most of these problems while waking around and doing mechanical errands. Cheers, Irina " {
	initSpecialDesc = "There's a really well printed note on the ground here. The resolution is like nothing you've ever seen come out of your dot-matrix printers.";
	initDesc = "It's just a note. You wonder why it hasn't blown away yet.";
}



