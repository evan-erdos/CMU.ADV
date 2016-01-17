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
	'''];

+++ ByeTopic
	"""
	"Good luck with 251," you say. He nods sadly and picks his notebook back up.
	""";

//+ ConvNode '';