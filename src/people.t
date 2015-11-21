/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-20 * people */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

/* I've added this file as a kind of tutorial, for those who'd
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

/* object definition (don't objectify me!)
 * but still, I'm an instance of the Person class */
ben_scott : Person
/* I'm using the actor template, so these are the vocabWords */
'ben/scott/bescott/ben scott/cool kid'
/* similar story for the name and location. It's s&p to use the
 * @location syntax instead of the + notation for people and
 * items which have a tendency to move about */
'<b>Ben Scott</b>' @ghc_9_window
/* this is the explicit description, which is run when the user
 * looks directly at me, or examines me */
"He wears an obnoxiously neon shirt, and looks at you expectantly when you approach him. He knows that he's better than you, but he's frankly too kind to say so. Even if he did, you'd probably agree: He's pretty clever. " {
    isBetterThanYou = true; // you can add properties to anything like this
    initSpecialDesc { // special message, runs when user !ben_scott.seen
        isInInitState = null; // set to null once we've run
        user.name = user.name.toUpper(); // name trick
        achievement.awardPointsOnce(); // award points
        "Ben Scott is standing here. He turns to you and says \"<b>So</b>, full disclosure here: I lost my script. Yeah, they didn't tell me what to say here, so, eh... Hi? How are you...\" he squints a bit, and looks at your chest, where, all of a sudden, a nametag has appeared! \"<<user.name.toLower()>>? So, eh, you're... not a big fan of capital letters then, huh?\" Sure enough, you look down again and it's written differently! Your name is in all caps now. <<user.engender('What a guy.','You just can\'t help but think how dreamy he is.')>>"; }
    specialDesc { ben_scott_list.doScript(); } // prints with room
    /* This is a template also. This is a large number of points. */
    achievement : Achievement { +64 "finding the infamous Ben Scott. " }
}

/* Shuffled event lists are pretty useful, it iterates through
 * the first list in the template in order, and then it runs
 * any of the elements in the second list chaotically, i.e., /c
 * no element played twice in a row */
ben_scott_list : ShuffledEventList
['He seats himself in the weird chair, but just as soon as he leans into his computer, he leans back out again, and put\'s his feet up. You glance at his screen, and you can tell that he\'s rewritten his entire kernel from memory or something I mean, I dunno, does that sound like an impressive thing? Asking for a friend.\"<b>cd ../;2D;2D;2D;2C</b>whoops<b>:quit:q</b>how do i...<b>C-c C-c is undefined</b>come on<b>C-x C-c</b>',
/* this is actually a short anonymous function, it prints the
 * string and awards points for the button puzzle */
{: "He just starts speaking to you out of nowhere. \"I once killed a man in the desert, just because I wanted to see if it would inspire me artistically. It didn't. Do you know the elevator trick? That's how I got here. You take the bigger elevator down to the first floor, and when the door opens, you can reach outside to a button on the frame to your left, and then get to any floor you want! I think it's pretty neat. Do you like coffeecake? I don't know how I feel about it, really...\" You stop listening.",
    ghc_button.achievement.awardPointsOnce()} ]
['He gets up to strech, and looks out the window. It is an exceptional view. ',
 'His titanium cup is full of coffee again. You didn\'t notice him leave. ',
 'He types something, giggles to himself, but then instantly returns to looking stoic and stately when he realizes you\'re still here. '];
