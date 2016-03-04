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

++ AskTopic '251'
	"""
	You wonder how the class has changed since you've taken it. By the alternating horrified and completely lost looks on the faces of the students attending lecture, it doesn't really seem to have. (And, of course, there's that one kid in the front answering every question and raising his hand at every other sentence out of the professor's mouth.)

	After observing the class for a moment, you turn back to the <b>suffering student</b>. "So... how's 15-251 treating you guys this semester?"

	The <b>suffering student</b> grimaces and hands you his notebook. A syllabus carefully taped onto the first page lists all the familiar topics: Turing Machines, RSA, Markov Chains, and computational intractability, among other things.

	Flipping through the notebook, you see grade and curve computations scribbled in the margins of proofs, along with hastily scratched out and rewritten NP reductions.

	You nod sympathetically and hand the notes back.
	""";

//*************<Relevant to the TA>******************

++ AskTopic, ShuffledEventList 'schedule'
	['''
	"Would you by any chance know how office hours work this semester?" you inquire.

	"Yeah," he replies, "I have a schedule. The TAs choose a time slot and they're all marked down on here." He looks down at his OH schedule and shrugs. "I've looked at this thing so much that I've memorized it already. I don't really need the paper copy anymore..."

	Hmm. Maybe he'll give it to you if you ask nicely.<.convnode schedule>
	''']['''
	"Did you want the schedule?"<.convnode schedule>
	'''];

+ ConvNode 'schedule';

++ AskForTopic 'schedule'
	topicResponse()
	{
	"""
	It can't hurt to ask for the schedule if he's said he doesn't need it, right?

	You point to the slightly crumpled office hours schedule. "Hey, would you mind if I took that?"

	The suffering student shrugs and hands you the schedule. "Sure, go ahead."<.convnode postschedule>
	""";
	oh_schedule.moveInto(gPlayerChar);
	};

+ oh_schedule : Readable, Thing
'schedule' 'office hours schedule'
"""
	It's a schedule of 15-251 office hours for this semester. You could probably read it if you squinted.
""" {
    initSpecialDesc = "The suffering student clutches a heavily marked 251 schedule in his hand.";
    readDesc {
        """
        It lists all of the 251 TAs' office hour times and locations.

        The <b>suffering student</b> seems to have annotated everything, with a scale from one to 10 of how helpful each TA is, and on what topics, and on queue lengths.

        Looking closer, you can see that he's marked one of the TAs has office hours as during lecture... Good planning, guys. Someone should probably show this to a 251 authority figure.
        """;
    }
}

//***************<Post Schedule>******************

+ ConvNode 'postschedule';

++ SpecialTopic 'scare him' 'scare him'
	"""
	You are a horrible person and want to scare the wits out of this already-frazzled student.

	"<b>Boo!</b>" you holler in his ear.

	The <b>suffering student</b> lets out a yelp and topples out of his seat, then bursts into tears on the ground.

	You notice that the class has gone silent and the professor is staring at you. A few uncomfortable seconds pass, and he continues lecturing. The student takes a bit longer to recover, then clambers back into his seat, picking up his fallen materials dejectedly.
	""";

++ SpecialTopic 'comfort him' 'comfort him'
	"""
	Are you kidding? There's no comforting an underclassman faced with 251.
	""";