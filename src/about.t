/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-19 * About */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"
#pragma newline_spacing(preserve)


versionInfo : GameID {
    name = 'CMU.ADV';
    tagline = 'an adventure...';
    byline = 'by Ben Scott';
    original_byline = 'by Galloway & Kuehner & Pawlinger';
    authorEmail = 'bescott@andrew.cmu.edu';
    genre = 'Adventure';
    version = 'v2.0.3';
    firstPublished = '1986 (2016)';
    IFID = 'TADS3CMU-ADV3-77C6-042E-278CEDED4BDC';

    scoreRankTable = [
        [0,  'a dumb freshman'],
        [10, 'a basic sophomore'],
        [15, 'a dumb corgi (where\'s my script?)'],
        [20, 'such a good boy, yes you *ARE*!'],
        [32, 'a silly senior'],
        [63, 'a bachelor of something or, uh, sure why not I... I don\'t know.'],
        [82, 'a PH.D: You\'z got a fancy title now, dockta.'],
        [99, 'a coked-out professor']];


    intro() {
        """
        <p>That was some party last night... you must have had about twenty beers. Or was it thirty?  As you try to recall, the night becomes a giant blur, swimming around and around in your head. It spins faster, and you feel dizzy. Don't worry, though, you're lying down.
        </p><p>
        On the ground...</p>
        """;
    } /* intro */


    title() {
        about();
        """
        <p>(Type <<aHref('about', 'ABOUT')>> for basic information about this game, or <<aHref('restore', 'RESTORE')>> to restore a saved position. To <<aHref('', 'begin the game')>>, just press the Enter key, and type <<aHref('help','HELP')>> once you start if you get stuck.) </p>
        """;
    } /* title */


    about() {
        """
        <p><b><u>
        ; <<versionInfo.name.toUpper()>></u></b>
        ; <<versionInfo.tagline>>
        ;
        ; &lt;<<versionInfo.original_byline>>&gt;
        </p><p>
        <center>
        <<versionInfo.byline>>, <<versionInfo.authorEmail>>
        Release <<versionInfo.version>>, <<versionInfo.firstPublished>></p>
        </center>
        """;
    } /* about */
} /* versionInfo */


