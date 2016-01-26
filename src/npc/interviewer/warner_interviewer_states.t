/* Ben Scott * fseidel@andrew.cmu.edu * 2016-01-09 * Interviewer States */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"
#pragma newline_spacing(preserve)


interviewerAngry : ActorState @warner_interviewer {
    specialDesc =
        """
        The interviewer glares at you. He doesn't seem to like you anymore.
        """;
}

+ DefaultAnyTopic
"""
The interviewer recognizes you.

"You again? I thought I told you to beat it!" he says, angrily.
"Also, get out of my office, can't you see I'm... doing things?"
<br>
You oblige him and wander into the hallway.
<<gPlayerChar.scriptedTravelTo(warner_second_floor)>>
""";


interviewerAfraid : ActorState @warner_interviewer
"""
He also now appears to be twitching a bit.
""" {
    specialDesc =
        """
        You've frightened the living daylights out of this poor man, but he's still trying to go about his work.
        <<warner_interviewer_list.doScript()>>.
        """;
}

+ DefaultAnyTopic
"""
The interviewer gets very nervous.

<<interviewer_afraid_list.doScript()>>
<br>
You should probably let him get back to work.
""";

interviewer_afraid_list : ShuffledEventList
['''
"Wh... Sure, yeah, uh huh!" he stutters out.
"Would you like... well, I don't really... Anything?"
''']['''
"Hi, yes... uh, you're still...? Listen, I'll do whatever you want, ok?" he stammers.
''','''
You try to speak to him, but he just whimpers, and turns his back a little. It's a pitiful sight. You really scared this guy.
'''];





