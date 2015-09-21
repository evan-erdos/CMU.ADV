/* Ben Scott - bescott@andrew.cmu.edu - 2015-09-19 - CMU.ADV - items */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

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

leaflet : Thing '(small) leaflet' 'the leaflet' @the_cut
"The leaflet is quite short, and has a tear along the top edge. It reads \"... the most amazing territory ever seen by mortals. No computer should be without one!\" At the end is what looks like a serial number, <b>69105</b>. Typical." {
	initSpecialDesc = "There's a leaflet here, held down by a rock. An edge flutters in the breeze.";
	initDesc = "It's just a small piece of paper. You have no idea how it hasn't blown away yet.";
}

futuristic_leaflet : Thing '(small) note/email' 'futuristic leaflet' @root
"It reads:\b \"Hi guys, Homework 1 has been posted. Please start it right away. Note that, as opposed to other courses, you can think about most of these problems while waking around and doing mechanical errands. Cheers, Irina\"\b You think you can see tears on the bottom, but those could just as easily be from the rain. " {
	initSpecialDesc = "There's a really well printed note on the ground here. The resolution is like nothing you've ever seen come out of your dot-matrix printers.";
	initDesc = "It's just a note. You wonder why it hasn't blown away yet.";
}

newspaper : Readable, Thing
'news/paper/tartan/newspaper' 'an issue of "The Tartan"' @dh_entrance
"It's what passes for a newspaper at this school. " {
	initSpecialDesc = "A newspaper lies discarded on the ground. ";
	readDesc {
		"The headline reads \"\'Graduation Groovy,\' Quips Cyert.\"\n
		The story goes on to describe the graduation ceremonies, which went off without a hitch.\n Suddenly, a horrible realization dawns on you.  That was YOUR graduation.  And you don't remember any of it!  Dazedly you check the date on the paper -- sure enough, two days after graduation. You must have slept completely through it!  You didn't graduate, and you didn't get your diploma, and now you're not going to get that new Porsche from MegaMissles, Inc., either.  Without a diploma, they'll never hire you, no matter what that recruiter said. \n<b>You're dead meat.</b>\n";
		newspaper.achievement.awardPointsOnce();
	}

	achievement : Achievement { +5 "being dumb enough to miss your graduation, but smart enough to read the newspaper to find that out! " };
}



