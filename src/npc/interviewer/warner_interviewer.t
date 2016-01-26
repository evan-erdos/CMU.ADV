/* Jocelyn Huang * jocelynh@andrew.cmu.edu * 2015-11-24 * interviewer */
/* Ford Seidel * fseidel@andrew.cmu.edu * 2015-11-25 * CIT text */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"
#pragma newline_spacing(preserve)

warner_interviewer : Person
'(harried) staff/interviewer/employee'
'Harried Interviewer' @interview_room
"""
He's not a very old man, but you can see signs of a cover-up in his hair and grooming. This job has aged him slightly, but he's still supposed to look young and vibrant to attract students.
""" {
    isHim = true;
    globalParamName = 'interviewer';
    interest = 0; // interest in "prospective" student

    initSpecialDesc { isInInitState = null;
        """
        You enter the room, and then notice a harried admissions interviewer doing all manner of office work, faxing and stapling so loudly that he didn't notice you enter.
        <br>
        You stand quietly in the doorway, he hasn't noticed you yet.
        """;
    }

    giveImpression(n) { interest += n; }

    decideAdmittance(n) {
        if (n>50) achievement_blackmail.awardPointsOnce();
        else if (n>4) achievement_admitted.awardPointsOnce();
        else if (n<-50) achievement_failed.awardPointsOnce();
        else achievement_denied.awardPointsOnce();
        interest = 0;
    }

    /* To be awarded at the completion of the interview */
    achievement_admitted : Achievement {
        +3 "taking an admissions interview as a student... oops." }

    achievement_denied : Achievement {
        +(-3) "failing an admissions interview as a student." }

    achievement_blackmail : Achievement {
        +20 "blackmailing an admissions interviewer into admitting you, even though you're already a student." }

    achievement_failed : Achievement {
        +(-20) "trying to blackmail an admissions interviewer, and failing!" }
}


warner_interviewer_list : ShuffledEventList, RandomFiringScript
['''
The interviewer bumbles around his office, slipping a few times on the papers under his desk, and scratches his head a bit.
''','''
The interviewer now appears to have found what his previous head-scratching efforts didn't yield.
''','''
The interviewer begins stapling a big stack of papers.
''','''
You squirm a bit as you watch the interviewer narrowly avoid stapling his thumb to some poor student's application.
''']
['The interviewer continues stapling.']
eventPercent = 80;
