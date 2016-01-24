/* Jocelyn Huang * jocelynh@andrew.cmu.edu * 2015-11-24 * 251 TA */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"
#pragma newline_spacing(preserve)

sad_251_ta : Person
'sad ta/teaching assistant/staff'
'<b>Sad TA</b>' @ghc_citadel_commons
"""
A dejected-looking TA wearing her 15-251 sweatshirt sits mournfully at the edge of an overcrowded table. Everyone seems to be ignoring her.
""" {
    isHer = true;
    globalParamName = 'sad 251 TA';
}

+ ta_Talking : InConversationState
	specialDesc =
		"""
		She is looking around the Citadel Commons, and occasionally glances at you.
		""";

++ ta_ready : ConversationReadyState {
	isInitState = true;
	commonDesc =
		'''
		staring at her laptop and sighing. You can see that she's just looking at her students' grades and nothing else.
		''';
	specialDesc = 'The dejected 251-TA is <<commonDesc>>';
	stateDesc = 'She is <<commonDesc>>';
}

/******************<Talk Topics>*********************/

+++ HelloTopic, ShuffledEventList
	['''
	As a model concerned citizen, you decide to approach the TA.

	"Are you alright?" you ask. The TA turns towards you and lets out another long sigh.

	"My students don't seem to care about my course."

	This sounds intriguing. You've never heard of anyone not caring about 251 before; perhaps you could inquire further.
	''']['''
	She looks up hopefully, then sighs when she sees it's just you again, and not one of her students.
	'''];

+++ ByeTopic
	"""
	You decide not to bother her further, and back away. She immediately goes back to staring at her students' grades.
	""";

++ AskTopic, ShuffledEventList 'students'
	['''
	You inch closer. "What do you mean, your students don't care about your course?"
	She gestures towards a yellow Office Hours sign half-buried under papers from other people at the table.

	"No one ever shows up to my office hours, and everyone seems to be struggling. Look at these grades!" she exclaims in disgust.

	After some halfhearted protest about seeing students' grades, you lean in for a brief glance.

	Indeed, they're pretty bad, but on the whole they seem par for the course. You tell her so, to which she responds "Hmph! There's no proof of that. And they don't even show up to Office Hours for help."
	''']['''
	"What did you say about your students not liking you or something?"

	She looks horrified--"Wait, they don't come to office hours because they don't like me?!" Her eyes well up with tears.

	Oops. Now look what you've done.

	"No, no! I didn't say that, I'm sure you're a wonderful person and they all like you just fine..." You wave your arms placatingly, and accidentally clip a freshman on the ear.

	The TA's sniffling subsides gradually.
	'''];

+ GiveTopic [oh_schedule]
	topicResponse()
	{
	"""
	placeholder
	""";
	oh_schedule.moveInto(getActor);
};

