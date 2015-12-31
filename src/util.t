/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-21 * util */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

/* begin modifications */

// Passage template -> masterObject 'vocabWords' 'name' @location? "desc"?
// Door template 'name' @room1 @room2;

// Room template [room_list] "desc"?;
// alternate format, includes up / down, etc.
// [northwest, north, northeast] // [[NW,  U,  N,  NE],
// [west,    'roomName',   east] //  [W,  IN, OUT, E ],
// [southwest, south, southeast] //  [SW, D,   S,  SE]]

modify Goal goalState = OpenGoal;


modify YellAction {
    execAction() { mainReport('You bark as loud as you can. '); }
}


modify Thing {
    dobjFor(BarkAt) {
        verify() {
            illogical('{The dobj/he} {is} not something you can bark at. '); }
    }
}


modify Actor {
    makeProper() {
        if (isProperName==null && properName!=null) {
            name = properName;
            isProperName = true;
            initializeVocabWith(properName);
        } return name;
    }
}


modify statusLine {
    showStatusRight() {
        "<<user.name>> - <<versionInfo.name>> - ";
        inherited();
    }
}


enum male, female;


class Ambiance : RandomFiringScript, ShuffledEventList {
    eventPercent = 50;
}


Ambiance template [eventList];

/* end modifications */



/* begin events */
Events : object {

    sleep() { }

    init() {
        cmu_officer.addToAgenda(officer_agenda);
    }

    propertyset '*Typewriter' {
        count = 1;
        input = '';
        daemon = null;

        init(s, delay) {
            if (daemonTypewriter==null) {
                inputTypewriter = s;
                print('adsfasdfasdf');
                daemonTypewriter = new RealTimeDaemon(
                    self,&advanceTypewriter,delay);
            }
        }

        advance() {
            if (countTypewriter<=inputTypewriter.length()) {
                cls();
                print(inputTypewriter.substr(1,countTypewriter));
                countTypewriter++;
            } else if (daemonTypewriter!=null) {
                daemonTypewriter.removeEvent;
                daemonTypewriter = null;
            }
        }
    }

    propertyset '*_limbo' {
        daemon = null;
        init() {
            user.travelTo(limbo, into_limbo, into_limbo.connectorBack(
                user.getTraveler(into_limbo), limbo));
            if (daemon_limbo==null)
                daemon_limbo = new Daemon(self,&play_limbo,2);
        }

        play() { list_limbo.doScript(); }

        stop() {
            if (daemon_limbo!=null) {
                daemon_limbo.removeEvent;
                daemon_limbo = null;
            }
        }
    }

    list_limbo : RandomFiringScript, ShuffledEventList {
        firstEvents = ['You begin to run, as fast as you can, in some direction. You get nowhere. '];
        eventList = ['The fog glowers at your plight. ',
            'You think you noticed it get slightly brighter for a moment. ',
            'The fog glowers at your plight. ',
            {: print('<b>lo! but you are saved!</b>'),
                user.reset(), Events.stop_limbo() }]
        eventPercent = 80;
    }
}

//combinedSpecialDesc : ListGroupSorted {
//  compareGroupItems(a,b) { return (a.listOrder-b.listOrder);} }

    /** `valToList()` : **`<T>[]`**
     *
     * convert anything to a list. If it's already a list,
     * simply return it. If it's `null`, return an empty list.
     * If it's a singleton value, return a one-element list
     * containing it.
     **/
    valToList(val) {
        switch (dataType(val)) {
            case TypeNil : return [];
            case TypeList : return val;
            case TypeObject :
                if (val.ofKind(Vector))
                    return val.toList;
                else return [val];
            default: return [val];
        }
    }




util : object {

    capitalize(s) {
        if (s.length()<1) return s.toUpper();
        return s[0].toUpper()+s.substr(1);
    }

    censor : StringPreParser {
        doParsing(s, which) {
            if (rexMatch(util.obscenities.toLower(),s)!=null) {
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
            } return s;
        }
    }

    suppressOutput : OutputFilter {
        filterText(tgt,src) { return ' '; } }

    obscenities = '%b([^a-eg-z0-9][^a-tv-z0-9][^abd-z0-9][^a-jl-z0-9])|([^a-rt-z0-9][^a-gi-z0-9][^a-hj-z0-9][^a-su-z0-9])%b'; // straightforward? no, but it keeps the repo classy.
    offenses = 0;
}


