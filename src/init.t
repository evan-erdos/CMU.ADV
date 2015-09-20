/* Ben Scott - bescott@andrew.cmu.edu - 2015-09-19 - CMU.ADV - init */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

intro : InitObject {
	prolog() {
#ifndef TADS_INCLUDE_NET
		bannerClear(1);
#endif
"\b\nThat was some party last night... you must have had about twenty beers. Or was it thirty?  As you try to recall, the night becomes a giant blur, swimming around and around in your head. It spins faster, and you feel dizzy. Don't worry, though, you're lying down.

On the ground...\b\n";
		clear;
#ifndef TADS_INCLUDE_NET
		local spacer = bannerCreate(null, BannerFirst, statuslineBanner.handle_, BannerTypeTextGrid, BannerAlignTop, 10, BannerSizePercent, BannerStyleBorder);
		local title = bannerCreate(null, BannerLast, statuslineBanner.handle_, BannerTypeTextGrid, BannerAlignTop, 16, BannerSizePercent, BannerStyleBorder);
		bannerSetTextColor(title, ColorBlue, ColorTransparent);
		bannerSetScreenColor(title, ColorStatusBg);
		bannerSay(title, '\b          <<versionInfo.name>>       \b');
		clear;
		bannerDelete(spacer);
		bannerDelete(title);  // """ can be used like in lisp for this
#else
		versionInfo.showAbout();
		clear;
#endif
	}

	awake() {
#ifndef SUDO
		"\b\nYou shudder awake. You get up off the floor and instinctively move towards the bathroom. If you were a bit more careful (rather, if the room was spinning even a <b>little</b> bit slower), you might\'ve dodged the doorframe on your way to assess the damage you've done to yourself in the last few days. You won\'t remember why your temple hurts. You begin to get up, but the visceral stack of mistakes you\'re popping off keep you down. You stagger to your feet, swaying a bit as you try to lock eyes with yourself in the mirror. Your eyes haven't focused yet, and you consider that you might not want to see yourself like this until you\'re overabundantly cleaner.";
		next;
		"\b\nYou\'re already on the verge of impending mental collapse; you don't need to feel <b>worse</b>. You try to avoid the mirror (as one would avoid the gaze of a <b>basilisk</b>) but it\'s unavoidable. It\'s less sobering than it is <b>alarming</b>. You turn to start the bath, and then look back at the mirror. You're emaciated, haggard... that taste in your mouth...";
		next;
		"\b\nYou make an earnest attempt to clean up. There\'s a lot of water and scraping, and it doesn\'t go well. You consider the surfeit of ways that more involved measures to clean yourself could go (razors, nail clippers, et al), and without a second thought you walk out of the room to your dresser. Nicer clothes will at least allow you to masquerade as a well-put-together human being.";
		clear;
#endif
	}
}


