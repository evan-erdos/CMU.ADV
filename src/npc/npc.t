/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-20 * npcs */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"
#pragma newline_spacing(preserve)


class Mortal : Person {
    maxHealth = 16;
    health = 16;
    isDead = null;
    strength = 9;
    swing = 9;
    dodge = 5;
    weapon_damage = 1;

    Harm(n) { /* virtual */ }

    attackDamage() { return self.strength+weapon_damage; }
}

class NPCWorn : Wearable {
    wornBy = (location);
    hideFromAll(action) { return true; }
}

class Group : Mortal { isPlural = true; isIt = true; }


/* Humans of CMU something something mumble hipster */

emily_dickinson : Person 'Emily' @cfa_field
"""
She sits quietly in a stiff wooden chair. She is deathly pale, and you know what color she's wearing.
""" {
    isHer = true;

    npcDesc {
        '''
        A solemn thing - it was - I said -
        A Woman - White - to be -
        And wear - if God should count me fit -
        Her blameless mystery -

        F 307 (1862) 271
        ''';
    }

    isProperName = true;
    vocabWords = 'em/emmy/emily/emily dickinson/dickinson';
    properName = 'Emily Dickinson';
    globalParamName = 'emily';
}

+ NPCWorn '(white|summer) frock/dress/housedress' 'dress'
"""
It's a very clean, very white housedress.
""" {
    isListed = (!isIn(emily_dickinson));
}


paul_erdos : Person 'Paul Erdos' @hh_entrance
"""
He looks slightly thinner than he did the last time you saw him, and his hair is all over. You know he gives it a perfunctory comb now and then, but not to the exclusion of his math. He's recently begun to roll his eyes at you when you ask him how many seconds have passed since you were born, but he still begrudgingly tells you, and gives a half-smile.
""" {
    vocabWords = 'paul/paul erdos/erdos';
    isProperName = true;
}

