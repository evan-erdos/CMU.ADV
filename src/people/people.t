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


class Mortal : Person {
    maxHealth = 16;
    health = 16;
    isDead = null;
    strength = 9;
    swing = 9;
    dodge = 5;
    weapon_damage = 1;

    Harm(n) { /* must be implemented by subclass */ }

    attackDamage() { return self.strength+weapon_damage; } // weapon_damage -> ref item
}

class NPCWorn : Wearable {
    wornBy = (location);
    hideFromAll(action) { return true; }
}

class Group : Mortal { isPlural = true; isIt = true; }


/* Humans of CMU something something mumble hipster */

emily_dickinson : Person 'Emily' @cfa_field
"She sits quietly in a stiff wooden chair. She is deathly pale, and you know what color she's wearing." {
    isHer = true;
    npcDesc {
        'A solemn thing - it was - I said -
        A Woman - White - to be -
        And wear - if God should count me fit -
        Her blameless mystery -

        F 307 (1862) 271';
    }
    isProperName = true;
    vocabWords = 'em/emmy/emily/emily dickinson/dickinson';
    properName = 'Emily Dickinson';
    globalParamName = 'emily';
}

+ NPCWorn '(white|summer) frock/dress/housedress' 'dress'
"It\'s a very clean, very white housedress." {
    isListed = (!isIn(emily_dickinson));
}


paul_erdos : Person 'Paul Erdos' @hh_entrance
"He looks slightly thinner than he did the last time you saw him, and his hair is all over. You know he gives it a perfunctory comb now and then, but not to the exclusion of his math. He's recently begun to roll his eyes at you when you ask him how many seconds have passed since you were born, but he still begrudgingly tells you, and gives a half-smile. " {
    vocabWords = 'paul/paul erdos/erdos';
    isProperName = true;
}

