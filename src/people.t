/* Ben Scott - bescott@andrew.cmu.edu - 2015-09-20 - CMU.ADV - people */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

/* Hi guys.
 *
 * I've added this file as a kind of tutorial, for those who'd
 * like to become rich and famous, (i.e., people who want to be
 * in the game, but aren't hacking the mainframe enough to have
 * added themselves in already).
 *
 * You can add yourself in as a person, put something somewhere
 * on campus, &/| add your dorm room. There are no rules, aside
 * from not breaking anything / adding comments that say things
 * like, "THE NEXT INSTANCE OF PERSON DEFINED BELOW THIS POINT
 * IS A LITTLE BIIIITTTCCCCHHHHH!! HAHAA!! BUSH-REAGAN 1984!!!"
 * I trust you people. */

/* Humans of CMU something something mumble hipster */

ben_scott : Person 'ben/scott/bescott/ben scott/cool kid'
'<b>Ben Scott</b>' @ghc_9_window
"He wears an obnoxiously neon shirt, and looks at you expectantly when you approach him. He knows that he's better than you, but he's frankly too kind to say so. Even if he did, you'd probably agree: He's pretty clever. " {
	isBetterThanYou = true; // you can add properties to anything like this
	initSpecialDesc {
		isInInitState = null;
		user.name = user.name.toUpper();
		achievement.awardPointsOnce();
		"Ben Scott is standing here. He turns to you and says \"<b>So</b>, full disclosure here: I lost my script. Yeah, they didn't tell me what to say here, so, eh... Hi? How are you...\" he squints a bit, and looks at your chest, where, all of a sudden, a nametag has appeared! \"<<user.name.toLower()>>? So, eh, you're... not a big fan of capital letters then, huh?\" Sure enough, you look down again and it's written differently! Your name is in all caps now. <<user.engender('What a guy.','You just can\'t help but think how dreamy he is.')>>"; }
	specialDesc { ben_scott_list.doScript(); }

	achievement : Achievement { +64 "finding the infamous Ben Scott. " }
}

ben_scott_list : ShuffledEventList
['He seats himself in the weird chair, but just as soon as he leans into his computer, he leans back out again, and put\'s his feet up. You glance at his screen, and you can tell that he\'s rewritten his entire kernel from memory, or something, I mean, I dunno, does that sound like an impressive thing? Asking for a friend.\"<b>cd ../;2D;2D;2D;2C</b>whoops<b>:quit:q</b>how do i...<b>C-c C-c is undefined</b>come on<b>C-x C-c</b>',
'He just starts speaking to you out of nowhere. "I once killed a man in the desert, just because I wanted to see if it would inspire me, artistically. It didn\'t. Do you know the elevator trick? That\'s how I got here. You take the bigger elevator down to the first floor, and when the door opens, you can reach outside to a button on the frame to your left, and then get to any floor you want! I think it\'s pretty neat. Do you like coffeecake? I don\'t know how I feel about it, really..." You stop listening.<<ghc_button.achievement.awardPointsOnce()>> ']
['He gets up to strech, and looks out the window. It is an exceptional view. '];


