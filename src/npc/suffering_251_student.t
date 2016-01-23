/* Jocelyn Huang * jocelynh@andrew.cmu.edu * 2016-01-16 * 251 student */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"
#pragma newline_spacing(preserve)

suffering_251_student : Person
'suffering student/251 student/student'
'<b>Suffering 251 Student</b>' @ghc_rashid
"""
A particularly mournful student sniffles at the very back of the auditorium. His notebook is stained with tears.
""" {
	isHim = true;
	globalParamName = "251 student";

	contactedTA = false;
}

+ student_Talking : InConversationState
	specialDesc =
		"""
		The student seems to have given up on taking notes, and is now looking back towards the entrance at you.
		""";

++ student_ready : ConversationReadyState {
	isInitState = true;
	commonDesc =
		'''
		scribbling madly in his notebook. Craning your neck a bit, you can see that he's computing his grade based off of various possible exam scores.
		''';
	specialDesc = 'The suffering student is <<commonDesc>>';
	stateDesc = 'He is <<commonDesc>>';
}

+++ HelloTopic, ShuffledEventList
	['''
	The quietly suffering student is either having a seizure or is just sobbing and shaking madly. You decide to check up on him, and ask, "Are you alright?"

	The student looks up at you blearily, and hiccups a few times. His pencil drops from his hand.
	''']['''
	You decide to check up on him again.

	"Hey, you're still here," you comment. You really need to work on your reassuring skills.

	"I'm still here," comes the dejected reply.
	''',
	'''
	The suffering student seems to have started crying again, and you hand him a tissue, which he takes gratefully. You picked it up on a random table outside and was going to throw it away, but he doesn't need to know that.

	"Are you doing okay?" you ask.

	"No," he replies truthfully.
	'''];

+++ ByeTopic
	"""
	"Good luck with 251," you say. He nods sadly and picks his notebook back up.
	""";

//*************<Relevant to the TA>******************

++ AskTopic 'office hours'
	topicResponse()
	{
	""" // Indenting these seems to add an extra tab into the dialogue.
	Would you by any chance know how office hours work this semester?" you inquire.
	""";

		local obj = new OHSchedule;
		obj.moveInto(me); // Currently does not work; need to figure out how/why.
	}
;

+ oh_schedule : Readable, Thing
'schedule' 'office hours schedule'
"""
	It's a schedule of 15-251 office hours for this semester.
""" {
    initSpecialDesc = "The suffering student clutches a heavily marked 251 schedule in his hand.";
    readDesc {
        """
        It lists all of the 251 TAs' office hour times and locations. Looking closer, you can see that one of the TAs has office hours during lectures... Good planning, guys. Someone should probably show this to a 251 authority figure.
        """;
    }
}