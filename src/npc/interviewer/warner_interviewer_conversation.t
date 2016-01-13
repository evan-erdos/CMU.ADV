/* Jocelyn Huang * jocelynh@andrew.cmu.edu * 2015-11-24 * interviewer */
/* Ford Seidel * fseidel@andrew.cmu.edu * 2015-11-25 * CIT text */
/* Ben Scott * fseidel@andrew.cmu.edu * 2016-01-09 * ConvNodes */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"
#pragma newline_spacing(preserve)


interviewerTalking : InConversationState @warner_interviewer {
    specialDesc =
	    """
	    He looks baffled at your presence but seems to be too confused about his own schedule to chase you out of the interview room.
	    <br>
	    He's offered you an interview, so what are you waiting for?
	    """;
}

+ interviewerReady : ConversationReadyState {
    isInitState = true;
    specialDesc { warner_interviewer_list.doScript(); }
}

++ HelloTopic
"""
"Hello!" you announce.
<br>
You startle him. He jumps and drops some papers as you approach his desk, then waves you in while surreptitiously sliding the fallen sheaf under his desk with his foot.
<br>
"You must be..." He begins, but then trails off and scratches his head.
<br>
"uh... you're... already? For the interview?"

<<warner_interviewer.setKnowsAbout(gPlayerChar)>>
<.convnode interview>
""";

+ DefaultAskTopic, ShuffledEventList
['''
He doesn't seem to be certain about anything, but gives you a puzzled but reassuring nod.
''','''
He doesn't seem to know what you're talking about, but in an effort to look professional he puts a finger to his chin and then doodles on his notepad.
'''];

+ DefaultTellTopic, ShuffledEventList
['''
He listens carefully and says, "Hmmm, yes."
You're pretty sure he has no idea what you're talking about.
'''];

+ ByeTopic
"""
"Thanks for the interview!" you say.

"Best of luck to you in your collegea process, I'm sure you'll be fine!" the interviewer replies, scribbling madly on a notepad. "Thanks for coming by and considering Carnegie Mellon."
""";

+ ImpByeTopic
"""
You up and leave, and the interviewer turns back to his desk, awkwardly avoiding eye contact.
""";


/*******************<Interview>*********************/

+ ConvNode 'interview';

++ YesTopic, SuggestedYesTopic
"""
"Yes, uh, *cough* yes, I'm... that's, I'm your... I'm that person, yes."
<br>
The interviewer gives you a momentary, skeptical look, and decides you are in fact the prospective student he's supposed to be seeing now.
<br>
"I'm here for my interview!" you announce.

"...very good," he replies, confused, but relieved that you seem to know what you're doing.

"Why don't you tell me something about yourself?"

<.convnode personality>
""";

++ NoTopic, SuggestedNoTopic
"""
"Oh, no, I'm already a student! I'm just looking around!" you say.
<br>
"...so, why are you... here?" the interviewer angrily intones.
<br>
"You know, sir, that's a great point, so I'll just be on my way now, sorry to bother!" You shrink back out of the room.
<<warner_interviewer.setCurState(interviewerAngry)>>
<<gPlayerChar.scriptedTravelTo(warner_second_floor)>>
""";


/*****************<Personality>*********************/

+ ConvNode 'personality'; /* begin personality */

++ TellTopic, SuggestedTellTopic 'me|(my|your)?self'
"""
You're already a student here, but you're starting to find this whole situation rather amusing.

"I'm a Pittsburgh native who has been interested in Carnegie Mellon for years! I practically live on campus already, I'm here so often." ...Well, technically, you're not lying. So far, so good. The interviewer still seems enthusiastic but expectant, so you think hard for something generic to say so that your cover doesn't get blown.

"I love Cobot!" You blurt out.

The interviewer's face lights up. "Oh, you know about <b>Cobot</b>?" He seems interested in hearing more.

<.convnode cobot>
""";


/********************<Cobot>************************/

+ ConvNode 'cobot';

++ DefaultAnyTopic
"""
You should probably tell him about Cobot.

<.convstay>
""";

++ TellTopic, SuggestedTellTopic 'cobot'
"""
Now you're in familiar territory! You've spent countless hours following Cobot around Gates and occasionally tormenting it by opening and closing the elevator doors before it could get on or off. You guys are tight. You just have to make sure you don't say too much and give yourself away.

"He's that robot that rolls around the Computer Science program, right? When I come for... events, I sometimes see him mapping the area and carrying papers on errands."

The interviewer nods, seemingly impressed by your knowledge of GHC happenings.

"I assume you're applying to our School of Computer Science, then?"

<<warner_interviewer.giveImpression(1)>>
<.convnode major>
""";


/********************<Major>************************/

+ ConvNode 'major';

++ DefaultAnyTopic
"""
What school do you want to tell him you're "applying" to?

<.convstay>
""";

/* I'm not biased, nope not at all --jocelynh */
++ YesTopic, SuggestedYesTopic
"""
Of course you are! CS is only the absolute coolest major there is. You enthusiastically tell him, "I love computer science! I've been in love with Graph Theory since I was a toddler and my mom told me to find the nearest shopping cart. After implementing a quick shortest path algorithm in my head (Dijkstra for efficient parallelization, of course), I was absolutely smitten."

The interviewer nods sagely, and jots something down on his notepad. Craning your neck slightly, you can see what he has written. You can make out one line:

> What is a 'dike-astra'? impressive "graph theory" knowledge.

"Great! As you know, admissions are very competitive, but students learn a lot through our vigorous program! Of course, I'll need to know if you've had any prior experience. Do you want to tell me about any of your extracurriculars?"

<<warner_interviewer.giveImpression(1)>>
<.convnode extracurriculars>
""";

++ NoTopic, SuggestedNoTopic
"""
"Oh, no, I'm just a fan of Cobot," you say. "I think he's cute! And he carries candy sometimes, so I like to hang around."

The interviewer seems mildly amused by your response. He flounders for a bit, then apparently realizes that he still hasn't found out what you're interested in. "What school are you applying to, then? Or... wait, did you say you were going for CS?" What a confused man.

<.convstay>
""";

++ SpecialTopic 'CIT'
'cit|engineering|ece|mech%s*e'
"""
You're in it for the engineering, of course! You love resistors, or bridges, or civil people or something. Or civil people on jammed bridges.
"I want to be an engineer. My father and his father before him were engineers, and since birth, I've known that engineering was my calling. Plus, I hear you guys have a great engineering program. Out of curiosity, why does it take four years to learn how to operate a machine that can only speed up and slow down along a track?"

The interviewer steeples his fingers and looks down his nose at you. "It's a fine art of balance and morality, especially when you're faced with either running one person over or two. Now, I need to know, do you have the background in extracurriculars to undertake this rigorous training?"

<.convnode extracurriculars>
""";

++ SpecialTopic 'Drama'
'(school%s+of)?%s+drama'
"""
Okay, taking a quick break from narrating to say, <b>what are you doing in the CClub text adventure</b>? But. Anyway.

"The gods have sent me yonder way, whenceforth I have taken upon me to apply to this divine school for its splendiferous Dramatization Program!"

You have no idea if half of the things you've said are even words, and for some reason you appear to be holding a skull in your hand as you kneel to the interviewer. He seems impressed with your yowling, though.

"Oh, what splendid acting! So you're a fan of the performing arts! What's your favorite play?"
Oh come on, the answer is obvious.

<.convnode drama>
""";

++ SpecialTopic 'Tepper'
'tepper|business|social(izing)?|suit(s|%s+wearing)?'
"""
Agh, how could he possibly think that you would willingly associate with those socially-blind androids?!

"Ohh, nooo," you quickly say, "I aspire to be an entrepreneur! I take my inspiration from the great Andrew Carnegie himself."

The interviewer nods sagely. "Ah, yes. Here to make... <i>connections</i>." He coughs, then moves on.

"Please, tell me about your socialization and the connections you've made through extracurriculars."

<.convnode extracurriculars>
""";

++ SpecialTopic 'Dietrich'
'dietrich|humanities|wasting%s+time(%s+and money)?'
"""
What do they even do in there? You don't really know, but decide to take a potshot and claim you're applying here anyway.

"Dietrich!" you announce in your most overenthusiastic voice. Hopefully, your faux-excitement will carry you through here.

"Oh, yes! I'm a graduate of Dietrich, myself."

<b>Oh, crap.</b>

"Oh... that's, uh. That's great! How did you like it?"

Thankfully, your question seems to have diverted the interviewer's interest in you, and he spends five minutes rambling about his college experience. You listen attentively and retain nothing of what he has said.

"Er, right. So... where were we?" He asks sheepishly, then glances a bit too obviously at a post-it note on his monitor labeled "Generic Interview Questions".
"Oh. Right. Extracurriculars. Yes. Do you have them?"

<.convnode extracurriculars>
""";

++ SpecialTopic 'MCS'
'mcs|mellon|(the%s+)?science(s)?|math(ematics)?'
"""
Beakers, flasks (containing alcohol, or otherwise), and equations are your thing. You live for biology/chemistry/physics/math/jesuschristhowmanymajorsareinthisonecollege.

"I am a pursuer of the truth! I live by the scientific method and aspire to discover the laws of universe. To discover the secrets residing in the natural world and in higher mathematics is my goal!"

The interviewer looks at you blankly, and slowly writes "MCS" in large block letters on his notepad. "Right. Do you know what major you would want to pursue?"

<.convnode mcsmajor>
""";

++ SpecialTopic 'CFA'
'(college%s+of%s+fine%s+)?art(s)?'
"""
"Warhooooool!" you yell madly as a sort of interview war-cry.
The interviewer lets out a small squeak and scrambles backwards. His chair tips over, dumping him unceremoniously on his side. As he clambers back up and rights his chair, you hear him mutter, "Oh joy, another crazy art person."

He grabs his notepad and licks the tip of his pencil. It's kind of gross. "I'm guessing that you spend a lot of time on art projects, but what else do you do outside of class?"

<.convnode extracurriculars>
""";


/********************<Drama>************************/

+ ConvNode 'drama';

++ DefaultAnyTopic
"""
The interviewer seems dissatisfied with your response. Did you mean <b><i>Pippin</i></b>?

<<warner_interviewer.giveImpression(-1)>>
<.convstay>
"""; //<<(warner_interviewer.interest--)>>

++ SpecialTopic 'say Pippin' ['Pippin']
"""
"<b>GREAT!</b>" he says, a little bit too excitedly. You lean away slightly from flying spittle. "Yes. Anyway."

He coughs. "Back on (Tartan)Tra(c)k. Given that you seem to have a solid acting background, I assume you participate in extracurricular activities?"

<<warner_interviewer.giveImpression(1)>>
<.convnode extracurriculars>
""";


/**********************<MCS>*************************/

+ ConvNode 'mcsmajor';

// I actually have no idea what to say here though --jocelynh
// apparently neither do I --ben
++ SpecialTopic 'Math'
'math(s|ematics)?'
"""
You ask the interviewer, "Did I see Paul Erdős wandering around outside Hunt? I thought he--"

The interviewer coughs loudly to interrupt you, and sits up in his seat, saying "-- NO. Uh, no. You didn't... that isn't... it's not..."
<br>
He slows down and says, "No. You... didn't."

Genuinely confused by his response, you begin to ask him about it. However, he now seems very eager to wrap things up.

<<warner_interviewer.setCurState(interviewerAfraid)>>
<.convnode decision>
""";

++ SpecialTopic 'Biology'
'bio(logy|logical%s+science(s)?)?'
"""
"The quickest way to my heart is through biology... and through my stomach and intestines!" You give a cheesy grin.

You're pretty sure Terry Pratchett said something like that in one of his many books. But in the context of assassins. What a legend.

The interviewer groans.
"Alright, then. What extracurriculars have you been involved in that also warm your heart or whatever?"

<<warner_interviewer.giveImpression(-1)>>
<.convnode extracurriculars>
""";

++ SpecialTopic 'Chemistry'
'chem(istry|ical%s+science(s)?)?'
"""
"I'm thinking about majoring in chemistry," you say. "I enjoy acids and bases and learning about bonds and things! As my chem teacher used to say, 'If you're not part of the problem, you're part of the precipitate.' Wait, you think you screwed that one up. Crap. The interviewer doesn't seem to notice, though.

"Ahh, yes. Looking to invent the next superglue or Kevlar, are we? Did you know that Kevlar was invented here?"

"Nah, I just like silly putty and I want there to be more of it in the world," you shrug.

The interviewer must not realize that you can see almost everything he's writing. You saw he just crossed out a line which read "The perfect student?".

"That's a... unique goal. We may have to work on those long-term goals, I guess. What are you interested in outside of class, then?"

<<warner_interviewer.giveImpression(-1)>>
<.convnode extracurriculars>
""";

++ SpecialTopic 'Physics'
'physic(s|al%s+science(s)?)'
"""
You have a deep love of spherical cows and frictionless surfaces. In a perfect world, you've always believed there would be no thermal energy loss or drag force.

"Physics!" you declare proudly, "My role models are Einstein and Feynman, though the admiration sadly doesn't go as far as bongo drums."

"May the Force be with you," the interviewer intones.

"...That's Star Wars," you point out, feeling a bit truculent. He looks a bit embarrassed; now look what you've done. "Er, may the Force be with you, too." He gives a little sigh of relief.

"So do you enjoy watching movies in your spare time? What do you like to do alone?"

<.convnode extracurriculars>
""";


/*****************<Extracurriculars>*****************/

+ ConvNode 'extracurriculars';

++ SpecialTopic, ShuffledEventList 'say none'
'no(ne|pe|thing)?'
['''
You think you'll have a little fun and break the model applicant mold. "Nope," you say cheerfully.

The interviewer looks shocked and scandalized, and his expression alternates between horror and surprise, then compromises by settling into dignified disgust.

You realize that this may have been a mistake. Better make something up real quick! "Haha, I'm just joking, I'm actually in..."

<<warner_interviewer.giveImpression(-1)>>
<.convstay>
''']['''
You probably shouldn't be pushing your luck further. Nice try, buster. Nearly got yourself kicked out, there.

<<warner_interviewer.giveImpression(-1)>>
<.convstay>
''','''
No, seriously, just make something up if you really don't have any experience in anything.

<<warner_interviewer.giveImpression(-1)>>
<.convstay>
''','''
Please?

<<warner_interviewer.giveImpression(-1)>>
<.convstay>
''','''
Seriously, just pick anything. Responses are gonna start looping soon.

<<warner_interviewer.giveImpression(-1)>>
<.convstay>
''','''
You have a life, trust me. Pick an extracurricular!
<<warner_interviewer.giveImpression(-1)>>
<.convstay>
'''];

++ SpecialTopic 'computer club'
'(program(ming)?%s+)?comput(er|ing)(%s+club)?'
"""
<b>(Heh, you suck-up.)</b>
"I'm in computer club," you declare proudly.

The interviewer goes wide-eyed, "That's amazing. You're with them?"

You nod, going along with it.

"They have... well, a lot of influence here. I'll be sure to write that down."
For the first time, the interviewer looks vaguely scared, or something. You can't quite place it.

"wh-<b>*cough*</b> excuse me! W-w-what else do you do... in your... spare time?"
The interviewer seems to shiver a bit.

<<warner_interviewer.giveImpression(4)>>
<.convnode sparetime>
""";

++ SpecialTopic 'drama'
'acting|drama|improv|theat([re]{2})'
"""
"I act, of course!"

The interviewer is given pause by this, but quickly hides his disappointment.

"That's... great! What else do you do, that... isn't acting?"

<<warner_interviewer.giveImpression(-3)>>
<.convnode sparetime>
""";

// The only correct answer is... --jocelynh
++ SpecialTopic 'stage crew'
'stage|light(ing)?|sound|tech|crew'
"""
"I'm not flamboyant enough to be an actor, so I do stage crew."

"Oh, my cousin used to do that. Said it's great."

You begin to nod, but the interviewer goes right on ahead.

"What else do you do, you know, for fun?"

<<warner_interviewer.giveImpression(1)>>
<.convnode sparetime>
"""
; // (I'm really biased.)

++ SpecialTopic 'bridge'
'(contract%s+)?bridge(%s+club)?'
"""
American Contract Bridge. Ah, the game of intellectuals.

"I am personally rather fond of Bridge, and not the one that you cross to get into Pittsburgh. 'Bridge, and not chess, is the ultimate war game,'" you quote. Michael Leeden.

"Ah, good, you enjoy strategy and thinking games!" He discreetly scribbles "Gets along with old people, plays cards" on his notepad.

"I think I have something for you, then..."

The interviewer flails his hands briefly across his desk before hastily yanking a battered-looking flier from under a desk lamp.

"Here it is. We don't have a Bridge club proper, but we do have a group that plays Bridge every Saturday morning in the UC!" Glancing at the flier, you see <b>9:30AM</b> printed in large font, and decide against waking up early to go. You like Bridge, but you also like sleep.

"Thanks for letting me know," you say, flapping the paper briefly and then placing it aside to be immediately lost in the clutter.

"Bridge is a pretty specialized group activity, though; so what do you do in your own free time?"

<<warner_interviewer.giveImpression(1)>>
<.convnode sparetime>
""";

// fseidel, do you want to take this one? --jocelynh
++ SpecialTopic 'robotics'
'FIRST|FRC|robotics(%s+club)?'
"""
"WOw LOOk roBOts!1!" you exclaim.

"Great, you're hired!" the interviewer jokes.
"You're probably a smartypants, that checks out, so tell me a little about what you do in your alone time."

<<warner_interviewer.giveImpression(1)>>
<.convnode sparetime>
""";

++ SpecialTopic 'anime club'
'anime|japanese|wee(a)?b(oo)?'
"""
"私はアニメが大好きです~~~!" you... exclaim?

The interviewer continues, "So I can see that you seem very multi-cultural, and we like diversity here! Tell me a little about what you do in your alone time."

<<warner_interviewer.giveImpression(1)>>
<.convnode sparetime>
""";

++ SpecialTopic 'sports'
'sports|excerci([zs])e|(foot|basket|base)ball|soccer|tennis|track|golf|badminton|lacrosse|rugby|(field%s+)?hockey'
"""
You pride yourself in sports, or at least you'll pretend to. Flexing your not-particularly-defined biceps, you declare, "I love sports! I love watching all the tournaments, from the Superbowl to the World Cup to the US Open. In fact, I'm so devoted to sports that I've practiced enough to become the captain of my school's... *mumble* ...team, carrying us to the championship for the past two years in a row."

"Ah, an athlete!" the interviewer enthuses, "We like good athletes and I think you would fit in well here please come I promise we actually do have football fields and soccer fields and golf and everything."

There seems to be a touch of desperation in his voice. He sees your surprise at his outburst and mistakes it for hesitation. Eager to further the conversation and usher you through the interview, he continues:

"You seem like a great fit for the school and I'd like to learn more about you! We have a lot of unique people and cultures here, and so I'd like to ask--what hobbies do you have outside of sports that you enjoy in your own time?"

<<warner_interviewer.giveImpression(2)>>
<.convnode sparetime>
""";

++ SpecialTopic 'use one of the sports you eavesdropped, like quidditch'
'quidditch|jai alai|(foos|calvin|hit)ball|hopscotch|parkour'
"""
You decide to take a leaf out of that random other interviewee's book and chuck up some random ridiculous sports. You manage to rattle off "Quidditch, Jai Alai, flag football, foosball, Calvinball, hopscotch, parkour, hitball..." and claiming that you've been team captain for about half of these before the interviewer cuts you off.

"You seem to have... <i>eclectic</i> tastes in physical activity," he comments. "That's good; we like to see a healthy interests in a variety of unique fields. I can also see that you have had ample leadership experience through your sports!"

You can't believe he actually bought it, but sure, you'll take it. <b>You daredevil</b>.

The interviewer continues, "So I can see that you seem very well-rounded in your activities, but tell me a little about what you do in your alone time."

<<warner_interviewer.giveImpression(4)>>
<.convnode sparetime>
""" isActive = (gRevealed('eavesdropped-sports'));


/***************<Spare Time Activities>***************/

+ ConvNode 'sparetime';

++ SpecialTopic 'say reading'
'read(ing)?|books|lit(erature)?'
"""
You like your literature, and don't hesitate to let the world know.

"I <b>love</b> reading!" you trumpet, startling the interviewer. "From Terry Pratchett to Malcolm Gladwell, Daniel Tammet to Douglas Adams, I love them all. I have a Kindle for travel, a library-in-progress at home, and I know my library card number backwards and forwards!"

The interviewer looks pleased at your intellectual and literary curiosity. He waves at you a copy of Randy Pausch's <b>The Last Lecture</b>. "Have you read this?"

"Of course I have! I love his commentary on the frailty of human life and on optimism in the face of mortality." What a great man.

"He was a professor here, you know," the interviewer says, almost proudly.

"Well, enough of that. You seem like a bright kid and a good fit. But I'd like to know specifically, what interests you about CMU?"

<<warner_interviewer.giveImpression(1)>>
<.convnode interest>
""";


++ SpecialTopic 'play video games'
'(play%s+)?(video%s+)?gam(es|ing)'
"""
"I sometimes play video gam-"
"You're a stupid, slacking, no-good teenager!" the interviewer yells, very suddenly. He sits back in his seat with a cross-eyed look for a few seconds, and his head tilts to the side. Then, he continues on like nothing happened.

"You seem like a bright kid. I'd like to know why you chose CMU, and what your interests in it are!"

Huh. That... hmm.
You're not sure what to make of that.

<<warner_interviewer.giveImpression(-1)>>
<.convnode interest>
""";


++ SpecialTopic 'watch TV'
'(watch%s+)?(([Tt][Vv])|([nN])etflix|shows|movies)'
"""
You decide to intentionally screw with the interviewer.

"I do very little, outside of watching television."

It backfires.

"Oh wonderful! It's so good to have a hobby. So, why do you want to come to CMU?" He keeps the same enormous grin for an uncomfortable period of time afterwards.

What?

<<warner_interviewer.giveImpression(1)>>
<.convnode interest>
""";


++ SpecialTopic 'solitaire'
'(play%s+)?solitaire|cards'
"""
You really can't think of anything that might be done alone, and in the heat of the moment, you say "I play a lot of Solitaire?"

The interviewer gives you a long, disdainful look. You can tell from that stare that he's more of a Minesweeper kind of guy.

"Uh huh. We probably shouldn't dwell too much on your solitary pursuits, then." He flips over to a new page in his notebook. "Now then, why do you want to come to CMU?"

<<warner_interviewer.giveImpression(-1)>>
<.convnode interest>
""";


// Help me out here --jocelynh


/*******************<CMU Interest>*******************/

+ ConvNode 'interest';

++ SpecialTopic 'say academics'
'academics|learning|school'
"""
You decide it's harmless to overstate your position a bit, and declare,
"People here push the boundaries of what we as a species can understand, and I want to be one of those people."

The interviewer sheds a single tear, gives you a warm smile, and says "Yes... yes."

<<warner_interviewer.giveImpression(1)>>
<.convnode decision>
""";

++ SpecialTopic 'ranking'
'(school%s+)?rank(ing)?'
"""
"I want to know more than everyone else. When I walk into a room, I want to be smarter than everyone there, and that's what CMU is to me."

The interviewer quietly nods, and makes eye contact.
He whispers to you,
"You truly understand what goes on here, I can see that now."

You try to hide a confused look.

<<warner_interviewer.giveImpression(1)>>
<.convnode decision>
""";

++ SpecialTopic 'robots'
'robot(s|ics)|machines'
"""
"I like robots."

The interviewer says, "Yeah, we have those here."

<.convnode decision>
""";

++ SpecialTopic 'bagpipes'
'(bag)?pipes|(the%s+)?(kiltie%s+)?band'
"""
"I like bagpipes."

"Yeah, we have those here," the interviewer says, but then pauses, looking you over.
"If you were to come here, and play bagpipes..." he begins.
<br>
"Yes?" you inquire.
<br>
The interviewer looks out the door, and decides there's nobody in earshot.

He begins, quietly, "If you... somehow get in... could you convince the bagpipes teacher to hold bagpipe practice somewhere that isn't right outside my window? I could... you know... pull a string or two."
<br>
He looks at you, waiting for an answer.

<.convnode bagpipe bribery>
""";

+ ConvNode 'bagpipe bribery';

++ DefaultAskTellTopic
"""
The interviewer is giving you a serious look, waiting for an answer to his question.
""";

++ YesTopic, SuggestedYesTopic
"""
"I mean, I would have to get in if I were to do that." You give a devilish smile.

The interviewer sits back in his seat, and says "You sure would. You sure would."

<b>You just bribed an admissions interviewer, and you're already an admitted student.</b>

<<warner_interviewer.giveImpression(10)>>
<.convnode decision>
""";

++ NoTopic, SuggestedNoTopic
"""
"Oh, they'd never listen to me. Sorry, I can't help."

The interviewer sits up quickly and says, "Well, now, that's just, it was... really more of an idle curiosity, and... So, anyways, I think this interview is done, don't you?!"
He seems overeager to get through this now.

<<warner_interviewer.giveImpression(-10)>>
<.convnode decision>
""";

++ SpecialTopic 'blackmail him'
'blackmail(%s+(him|the%s+interviewer))?'
"""
"No, I won't, they can bagpipe wherever they please."

The interviewer begins to speak, but you interrupt him.

"-- I wonder what would happen if Dick Cyert caught wind of this?"
<br>
<<if tape_recorder.location==gPlayerChar>>
The interviewer becomes quite cross with you. He stands up, about to tell you off, but then he notices his tape recorder isn't where he left it, and his jaw drops.
<br>
You put on your most devilish smile, and slowly pull it out of your coat. At this moment, you realize you never actually turned it on. He probably won't notice.
<br>
The interviewers eyes get very wide, and he starts to sweat.
<br>
"That wouldn't be very good for you, hmm?"
<br>
The interviewer shakes his head.
<br>
"I would be pretty upset if I didn't get into college, you know."
<br>
The interviewer nods his head vigorously.
<br>
"Well then," you say as you stand up, "I think we're finished here."
<br>
He whimpers.

<.reveal interviewer-intimidation>
<.convnode decision>
<<else>>
"What are you trying to pull here?!" he yells.
<br>
You shrug.
<br>
"You... you have no proof!" he says, desperately.
<br>
The problem is, he's right: you don't.
You ou notice a tape recorder, <b>right in front of you</b>, on his desk.

<b>Man, what a missed opportunity.<\b>


<<warner_interviewer.setCurState(interviewerAngry)>>
<<warner_interviewer.giveImpression(-100)>>
<.convnode decision>
""";


/****************<Admittance Decision>****************/

+ ConvNode 'decision';

++ SpecialTopic 'conclude the interview'
'(end|conclude|finish|done|leave|exit)(%s+the%s+interview)?'
"""
"Well, I think I know enough about you to make my decision now, thanks so much for your time." says the interviewer.

<<if (warner_interviewer.interest>4)>>
You catch a look at the interviewer's page again, he's got lots of things circled, and, for whatever reason, has drawn little hearts at the bottom of the page. You're pretty sure you've made it.
<<else>>
You see the interviewer's notes, and there's much more profanity than you expected to see. You're pretty sure you just failed the admittance interview.
<<end>>
<<warner_interviewer.decideAdmittance(warner_interviewer.interest)>>
""";

++ SpecialTopic 'stare him down'
'(stare%s+him%s+down)|(blackmail(%s+him)?)'
"""
You look straight through him, burning his soul with your eyes.
<br>
"So, do you think I have anything to worry about?" you ask, fiendishly.
<br>
The interviewer looks like he's about to throw up. He shakes his head no.
<br>
You walk to the door, slowly, and then turn to him and say,
"Good. I would hate to be disappointed."
<br>
He lets out a small yelp as you leave the room.

<<warner_interviewer.decideAdmittance(100)>>
<<warner_interviewer.setCurState(interviewerAfraid)>>
<<gPlayerChar.scriptedTravelTo(warner_second_floor)>>
""" isActive = (gRevealed('interviewer-intimidation'));


