/* Ben Scott - bescott@andrew.cmu.edu - 2015-09-19 - CMU.ADV - user */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

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

	setName() {
		local cmd;
		for (local i=0;true;i++) {
			cmd = inputManager.getInputLine(null, {:"\b\nWho will you be?  &gt;" });
			if (i>7) { "Ok, you're done here. Come back when you've gradutated from the 5th grade."; i/=0;
			} else if (i>6) "You're really going for it, huh?";
			else if (i>5) "You're testing my patience.";
			else if (cmd.length()<3) "You really should have a name.";
			else if (rexSearch('%b(ada|adaline|adaline braun|genti|gentiana)%b',cmd.toLower())) "Be more original.";
			else if (cmd.length()>24) "What are you, some kind of 16th century Spanish noble? Be reasonable, here.";
			else if (rexSearch('%d',cmd)) "A real name please.";
			else if (rexSearch(util.obscenities,cmd.toLower())) "So, common decency, too. Call me particular.";
			else { formatName(cmd); break; }
		}
	}

	formatName(cmd) {
		user.name = cmd;
		if (rexSearch('%w %w',cmd)) {
			local s = cmd.split(' ');
			if (s.length()<2) {
				user.firstname = util.capitalize(cmd);
				user.lastname = util.capitalize(cmd);
			} else {
				user.firstname = util.capitalize(s[0]);
				user.lastname = util.capitalize(s[1]);
			}
		}
	}

	setGender() {
		local cmd;
		for (local i=0;true;i++) {
			cmd = inputManager.getInputLine(null, {:"\b\nMale or Female?  &gt;" });
			if (i>5) {
				"Have it your way."; i/=0;
			} else if (i>4) "I will do something really nasty if you don't shape up.";
			else if (i>3) "Can we get to the point, here?";
			else if (rexMatch('b|boy|m|male|man|masculine',cmd.toLower())) {
				user.gender = male; break; }
			else if (rexMatch('f|fe|female|feminine|g|girl|lady',cmd.toLower())) { user.gender = female; break; }
			else "Gender isn't black and white, I get it, and there's nothing wrong with that, but if you had to choose...";
		}
	}

	printGender() { return (user.gender==male)?'Male':'Female'; }

	commitCrime(n) { /* n is severity of crime */
		user.crimes+=n; // as it is, you can't ever repent
		if (user.crimes>15) user.setCriminal(true);
	}

	setCriminal(b) {
		user.isCriminal = true;
		"\n<b>** You have commited a heinous crime. If anyone learns of your deeds, you will either be a prisoner or a fugitive for the rest of your life. **</b>";
	}
}


