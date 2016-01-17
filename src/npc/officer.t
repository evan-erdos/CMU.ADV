/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-20 * officer */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"
#pragma newline_spacing(preserve)


cmu_officer : Readable, Person
'(ugly) police/officer/cop/polezzi/pig'
'Campus Officer' @the_cut
"""
This cop is mean and ugly; he's the Clint Eastwood of the academic world. You'd better not mess with him.
""" {
    isProperNoun = true;
    isHim = true;
    readDesc =
        """
        The cop has <b>mean<\b> written all over him.
        """;

    harass(actor) { Events.init_limbo(); }

    uselessToAttackMsg =
        """
        Trying anything funny with this fellow seems like a terrible idea. You might have woken up on the ground in the middle of campus, but you're not <b>that</b> foolhardy.
        """;
}

+ officer_init : ActorState "He means business. " {

    specialDesc =
        """
        A campus police officer is here, eyeing you suspiciously.
        """;
    noResponse =
        """
        You try to reason with him. He's having no part of it.
        """;
    isInitState = true;
}

++ officer_agenda : AgendaItem {
    initiallyActive = true;
    isReady = (user.isIn(the_cut));
    invokeItem = officer_agenda_list.doScript();
}

++ officer_passive : AgendaItem {
    isReady = true;
    invokeItem = [{:
        officer_agenda.resetItem(),
        isDone = true }];
}

+++ officer_agenda_list : ShuffledEventList
['''
The campus cop squints at you from behind his mirror shades and rasps, "You'll have to move along, <<user.engender('son','little missy')>>."
''','''
The cop taps his foot impatiently.
''','''
He says, "Five more minutes of this, I'm gonna get mad!"
''','''
"Not <b>my</b> fault this is happening..."
''','''
The cop gives you a weird look. You're not sure what to make of it.
''','''
The officer grumbles, and looks like he's about to make his move.
''','''
He's going to do something any moment now. "One more chance, come on!"
''','''
The cop is all worked up now. "Last chance to get outta here!"
'''][
{: print('''
    <<user.engender(
    '''
    The cop hauls you up by the collar.
    "Okay, wise guy, beat it!"
    ''','''
    The cop says "Sorry to have to do this, ma'am." and then carries you off.
    ''')>>'''),
    cmu_officer.harass(user),
    officer_agenda.resetItem(),
    isDone = true }];
