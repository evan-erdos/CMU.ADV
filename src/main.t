/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-19 * main */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"


/** `gameMain` : **`GameMainDef`**
 *
 * This is a special class which TADS3 relies on to start the
 * game. It deals with all manner of startup and title-related
 * functions, and sets up some global variables to be used by
 * the TADS3 framework. Such variables include:
 *
 * - `initialPlayerChar` : **`Actor`**
 *     Whose body to start out the game in. This can be rebound
 *     to another instance of `Actor`, which means you can jump
 *     between different people during the game.
 *
 * - `scoreRankTable` : **`<int,string>[]`**
 *     Numbers mapped to strings, which are the "ranks" that
 *     a player can achieve, e.g., what they are considered at
 *     a given value `n` would be the string at `n`, rounded
 *     down to the nearest value. Points are typically awarded
 *     by the `Achievement` class.
 *
 * - `maxScore` : **`int`**
 *     optional maximum, if undefined, the limit is calculated
 *     to be the sum of the points from all `Achievement`s.
 **/
gameMain : GameMainDef {
    initialPlayerChar = user;
    scoreRankTable = versionInfo.scoreRankTable;
    maxScore = null;

    newGame() {
        startup.init();
        begin(); cls();
        user.init();
        Events.init();
        runGame(true);
    } /* newGame */

    begin() {
        versionInfo.title();
        for (;;) {
            local cmd;
            local kw;
            local rqArg = null;
            cmd = inputManager.getInputLine(null, {:"\b&gt;" });
            if (rexMatch('<space>*$', cmd)!=null) return 1;
            if (rexMatch('<space>*(<alpha>+)<space>*$',cmd)!=null)
                kw = rexGroup(1)[3].toLower();
            else if (rexMatch('<space>*(rq|replay)'+'<space>+([\'"])(((?!%2).)+)%2?<space>*$',cmd)!=null) {
                kw = rexGroup(1)[3]; /* get the keyword */
                rqArg = rexGroup(3)[3]; /* get the argument */
            } else kw = ' ';
            if ('about'.startsWith(kw)) versionInfo.showAbout();
            else if ('restore'.startsWith(kw) && (RestoreAction.askAndRestore())) return 2;
            else if ('quit'.startsWith(kw)) return 3; /* deal with it */
            else if (kw=='rq' || 'replay'.startsWith(kw)) {
                if (rqArg==null) {
                    local result = inputManager.getInputFile('Enter command file', InFileOpen, FileTypeCmd, 0);
                    if (result[1]==InFileSuccess) rqArg = result[2];
                } if (rqArg!=null) { /* read from the file */
                    setScriptFile(rqArg, kw=='rq'?ScriptFileQuiet:0);
                    return 1; /* start the game */
                }
            } else return 1;
        }
    } /* begin */
} /* gameMain */


/** `startup` : **`InitObject`**
 *
 * Called by `gameMain` to deal with the opening sequence.
 **/
startup : InitObject {

    init() {
#ifndef TADS_INCLUDE_NET
        bannerClear(1);
#endif
        versionInfo.intro();
        clear;
#ifndef TADS_INCLUDE_NET
        local spacer = bannerCreate(
            null, BannerFirst,
            statuslineBanner.handle_,
            BannerTypeTextGrid,
            BannerAlignTop,10,
            BannerSizePercent,
            BannerStyleBorder);
        local title = bannerCreate(
            null, BannerLast,
            statuslineBanner.handle_,
            BannerTypeTextGrid,
            BannerAlignTop, 16,
            BannerSizePercent,
            BannerStyleBorder);
        bannerSetTextColor(
            title,ColorBlue,ColorTransparent);
        bannerSetScreenColor(title,ColorStatusBg);
        bannerSay(title,
        '\b          <<versionInfo.name>>       \b');
        clear;
        bannerDelete(spacer);
        bannerDelete(title);
#else
        versionInfo.showAbout();
        clear;
#endif
    }
}


#ifdef __DEBUG

DefineIAction(FiatLux)
    execAction {
        if (gPlayerChar.brightness==0) {
            "You\'re pretty bright. ";
            gPlayerChar.brightness = 3;
        } else {
            "You feel dimmer. ";
            gPlayerChar.brightness = 0;
        }
    }
;


VerbRule(FiatLux) 'fiat' 'lux' : FiatLuxAction {
    verbPhrase = 'make/making light'
}
;
#endif


