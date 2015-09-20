/* Ben Scott - 201505142021 - vividity - util */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

util : object {

	capitalize(s) {
		//if (s.length()<1) return s.toUpper();
		return s.splice(0,1,s[0].toUpper());
	}

	censor : StringPreParser {
		doParsing(str, which) {
			if (rexMatch(util.obscenities,str)!=null) {
				util.offenses+=1;
				if (util.offenses>8) {
					"Come back when you've classed it up a bit.";
					finishGameMsg('You have missed the point entirely.',null); }
				else if (util.offenses>7) "Be very careful.";
				else if (util.offenses>6) "Tenacious, huh?";
				else if (util.offenses>5) "I'll do something awful if you keep this up.";
				else if (util.offenses>4) "No, you're right, this is hilarious.";
				else if (util.offenses>3) "How was middle school for you?";
				else if (util.offenses>2) "Try me.";
				else if (util.offenses>1) "Knock it off.";
				else if (util.offenses>0) "Be careful.";
				return null;
			} return str;
		}
	}

	suppressOutput : OutputFilter { filterText(tgt,src) { return ' '; } }

	obscenities = '%bfuck|shit|ass|penis|pussy|shit|damn|vagina|tit|boob|felch|cunt|blumpkin|clit|cum|semen%b';
	offenses = 0;
}

modify statusLine {
	showStatusRight() {
		"<<user.name>> - <<versionInfo.name>> - ";
		inherited();
	}
}

enum male, female;
