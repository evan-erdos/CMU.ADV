/* Jocelyn Huang * jocelynh@andrew.cmu.edu * 2015-11-24 * interviewer */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

// Eventually she'll want those student tears.
sad_251_ta : Person 'ta/teaching assistant/sad ta' '<b>Sad TA</b>' @ghc_citadel_commons
"A dejected-looking TA wearing her 15-251 sweatshirt sits mournfully at an overcrowded table. Everyone seems to be ignoring her."
    isHer = true
    globalParamName = "sad 251 TA"
;

+ taTalking : InConversationState
	specialDesc = "She is looking around the Citadel Commons, and occasionally glances at you."
;

++ ta_ready : ConversationReadyState
	isInitState = true
	commonDesc = 'staring at her laptop and sighing. You can see that she\'s just looking at her students\' grades and nothing else.'
	specialDesc = 'The dejected 251-TA is <<commonDesc>>'
	stateDesc = 'She is <<commonDesc>>'
;

+++ HelloTopic, ShuffledEventList
	['You decide to approach the TA.']

	['She looks up hopefully, then sighs when she sees it\'s just you again.']
;

+++ ByeTopic
	"You decide not to bother her further, and back away. She immediately goes back to staring at her students\' grades."
;

student_tears : Thing '(small) tears/vial' 'vial of student tears' @ghc_rashid
"A vial of 15-251 students' tears." {
    initSpecialDesc = "The faces of the students in the back row glisten with tears. You are not sure whether they are tears of joy at the beauty of cellular automata and Turing Machines, or tears of suffering at the all-nighters they no doubt had to pull to finish their homework."
    initDesc = "You could probably harvest the students' tears. They're starting to pool at the base of the seats."
}