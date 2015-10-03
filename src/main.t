/* Ben Scott - bescott@andrew.cmu.edu - 2015-09-19 - CMU.ADV - main */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

gameMain : GameMainDef { // impugn
    initialPlayerChar = user;
    scoreRankTable = [
        [0,  'a dumb freshman'],
        [10, 'a basic sophomore'],
        [15, 'a dumb corgi (this is a holdover from a different game, don\'t mind this, just get some more points, you\'ll stop being a dog)'],
        [20, 'such a good boy, yes you *ARE*! (yeah, no, just one more)'],
        [32, 'a silly senior'],
        [63, 'a bachelor of something or, uh, sure why not I... I don\'t know.'],
        [82, 'a PH.D, you\'z got that fancy title now, dockta. '],
        [99, 'a coked-out professor']];
    maxScore = null;

    newGame() {
        intro.prolog();
        clear;
        startup(); cls();
        user.init();
        Events.init();
        runGame(true);
    } /* newGame */

    startup() {
        versionInfo.titleScreen();
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
    } /* startup */
} /* gameMain */

#ifdef SUDO

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


