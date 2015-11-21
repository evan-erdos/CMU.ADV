/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-19 * About */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

versionInfo : GameID {
    name = 'CMU.ADV';
    tagline = 'an adventure...\n;';
    byline = 'by Ben Scott';
    original_byline = 'by Galloway & Kuehner & Pawlinger';
    authorEmail = 'bescott@andrew.cmu.edu';
    genre = 'Adventure';
    version = 'v2.0.3';
    firstPublished = '1986 (2015)';
    IFID = 'TADS3CMU-ADV3-77C6-042E-278CEDED4BDC';

    titleScreen() {
        showAbout();
        "<p>(Type <<aHref('about', 'ABOUT')>> for basic information about this game, or <<aHref('restore', 'RESTORE')>> to restore
            a saved position. To <<aHref('', 'begin the game')>>, just
            press the Enter key, and type <<aHref('help','HELP')>> once you start if you get stuck.) </p>";
    } /* titleScreen */

    showAbout() {
        "\b<b><u>; <<versionInfo.name.toUpper()>></u></b>
        \n; <<versionInfo.tagline>>
        \n; <<'&lt;'+versionInfo.original_byline+'&gt;'>>
        \b<<versionInfo.byline>>, <<versionInfo.authorEmail>>
        \nRelease <<versionInfo.version>>, <<versionInfo.firstPublished>>";
    } /* showAbout */
} /* versionInfo */
