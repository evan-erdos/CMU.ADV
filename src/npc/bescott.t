/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-20 * bescott */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"
#pragma newline_spacing(preserve)


/** `ben_scott` : **`Person`**
 *
 * An object definition (don't objectify me!) like this can be
 * thought of as a new instance of its base class. This is an
 * instance of yours truly. This is an unusual concept, as a
 * program or programming language usually separates 'code' and
 * 'data' in a more rigorous way, but in TADS3, it's almost the
 * same thing, and the loose structure allows for it.
 *
 * - `vocabWords` : **`regex`**
 *     I'm not sure if these are real `regex`es, but they are
 *     patterns that the interpreter attempts to match against
 *     user input to determine if it's being referred to.
 *
 * - `name` : **`string`**
 *     The printed title of this object. Mine's bold. I might
 *     even color it all funny, who knows?
 *
 * - `location` : **`Room`**
 *     It's S&P to use the `@location` syntax instead of `+`
 *     for anything which has a tendency to move about. In the
 *     case of static scenery, or things which cannot move, the
 *     `+` is preferable, being a more suitable syntax.
 *
 * - `isBetterThanYou` : **`bool`**
 *     Just an example of how properties can be attached to any
 *     `object`, i.e., just via declaration.
 **/
ben_scott : Person
'(cool) ben/scott/bescott/ben scott/guy'
'<b>Ben Scott</b>' @ghc_9_window
"""
He wears an obnoxious, neon shirt, and looks at you expectantly when you approach him. He knows that he's more clever than you are, but he's, frankly, too kind to admit it. Even if he did, you'd probably agree: He's pretty clever.
""" {
    isBetterThanYou = true;

    initSpecialDesc { // executes when user !ben_scott.seen
        isInInitState = null; // set to null once we've run
        user.name = user.name.toUpper(); // name trick
        achievement.awardPointsOnce(); // award points once
        """
        Ben Scott is standing here. He turns to you and says "<b>So</b>, full disclosure here: I lost my script. Yeah, they didn't tell me what to say here, so, eh... Hi? How are you..." he squints a bit, and looks at your chest, where, all of a sudden, a nametag has appeared! "<<user.name.toLower()>>? So, eh, you're... not a big fan of capital letters then, huh?" Sure enough, you look down again and it's written differently! Your name is in all caps now. <<user.engender('What a guy.','You just can\'t help but think how dreamy he is.')>>
        """;
    }

    specialDesc { ben_scott_list.doScript(); } // with room
    achievement : Achievement {
        /* An exorbitant number of points, but I'm worth it. */
        +64 "finding the infamous Ben Scott. " }
}


/** `ben_scott_list` : **`ShuffledEventList`**
 *
 * This of one of the most useful types of `EventList`s. It
 * iterates through the first list in the template in order,
 * and then it runs any of the elements in the second list in a
 * chaotic fashion, i.e., no element played twice in a row.
 **/
ben_scott_list : ShuffledEventList
['''
He seats himself in the weird chair, but just as soon as he leans into his computer, he leans back out again, and put's his feet up. You glance at his screen, and you can tell that he's rewritten his entire kernel from memory or something I mean, I dunno, does that sound like an impressive thing? Asking for a friend."<b>cd ../;2D;2D;2D;2C</b>whoops<b>:quit:q</b>how do i...<b>C-c C-c is undefined</b>come on<b>C-x C-c</b>
''',{: """
He just starts speaking to you out of nowhere. "I once killed a man in the desert, just because I wanted to see if it would inspire me artistically. It didn't. Do you know the elevator trick? That's how I got here. You take the bigger elevator down to the first floor, and when the door opens, you can reach outside to a button on the frame to your left, and then get to any floor you want! I think it's pretty neat. Do you like coffeecake? I don't know how I feel about it, really..." You stop listening.
""",ghc_button.achievement.awardPointsOnce()} ]
['''
He gets up to stretch, and looks out the window. It is an exceptional view.
''','''
His titanium cup is full of coffee again. You didn't notice him leave.
''','''
He types something, giggles to himself, but then instantly returns to looking stoic and stately when he realizes you're still here.
'''];



