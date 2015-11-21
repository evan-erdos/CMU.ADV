/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-19 * init */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

intro : InitObject {

    prolog() {
#ifndef TADS_INCLUDE_NET
        bannerClear(1);
#endif
"\b\nThat was some party last night... you must have had about twenty beers. Or was it thirty?  As you try to recall, the night becomes a giant blur, swimming around and around in your head. It spins faster, and you feel dizzy. Don't worry, though, you're lying down.\b\tOn the ground...\b\n";
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
}