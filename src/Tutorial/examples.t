/* Ben Scott * bescott@andrew.cmu.edu * 2015-12-01 * Examples */

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
 * Below are some uncommented examples of common objects. These
 * will hopefully give readers a sense of what the most typical
 * syntax is for these objects, and will act as a sort of code
 * formatting standard for the rest of the project. For better
 * and more commented examples, look in `src/Tutorial/`.
 *
 * Finally, you will want a text editor that wraps lines. There
 * will be a lot of text that you probably don't want to bother
 * line-wrapping yourself, especially if your style of writing
 * is as rampantly revisionist as mine is.
 **/


/** Example `Person` definition
 *
 * This is a basic setup for a person. This person will exist
 * at the entrance to Doherty Hall. The type is defined after
 * the colon, and the rest of the items thereafter before the
 * start of this definition's code block are specified by the
 * `Actor` template.
 *
 * If you're into writing documentation comments, they look
 * like this. I've been using `Markdown` in them quite a bit so
 * I can just paste them into the wiki on github.
 **/
person_example : Person 'person/man/that guy/him' 'John Cena' @dh_entrance
"This is the description of this person, which I usually put on its own line. " {
    // beginning of this definition's scope
    initSpecialDesc {
        isInInitState = null;
        "This is the first time you're seeing this person.
        This message will not be displayed again. ";
    }

    specialDesc { person_example_list.doScript(); }
}

/* scope can be delimited by `C`-style brackets, or also with a
 * single trailing semicolon. I prefer the former quite a bit,
 * as it looks more like other languages, is visually clearer
 * because the starting bracket denotes where the template ends
 * and the scope begins, and also doesn't rely on indentation.
 *
 * This could also be written as:
 *
 * ```
 * person_example : Person 'person' 'John' @dh_entrance
 * "description!"
 *     // whatever you please
 *     lim = 9001
 * ;
 *```
 */

/** `ShuffledEventList`
 *
 * These are pretty useful: they iterate through the first list
 * in the `template` in order, and then run any of the elements
 * in the second list chaotically, i.e., with no element played
 * twice in a row. Again, the weird syntax is the result of a
 * pretty useful `template`. This isn't part of the definition
 * above because the syntax looks weird.
 **/
person_example_list : ShuffledEventList
    ['These descriptions will be printed in sequence.',
     'One after the other, linearly.']
    ['These will not appear linearly.',
     'These will appear in an almost random order.',
     'This will only happen after the first list of descriptions is exhausted.',
     'This format is suprisingly useful when trying to write complicated events and interactions, as it lends a sense of randomness to the game.',
     'Being that this is "Shuffled" not "Random", and given the nature of these games, it will not print the same element twice in a row. This makes things more believeable for the reader.'];
