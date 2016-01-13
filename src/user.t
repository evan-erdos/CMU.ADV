/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-19 * user */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"
#pragma newline_spacing(preserve)


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
 **/
user : BagOfHolding, Mortal {
    name = 'Paul Erdos';
    firstname = 'Paul';
    lastname = 'Erdos';
    gender = Male;
    vocabWords = 'me/self/<<name>>';
#ifndef __DEBUG
    location = the_cut;
#else
    location = ghc_9_entrance;
#endif
    issueCommandsSynchronously = true;
    bulk = 10;
    isCriminal = null;
    crimes = 0;
    reputation = 50;
    desc {
        "You look like you need some rest. You're sore, and you have some serious bags under your eyes.";
        holdingDesc;
        /* inventoryListener: actorInventoryListener */
    }

    firstNames = [
        ['Robert', Male],   ['Roberta', Female],
        ['Harold', Male],   ['Carol', Female],
        ['Jessie', Male],   ['Jessica', Female],
        ['Reginald', Male], ['Regina', Female],
        ['Leonard', Male],  ['Leah', Female],
        ['Jerry', Male],    ['Jenny', Female],
        ['Thomas', Male],   ['Tina', Female],
        ['Alex', Male],     ['Alex', Female]];

    lastNames = [
        'Watson', 'Wilson', 'King', 'Seinfeld',
        'the Marauder', 'the Baby Crusher',
        'Faulkner', 'Card', 'Clark', 'Skywalker',
        'Joyce', 'Rivera', 'Fitzgerald', 'Huxley',
        'Thompson', 'Poe', 'Vogel', 'Hoenikker',
        'Austen', 'Wilde', 'Tolstoy', 'Pynchon',
        'Kafka', 'Bradbury', 'Dickinson', 'Plath',
        'Salinger', 'Lysander', 'Orwell', 'Eliot',
        'Goethe', 'Lindgren', 'Roethke', 'Asimov'];


    init() {
        " "; user.setName();
        "\b\nName: <<user.name>>, <<user.printGender()>>";
        clear;
    }

    reset() {
        user.travelTo(root,root_door_1, root_door_0);
        travelerTravelWithin(user,root_bed);
        user.makePosture(lying);
    }

    engender(m,f) { return (user.gender==Male)?(m):(f); }

    setName() {
        local cmd;
        for (local i=0;true;i++) {
            cmd = inputManager.getInputLine(null,
                {:"\b\nWho will you be?  &gt;" });
            cls();
            if (cmd=='') {
                if (i<1) "Go ahead, pick a name for yourself. ";
                else if (i<2) {
                    """
                    No name, huh? You're a "no-name" kind of guy, huh? Fine. I'll do the legwork.

                    You might not appreciate this, but a programmer somewhere just groaned.
                    """;
                    local n = 1+rand(firstNames.length-1);
                    user.firstname = firstNames[n][1];
                    user.gender = firstNames[n][2];
                    user.lastname = lastNames[1+rand(lastNames.length-1)];
                    user.name = '<<user.firstname>> <<user.lastname>>';
                    return;
                }
            }

            if (i>7) { "Ok, you're done here. Come back when you've gradutated from the 5th grade."; i/=0; }
            else if (i>6)
                "You're really going for it, huh?";
            else if (i>5)
                "You're testing my patience.";
            else if (cmd.length()<3)
                "You really should have a name.";
            else if (rexSearch('(ben|benjamin)',cmd.toLower()))
                "Be more original.";
            else if (cmd.length()>24)
                "What are you, some kind of 16th century Spanish noble? Be reasonable, here.";
            else if (rexSearch('%d',cmd))
                "A real name please.";
            else if (rexSearch(util.obscenities,cmd))
                "So, common decency, too. Call me particular.";
            else {
                user.name = cmd; " ";
                user.setGender();
                return;
            }
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
                    "Pick a gender for yourself. "; continue;
                } else if (i<2) {
                    local b = ((rand(3)%2)==0);
                    "What, no gender? I guess that's ok. Get ready to be a <<(b)?'':'wo'>>man. ";
                    user.gender = (b)?Male:Female; return;
                }
            }
            if (i>5) { "Have it your way."; i/=0; }
            else if (i>4)
                "I will do something nasty if you don't quit it.";
            else if (i>3) "Can we get to the point, here?";
            else if (rexMatch('b|boy|m|male|man|masculine',cmd.toLower())) { user.gender = Male; break; }
            else if (rexMatch('f|fe|female|feminine|g|girl|lady',cmd.toLower())) { user.gender = Female; break; }
            else "Gender isn't black and white, I get it, and there's nothing wrong with that, but just... like.. if you had to choose...";
        }
    }

    printGender() { return (user.gender==Male)?'Male':'Female'; }

    commitCrime(n) { /* n is severity of crime */
        user.crimes+=n; // as it is, you can't ever repent
        if (user.crimes>15) user.setCriminal(true);
    }

    setCriminal(b) {
        user.isCriminal = true;
        """
        <b>** You have commited a heinous crime. If anyone learns of your deeds, you will either be a prisoner or a fugitive for the rest of your life. **</b>
        """;
    }
}

