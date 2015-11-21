/* Ben Scott * bescott@andrew.cmu.edu * 2015-11-21 * Examples */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

/** Examples
 *
 * I've added this file as a kind of tutorial, for those who'd
 * like to become rich and famous, (i.e., people who want to be
 * in the game, but aren't hacking the mainframe enough to have
 * added themselves in already).
 *
 * You can add yourself in as a person, put something somewhere
 * on campus, &/| add your dorm room. There are no rules, aside
 * from not breaking anything / adding comments that say things
 * like "THE NEXT INSTANCE OF PERSON DEFINED BELOW THIS POINT
 * IS A LITTLE BIIIITTTCCCCHHHHH!! HAHAA!! BUSH-REAGAN 1984!!!"
 * I trust you people.
 *
 * Below are some very well commented examples of common kinds
 * of objects / game entities, and elsewhere in this folder,
 * you can find simple templates for the same objects, so you
 * can write your own story!
 *
 * To help you more easily differentiate the explanation text
 * from code, e.g., names of classes, properties and the like,
 * any valid code will appear in `backticks`, such that when I
 * put a real tutorial on my website, it will show up as code
 * blocks, rendered by Markdown.
 *
 * For example: `initSpecialDesc` is a special property, and
 * will be in backticks, its explanation will not be.
 *
 * The main/only interface that players have to this kind of
 * text adventure is plain-old text-based command input.
 *
 * To identify this, I have gone through the comments and added
 * **double asterisks** around any plausible player commmands,
 * also so that my website will render it properly, and make it
 * more legible.
 *
 * Finally, you will want a text editor that wraps lines. There
 * will be a lot of text that you probably don't want to bother
 * line-wrapping yourself, especially if your style of writing
 * is as rampantly revisionist as mine is.
 **/


/* Humans of CMU something something mumble hipster */


/** Example `Person` definition
 *
 * This follows the basic form of any other object definition
 * (don't objectify me!) but still, I'm an instance of `Person`
 **/
ben_scott : Person 'ben/scott/bescott/ben scott/cool kid'
'<b>Ben Scott</b>' @ghc_9_window
"He wears an obnoxiously neon shirt, and looks at you expectantly when you approach him. He knows that he's better than you, but he's frankly too kind to say so. Even if he did, you'd probably agree: He's pretty clever. " {

    /** `isBetterThanYou`
     *
     * To any definition of an object, you can simply tack on
     * properties by declaring them, like this. Is this clean?
     * No. Does this violate the Geneva Convention of Good
     * Programming Language Design Decisions? Yes. Don't let it
     * get to you. Maybe even use it once and awhile.
     **/
    isBetterThanYou = true;

    initSpecialDesc {

        isInInitState = null;

        user.name = user.name.toUpper(); // in-game name trick

        // award points when this description is read
        achievement.awardPointsOnce();

        /** A note on seemingly random string literals in code
         *
         * Because printing is such a frequent event in text-
         * adventures, TADS3 automatically `print`s or `say`s
         * any double-quoted string. Single quoted strings are
         * for string literals that shouldn't be evaluated the
         * instant that they're interpreted.
         **/
        "Ben Scott is standing here. He turns to you and says \"<b>So</b>, full disclosure here: I lost my script. Yeah, they didn't tell me what to say here, so, eh... Hi? How are you...\" he squints a bit, and looks at your chest, where, all of a sudden, a nametag has appeared! \"<<user.name.toLower()>>? So, eh, you're... not a big fan of capital letters then, huh?\" Sure enough, you look down again and it's written differently! Your name is in all caps now. <<user.engender('What a guy.','You just can\'t help but think how dreamy he is.')>>"; }

    specialDesc { ben_scott_list.doScript(); } // prints with room

    /** `Achievement` property
     *
     * This both uses a `template` and also grants a relatively
     * large number of points.
     **/
    achievement : Achievement { +64 "finding the infamous Ben Scott. " }
}

ben_scott_list : ShuffledEventList
['He seats himself in the weird chair, but just as soon as he leans into his computer, he leans back out again, and put\'s his feet up. You glance at his screen, and you can tell that he\'s rewritten his entire kernel from memory or something I mean, I dunno, does that sound like an impressive thing? Asking for a friend.\"<b>cd ../;2D;2D;2D;2C</b>whoops<b>:quit:q</b>how do i...<b>C-c C-c is undefined</b>come on<b>C-x C-c</b>',

    // this is actually a short anonymous function, it prints
    // the string and awards points for the button puzzle.
{: "He just starts speaking to you out of nowhere. \"I once killed a man in the desert, just because I wanted to see if it would inspire me artistically. It didn't. Do you know the elevator trick? That's how I got here. You take the bigger elevator down to the first floor, and when the door opens, you can reach outside to a button on the frame to your left, and then get to any floor you want! I think it's pretty neat. Do you like coffeecake? I don't know how I feel about it, really...\" You stop listening.",
    ghc_button.achievement.awardPointsOnce()} ]
['He gets up to strech, and looks out the window. It is an exceptional view. ',
 'His titanium cup is full of coffee again. You didn\'t notice him leave. ',
 'He types something, giggles to himself, but then instantly returns to looking stoic and stately when he realizes you\'re still here. '];




