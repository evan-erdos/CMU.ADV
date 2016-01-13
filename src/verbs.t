/* Ben Scott * bescott@andrew.cmu.edu * 2015-12-30 * verbs */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"
#pragma newline_spacing(preserve)


/* begin verb definitions */

DefineTAction(BarkAt);

DefineTAction(Kill);

DefineIAction(Hide) execAction() {
    "Hide from what? "; };

DefineTAction(HideIn);

#ifdef __DEBUG
//DefineTAction(Goto) execAction {
//    if (gPlayerChar==null || gPlayerChar.location==null) return;
//    gPlayerChar.travelTo(the_cut);
//};

DefineTAction(Purloin);
DefineIAction(FiatLux) execAction {
    if (gPlayerChar.brightness==0) {
        "You're pretty bright. ";
        gPlayerChar.brightness = 3;
    } else {
        "You feel dimmer. ";
        gPlayerChar.brightness = 0;
    }
};
#endif

/* end verb definitions */



/* begin verb rules */

VerbRule(Bark) 'scream' | 'bark' | 'growl'
    : YellAction verbPhrase =
        'yell/yelling/bark/barking';

VerbRule(BarkAt) ('bark' | 'yell' | 'growl') 'at' singleDobj
    : BarkAtAction verbPhrase =
        'bark/barking/yell/yelling/growl/growling (at whom)';

VerbRule(Help) 'help' | ('help' | 'assist') 'me'
    : HintAction verbPhrase =
        'help/helping/assist/assisting';

VerbRule(Hide) 'hide' ('on'|'in'|'under'|'behind') singleDobj
    : HideInAction verbPhrase =
        'hide in (what)';

VerbRule(Kill) 'kill' | 'murder' | 'attack'
    : KillAction verbPhrase = '
        kill/killing/kill (whom)';


#ifdef __DEBUG

//VerbRule(Goto) 'goto' //singleDobj
//    : GotoAction verbPhrase = 'goto (place)';

VerbRule(FiatLux) 'fiat' 'lux'
    : FiatLuxAction verbPhrase =
        'make/making light';

VerbRule(Purloin) 'purloin' singleDobj
    : PurloinAction verbPhrase =
        'purloin/perloining (what)';
#endif

/* end verb rules */



