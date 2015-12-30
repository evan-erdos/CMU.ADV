/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-19 * user */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"


/** `user` : **`Mortal`**
 *
 * This is the primary class representing the player. Anything
 * which pertains to the main player should be included here.
 * It inherits from **`BagOfHolding`**, to simulate a person's
 * pockets and general ability to carry things, and from the
 * **`Mortal`** class, which is a kind of **`Person`** which
 * can be killed or harmed in one way or another.
 *
 * - `name` : **`string`**
 *     The `user` will be referred to as this when being listed
 *     in a room, or when being addressed by another `Actor`.
 *
 * - `firstname` : **`string`**
 *     a surname to be used in certain special encounters.
 *
 * - `lastname` : **`string`**
 *     see `firstname`
 *
 * - `gender` : **`Gender`**
 *     a value of the `enum` which defines gender.
 *
 * - `location` : **`Room`**
 *     the initial location for the player.
 *
 * - `bulk` : **`int`**
 *     amount of weight the `user` can carry without using a
 *     holdall, e.g., the `backpack`.
 *
 **/
user : BagOfHolding, Mortal {
    name = 'Paul Erdos';
    firstname = 'Paul';
    lastname = 'Erdos';
    gender = male;
    vocabWords = 'me/self/<<name>>';
    location = the_cut;
    issueCommandsSynchronously = true;
    bulk = 10;
    isCriminal = null;
    crimes = 0;
    reputation = 50;
    desc {
        "You look like you need some rest. You\'re sore, and you have some serious bags under your eyes.";
        holdingDesc; /* inventoryListener: actorInventoryListener */
    }

    init() {
        " "; user.setName();
        " "; user.setGender();
        "\b\nName: <<user.name>>, <<user.printGender()>>";
        clear;
    }

    reset() {
        user.travelTo(root,root_door_1, root_door_0);
        travelerTravelWithin(user,root_bed);
        user.makePosture(lying);
    }

    engender(male_text,female_text) {
        return (user.gender==male)?(male_text):(female_text);
    }

    setName() {
        local cmd;
        for (local i=0;true;i++) {
            cmd = inputManager.getInputLine(null,
                {:"\b\nWho will you be?  &gt;" });
            cls();
            if (cmd=='') {
                if (i<1) "Go ahead, pick a name for yourself. ";
                else if (i<2) {
                    "No name, huh? You're a 'no-name' kind of guy, huh? Fine. You're the little mermaid now. ";
                    user.name = 'The Little Mermaid';
                    user.firstname = 'The Little';
                    user.lastname = 'Mermaid';
                    break;
                }
            }

            if (i>7) { "Ok, you're done here. Come back when you've gradutated from the 5th grade."; i/=0; }
            else if (i>6) "You're really going for it, huh?";
            else if (i>5) "You're testing my patience.";
            else if (cmd.length()<3) "You really should have a name.";
            else if (rexSearch('%b(ben|benjamin)%b',cmd.toLower())) "Be more original.";
            else if (cmd.length()>24) "What are you, some kind of 16th century Spanish noble? Be reasonable, here.";
            else if (rexSearch('%d',cmd)) "A real name please.";
            else if (rexSearch(util.obscenities,cmd)) "So, common decency, too. Call me particular.";
            else { user.name = cmd; break; }// { formatName(cmd); break; }
        }
    }

    formatName(cmd) {
        user.name = cmd;
        if (rexSearch('%w %w',cmd)) {
            local s = cmd.split(' ');
            if (s!=null && s.length()>=2) {
                user.firstname = util.capitalize(s[0]);
                user.lastname = util.capitalize(s[1]);
            }
        }
    }

    setGender() {
        local cmd;
        for (local i=0;true;i++) {
            cmd = inputManager.getInputLine(null,
                {:"\b\nMale or Female?  &gt; " });
            cls();
            if (cmd=='') {
                if (i<1) {
                    "Go ahead, pick a gender for yourself. "; continue;
                } else if (i<2) {
                    "What, no gender";
                    if (user.name=='The Little Mermaid')
                        " either? Fine. You're a woman now. ";
                    else "? I guess that's ok. Get ready to become a woman. ";
                    user.gender = female; break;
                }
            }
            if (i>5) { "Have it your way.";
                finishGameMsg('You have missed the point entirely.',null);
            } else if (i>4) "I will do something nasty if you don't shape up.";
            else if (i>3) "Can we get to the point, here?";
            else if (rexMatch('b|boy|m|male|man|masculine',cmd.toLower())) {
                user.gender = male; break; }
            else if (rexMatch('f|fe|female|feminine|g|girl|lady',cmd.toLower())) { user.gender = female; break; }
            else "Gender isn't black and white, I get it, and there's nothing wrong with that, but just... like.. if you had to choose...";
        }
    }

    printGender() {
        return (user.gender==male)?'Male':'Female'; }

    commitCrime(n) { /* n is severity of crime */
        user.crimes+=n; // as it is, you can't ever repent
        if (user.crimes>15) user.setCriminal(true);
    }

    setCriminal(b) {
        user.isCriminal = true;
        "\n<b>** You have commited a heinous crime. If anyone learns of your deeds, you will either be a prisoner or a fugitive for the rest of your life. **</b>";
    }
}


