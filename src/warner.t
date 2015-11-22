/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-19 * warner */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

warner_entrance : OutdoorRoom 'Warner Hall (Outside)' 'Warner'
"You are standing on a north-south walkway outside Warner Hall. The recently bought marble exterior ($180,000) impresses you beyond words. Someone once told you that, back in the day, when tuition was increased and students complained, the president at the time told them it was worth it since Warner ended up all pimped out (not in those exact words). The students then thought it prudent to chuck cookies at Warner until the administration put up that steel grate in front to fend them off. You could do with a nice gooey cookie right now...\nThe cut is nearby, and you see a large black building to the west." {
    east = cut_north;
    south = cut_walkway_0;
    west = ucc_atrium;
    in = warner_hall;
}

warner_forbes : OutdoorRoom 'Warner Hall (near Forbes Ave.)' 'Warner'
"You are by Warner hall on Forbes Avenue.  You notice the gleaming new marble exterior on the building. A high wall separates you from the building itself. " {
    in : FakeConnector "A high wall stops you from getting to Warner." { }
}

warner_hall : Room 'Warner Hall' 'warner'
"This is Warner Hall, home of the enigmatic application process. The very air reeks of bureaucracy. You might want to exit, or, if you're feeling adventurous, you could wander upstairs... " {
	up = warner_second_floor;
	out = warner_entrance;
}

warner_second_floor : Room 'Warner Hall Second Floor' 'Warner 2'
"It's warm and cozy in here, and you can hear some murmuring emanating from a room to the west. Someone seems to be shuffling papers in an interviewer office to the east." {
	east = interview_room;
	west = interview_in_progress;
 	down = warner_hall;
 }

interview_room : Room 'Interview Room' 'Warner 2'
"The interviewer in the room jumps and drops some papers as you enter, then waves you in while surreptitiously sliding the fallen sheaf under his desk with his foot. \"You must be... uh...\" He trails off and scratches his head. Maybe you should leave."
{
	out = warner_second_floor;
}

interview_in_progress : FakeConnector
"Oh dear, you seem to have walked into someone's interview! The kindly, nonplussed interviewer asks if you're lost while the startled interviewee turns to you and instinctively blurts out
	<<one of>>\"My greatest strength is my team-leading ability, which I have demonstrated at length through my presidencies in my school's debate, cooking, MUN, anime, and waterskiing clubs!\"<<or>>
	\"I have lived in twenty-three different countries and am very well versed in Chinese, Spanish, Latin, Hakka, Japanese, Finnish, Proto-Indonesian, Whistled Turkish, Esperanto, Klingon, and Python, but only Python 2.7!\"<<or>>
	\"I love Carnegie Mellon because of the premier academic experiences, prestigious programs, and varied and esteemed extracurriculars that it offers!\"<<or>>
	\"I excel at all sports, and have recently won tennis, soccer, flag football, foosball, Calvinball, parkour, and hitball tournaments!\"<<or>>
	\"I have won many awards for my excellent academic ability, and have been recognized as a National Merit Scholar for my 2500 SAT score, have won a Sieman's Award for my cure for hypochondriacs, and maintain a 17.40 GPA!\"<<or>>
	\"(Help, I wandered on campus by accident and got into an interview! I'm actually a middle schooler!)\"<<or>>
	\"I spend my weekends helping out at soup kitchens as a ladle, at the local library as a bookend, at the hospital as a backup syringe, at the Town Hall as a red-tape provider, and at the homeless astronaut shelter as an astronaut!\"
	<<at random>>
	You murmur some placating words and back out of the doorway.";