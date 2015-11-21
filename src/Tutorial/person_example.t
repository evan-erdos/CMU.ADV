/* Ben Scott * bescott@andrew.cmu.edu * 2015-11-21 * Person Example */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

/** `person_example`
 *
 * This is a basic setup for a person. This person will exist
 * at the entrance to Doherty Hall.
 **/
person_example : Person

/** `vocabWords`
 *
 * The class of `Person` inherits from `Actor`, and therefore,
 * the `Actor` `template`. These are the `vocabWords`, which
 * are a bunch of words (in a psuedo-regex format) that can be
 * used to identify whatever they're attached to.
 *
 * For instance, the user might type **examine cool kid**, and
 * this will perform the same action as **look at ben** would,
 * because of these `vocabWords`.
 **/
'person/man/that guy/him'

/** `name` & `location`
 *
 * These two are also defined on the `Actor` `template`, and
 * are rather straightforward:
 *
 * - `name` is what to print when referring to this object
 *
 * - `location` refers to the `Room` where it can be found
 *
 * It's s&p to use the `@` syntax instead of the `+` notation
 * for people and items, which have a tendency to move about.
 *
 * I don't like either notation, really, as the `+`
 * notation makes code reliant upon its position in the file
 * for its meaning, and the `@` is... slightly better.
 **/
'John Cena' @dh_entrance

/** `desc` or `description`
 *
 * The `desc` is one of the most common properties to put in a
 * `template`
 *
 * - `name` is what to print when referring to this object
 *
 * - `location` refers to the `Room` where it can be found
 *
 * It's s&p to use the `@` syntax instead of the `+` notation
 * for people and items, which have a tendency to move about.
 *
 * I don't like either notation, really, as the `+`
 * notation makes code reliant upon its position in the file
 * for its meaning, and the `@` is... slightly better.
 **/
"This is the description of this person. " {

    /** `initSpecialDesc`
     *
     * This is a special kind of description that prints with
     * the `Room`'s description, in most cases it's only used
     * once, or until the user does something to this object,
     * and then setting `isInInitState` to `null` keeps it
     * from printing after that.
     **/
    initSpecialDesc {

        /** `isInInitState`
         *
         * Setting this to `null` once it's been run indicates
         * that the user has seen/read this description. While
         * this is usually an automatic behavior, sometimes it
         * is adventageous to have manual control over this.
         **/
        isInInitState = null;
        "This is the first time you're seeing this person.
        This message will not be displayed again. ";
    }

    /** `specialDesc`
     *
     * This property also prints with the room, but does so
     * persistently, unlike `initSpecialDesc`, which is only
     * evaluated until `isInInitState` is set to `null`. This
     * evaluates the associated list, `ben_scott_list`, and
     * will print a "random"-ish element from that list (the
     * precise nature of what it will do is described below).
     **/
    specialDesc { person_example_list.doScript(); }
}

/** `ShuffledEventList`
 *
 * These are pretty useful: they iterate through the first list
 * in the `template` in order, and then run any of the elements
 * in the second list chaotically, i.e., with no element played
 * twice in a row. Again, the weird syntax is the result of a
 * pretty useful `template`.
 **/
person_example_list : ShuffledEventList
    ['These descriptions will be printed in sequence.',
     'One after the other, linearly.']
    ['These will not appear linearly.',
     'These will appear in an almost random order.',
     'This will only happen after the first list of descriptions is exhausted.',
     'This format is suprisingly useful when trying to write complicated events and interactions, as it lends a sense of randomness to the game.',
     'Being that this is "Shuffled" not "Random", and given the nature of these games, it will not print the same element twice in a row. This makes things more believeable for the reader.'];

