/* Ben Scott - bescott@andrew.cmu.edu - 2015-09-19 - CMU.ADV - npcs */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

modify Actor {
	makeProper() {
		if (isProperName==null && properName!=null) {
			name = properName;
			isProperName = true;
			initializeVocabWith(properName);
		} return name;
	}
}

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

cmu_officer : Person 'man/police/officer' 'Cmu Campus Officer'  @south_cut
"This cop is mean and ugly; he's the Clint Eastwood of the academic world. You'd better not mess with him." {
	specialDesc = "A campus police officer is here, eyeing you suspiciously.";
	readDesc = "The cop has <b>mean<\b> written all over him.";
}


emily_dickinson : Person 'Emily'
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

+ NPCWorn 'white frock/white summer dress/housedress' 'white dress' "It\'s a very clean, very white housedress." {
}

paul_erdos : Person 'Paul' @south_cut
"He looks slightly thinner than he did the last time you saw him. His hair is all over. You know he gives it a perfunctory comb now and then, but not to the exclusion of his math. He's recently begun to roll his eyes at you when you ask him how many seconds have passed since you were born, but he still begrudgingly tells you. " {
	vocabWords = 'paul/paul erdos/erdos';
}
