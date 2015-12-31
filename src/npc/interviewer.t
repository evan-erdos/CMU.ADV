/* Jocelyn Huang * jocelynh@andrew.cmu.edu * 2015-11-24 * interviewer */
/* Ford Seidel * fseidel@andrew.cmu.edu * 2015-11-25 * CIT text */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"
#pragma newline_spacing(preserve)


warner_interviewer : Person
'interviewer' 'Harried Interviewer' @interview_room
"He looks baffled at your presence but seems to be too confused about his own schedule to chase you out of the interview room. He's offered you an interview, so what are you waiting for? " {
    isHim = true;
    globalParamName = 'interviewer';

    initSpecialDesc {
        isInInitState = null;
        """
        The interviewer in the room jumps and drops some papers as you enter, then waves you in while surreptitiously sliding the fallen sheaf under his desk with his foot.
        "You must be... uh... Well, are you here for an interview?" He trails off and scratches his head.

        Maybe you should leave before confusing him even more.
        """;
    }

    specialDesc { warner_interviewer_list.doScript(); }

    /* To be awarded at the completion of the interview */
    interview_achievement : Achievement { +3 "taking an admissions interview as a student... oops." }
}

+ interviewerTalking : InConversationState
    specialDesc = "The interviewer looks at you expectantly. ";

++ interview_state : ConversationReadyState
    isInitState = true
    commonDesc = 'shuffling papers on his desk.'
    specialDesc = 'The interviewer is <<commonDesc>>'
    stateDesc = 'He is <<commonDesc>>';

+++ HelloTopic, ShuffledEventList
    ['''
    "I'm here for my interview!" you announce.
    "Ah, very good," he replies, looking relieved that you seem to know what you're doing.
    "Why don't we get started?"

    Perhaps you should tell him a little about yourself.
    ''']
    ['He smiles at you.'];

// Eventually need to change the point awarding to the end of the interview, not arbitrarily when you say bye
+++ ByeTopic, ShuffledEventList
    [{: """
    "Thanks for the interview!" you say.

    "Best of luck to you in your college process, I'm sure you'll be fine!" the interviewer replies, scribbling madly on a notepad. "Thanks for coming by and considering Carnegie Mellon."
    """,
    warner_interviewer.interview_achievement.awardPointsOnce()}];

+++ ImpByeTopic
    """
    The interviewer turns back to his desk while awkwardly avoiding looking at you.
    """;

++ DefaultAskTopic, ShuffledEventList
    ['''
    He doesn't seem to be certain about anything, but gives you a puzzled but reassuring nod.
    ''',
    '''
    He doesn't seem to know what you're talking about, but in an effort to look professional he puts a finger to his chin and then doodles on his notepad.
    '''];

++ DefaultTellTopic, ShuffledEventList
    ['''
    He listens carefully and says, "Hmmm, yes."
    You're pretty sure he has no idea what you're talking about.''']
;

// Tell the interviewer about yourself (e.g. "tell him about me")
++ TellTopic, ShuffledEventList @me
    ['''
    You're already a student here, but you're starting to find this whole situation rather amusing.

    "I'm a Pittsburgh native who has been interested in Carnegie Mellon for years! I practically live on campus already, I'm here so often." ...Well, technically, you're not lying. So far, so good. The interviewer still seems enthusiastic but expectant, so you think hard for something generic to say so that your cover doesn't get blown.

    "I love Cobot!" You blurt out.

    The interviewer's face lights up. "Oh, you know about <b>Cobot</b>?" He seems interested in hearing more.
    <.convnode cobot>
    ''']
    ['''
    You have already told the interviewer a bit about yourself, so you figure you should try talking to him about something else. He probably won't kick you out.
    ''']

    name = 'yourself'
;

// Start of interview conversation node.
+ ConvNode 'cobot';

++ DefaultAnyTopic
    """
    You should probably tell him about Cobot.
    <.convstay>
    """;

++ TellTopic 'cobot'
    """
    Now you're in familiar territory! You've spent countless hours following Cobot around Gates and occasionally tormenting it by opening and closing the elevator doors before it could get on or off. You guys are tight. You just have to make sure you don't say too much and give yourself away.

    "He's that robot that rolls around the Computer Science program, right? When I come for... events, I sometimes see him mapping the area and carrying papers on errands."

    The interviewer nods, seemingly impressed by your knowledge of GHC happenings.

    "I assume you're applying to our School of Computer Science, then?"
    <.convnode major>
    """;

+ ConvNode 'major';

++ DefaultAnyTopic
    """
    What school do you want to tell him you're "applying" to?
    <.convstay>
    """;

++ YesTopic, SuggestedYesTopic
    /* I'm not biased, nope not at all --jocelynh */
    """
    Of course you are! CS is only the absolute coolest major there is. You enthusiastically tell him, "I love computer science! I've been in love with Graph Theory since I was a toddler and my mom told me to find the nearest shopping cart. After implementing a quick shortest path algorithm in my head (Dijkstra for efficient parallelization, of course), I was absolutely smitten."

    The interviewer nods sagely, and jots something down on his notepad. Craning your neck slightly, you can see what he has written. You can make out one line:

    > What is a 'dike-astra'? impressive "graph theory" knowledge.

    "Great! As you know, admissions are very competitive, but students learn a lot through our vigorous program! Of course, I'll need to know if you've had any prior experience. Do you want to tell me about any of your extracurriculars?"
    <.convnode extracurriculars>
    """;

++ NoTopic, SuggestedNoTopic
    """
    "Oh, no, I'm just a fan of Cobot," you say. "I think he's cute! And he carries candy sometimes, so I like to hang around."

    The interviewer seems mildly amused by your response. He flounders for a bit, then apparently realizes that he still hasn't found out what you're interested in. "What school are you applying to, then? Or... wait, did you say you were going for CS?" What a confused man.
    <.convstay>
    """;

++ SpecialTopic 'CIT'
['cit', 'engineering', 'ece', 'meche']
    """
    You're in it for the engineering, of course! You love resistors, or bridges, or civil people or something. Or civil people on jammed bridges.
    "I want to be an engineer. My father and his father before him were engineers, and since birth, I've known that engineering was my calling. Plus, I hear you guys have a great engineering program. Out of curiosity, why does it take four years to learn how to operate a machine that can only speed up and slow down along a track?"

    The interviewer steeples his fingers and looks down his nose at you. "It's a fine art of balance and morality, especially when you're faced with either running one person over or two. Now, I need to know, do you have the background in extracurriculars to undertake this rigorous training?"
    <.convnode extracurriculars>
    """;

++ SpecialTopic 'Drama' ['drama', 'school of drama']
    """
    Okay, taking a quick break from narrating to say, <b>what are you doing in the CClub text adventure</b>? But. Anyway.

    "The gods have sent me yonder way, whenceforth I have taken upon me to apply to this divine school for its splendiferous Dramatization Program!"

    You have no idea if half of the things you've said are even words, and for some reason you appear to be holding a skull in your hand as you kneel to the interviewer. He seems impressed with your yowling, though.

    "Oh, what splendid acting! So you're a fan of the performing arts! What's your favorite play?"
    Oh come on, the answer is obvious.
    <.convnode drama>
    """;

++ SpecialTopic 'Tepper'
['tepper', 'business', 'socializing', 'suit wearing']
    """
    Agh, how could he possibly think that you would willingly associate with those socially-blind androids?!

    "Ohh, nooo," you quickly say, "I aspire to be an entrepreneur! I take my inspiration from the great Andrew Carnegie himself."

    The interviewer nods sagely. "Ah, yes. Here to make... <i>connections</i>." He coughs, then moves on.

    "Please, tell me about your socialization and the connections you've made through extracurriculars."
    <.convnode extracurriculars>
    """;

++ SpecialTopic 'Dietrich' ['dietrich', 'humanities']
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
['mcs', 'mellon', 'science', 'math']
    """
    Beakers, flasks (containing alcohol, or otherwise), and equations are your thing. You live for biology/chemistry/physics/math/jesuschristhowmanymajorsareinthisonecollege.

    "I am a pursuer of the truth! I live by the scientific method and aspire to discover the laws of universe. To discover the secrets residing in the natural world and in higher mathematics is my goal!"

    The interviewer looks at you blankly, and slowly writes "MCS" in large block letters on his notepad. "Right. Do you know what major you would want to pursue?"
    <.convnode mcsmajor>
    """;

++ SpecialTopic 'CFA' ['arts', 'college of fine arts']
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
    The interviewer seems dissatisfied with your response. Did you mean <b>Pippin</b>?
    <.convstay>
    """;

++ SpecialTopic 'say Pippin' ['Pippin']
	"""
    "<b>GREAT!</b>" he says, a little bit too excitedly. You lean away slightly from flying spittle. "Yes. Anyway."

    He coughs. "Back on (Tartan)Tra(c)k. Given that you seem to have a solid acting background, I assume you participate in extracurricular activities?"
    <.convnode extracurriculars>
    """;


/**********************<MCS>*************************/

+ ConvNode 'mcsmajor';

++ SpecialTopic 'Math' ['math', 'mathematics']
    // I actually have no idea what to say here though --jocelynh
    // apparently neither do I --ben
    """
    You ask the interviewer, "Did I see Paul Erdos wandering around outside Hunt? I thought he was dead."

    The interviewer coughs loudly to interrupt you, and sits up in his seat.
    "-NO. Uh, no. You didn't... that isn't... it's not...
    No. you didn't."

    Honestly not sure what to make of that.
    """;

++ SpecialTopic 'Biology' ['biology', 'bio']
    """
    "The quickest way to my heart is through biology... and through my stomach and intestines!" You give a cheesy grin.

    You're pretty sure Terry Pratchett said something like that in one of his many books. But in the context of assassins. What a legend.

    The interviewer groans.
    "Alright, then. What extracurriculars have you been involved in that also warm your heart or whatever?"
    <.convnode extracurriculars>
    """;

++ SpecialTopic 'Chemistry' ['chemistry', 'chem']
    """
    "I'm thinking about majoring in chemistry," you say. "I enjoy acids and bases and learning about bonds and things! As my chem teacher used to say, 'If you're not part of the problem, you're part of the precipitate.' Wait, you think you screwed that one up. Crap. The interviewer doesn't seem to notice, though.

    "Ahh, yes. Looking to invent the next superglue or Kevlar, are we? Did you know that Kevlar was invented here?"

    "Nah, I just like silly putty and I want there to be more of it in the world," you shrug.

    The interviewer must not realize that you can see almost everything he's writing. You saw he just crossed out a line which read "The perfect student?".

    "That's a... unique goal. We may have to work on those long-term goals, I guess. What are you interested in outside of class, then?"
    <.convnode extracurriculars>
    """;

++ SpecialTopic 'Physics' ['physics']
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
['no', 'none', 'nothing', 'nope']
    ['''
    You think you'll have a little fun and break the model applicant mold. "Nope," you say cheerfully.

    The interviewer looks shocked and scandalized, and his expression alternates between horror and surprise, then compromises by settling into dignified disgust.

    You realize that this may have been a mistake. Better make something up real quick! "Haha, I'm just joking, I'm actually in..."
    <.convstay>''']
    ['''
    You probably shouldn't be pushing your luck further. Nice try, buster. Nearly got yourself kicked out, there.
    <.convstay>
    ''',
    '''
    No, seriously, just make something up if you really don't have any experience in anything.
    <.convstay>
    ''',
    'Please?',
    'Seriously, just pick anything. Responses are gonna start looping soon.', // meta
    'You have a life, trust me. Pick an extracurricular!'];

++ SpecialTopic 'computer club'
['computing', 'programming', 'computer', 'club']
    """
    <b>(Heh, you suck-up.)</b>
    "I'm in computer club," you declare proudly.
    """;

++ SpecialTopic 'drama'
['acting', 'drama', 'theatre', 'theater', 'improv']
    """
    "I act, of course!"
    """;

// The only correct answer is... --jocelynh
++ SpecialTopic 'stage crew'
['stage', 'lighting', 'light', 'sound', 'tech', 'crew']
    """
    "I'm not flamboyant enough to be an actor, so I do stage crew."
    """
; // (I'm really biased.)

++ SpecialTopic 'bridge'
['bridge', 'contract bridge', 'bridge club']
    """
    American Contract Bridge. Ah, the game of intellectuals.

    "I am personally rather fond of Bridge, and not the one that you cross to get into Pittsburgh. 'Bridge, and not chess, is the ultimate war game,'" you quote. Michael Leeden.

    "Ah, good, you enjoy strategy and thinking games!" He discreetly scribbles "Gets along with old people, plays cards" on his notepad.
    "I think I have something for you, then..."

    The interviewer flails his hands briefly across his desk before hastily yanking a battered-looking flier from under a desk lamp.

    "Here it is. We don't have a Bridge club proper, but we do have a group that plays Bridge every Saturday morning in the UC!" Glancing at the flier, you see <b>9:30AM</b> printed in large font, and decide against waking up early to go. You like Bridge, but you also like sleep.

    "Thanks for letting me know," you say, flapping the paper briefly and then placing it aside to be immediately lost in the clutter.

    "Bridge is a pretty specialized group activity, though; so what do you do in your own free time?"
    <.convnode sparetime>
    """;

// fseidel, do you want to take this one? --jocelynh
++ SpecialTopic 'robotics'
['FIRST', 'robotics', 'robotics club']
    """
    WOw LOOk roBOts!1!
    """;

++ SpecialTopic 'anime club'
['anime', 'japanese', 'weeaboo', 'weeb']
    """
    "私はアニメが大好きです~~~!" you... exclaim?
    <b>I don't know, I just work here.</b>
    """;

++ SpecialTopic 'sports'
['sports', 'exercise', 'football', 'basketball',
 'baseball', 'soccer', 'tennis', 'golf', 'track',
 'badminton', 'lacrosse', 'rugby', 'field', 'hockey']
    """
    You pride yourself in sports, or at least you'll pretend to. Flexing your not-particularly-defined biceps, you declare, "I love sports! I love watching all the tournaments, from the Superbowl to the World Cup to the US Open. In fact, I'm so devoted to sports that I've practiced enough to become the captain of my school's... *mumble* ...team, carrying us to the championship for the past two years in a row."

    "Ah, an athlete!" the interviewer enthuses, "We like good athletes and I think you would fit in well here please come I promise we actually do have football fields and soccer fields and golf and everything."

    There seems to be a touch of desperation in his voice. He sees your surprise at his outburst and mistakes it for hesitation. Eager to further the conversation and usher you through the interview, he continues:

    "You seem like a great fit for the school and I'd like to learn more about you! We have a lot of unique people and cultures here, and so I'd like to ask--what hobbies do you have outside of sports that you enjoy in your own time?"
    <.convNode sparetime>
    """;

++ SpecialTopic 'use one of the sports you eavesdropped in the other room'
['quidditch', 'jai alai', 'flag football', 'foosball',
 'calvinball', 'hopscotch', 'parkour', 'hitball']
    """
    You decide to take a leaf out of that random other interviewee's book and chuck up some random ridiculous sports. You manage to rattle off "Quidditch, Jai Alai, flag football, foosball, Calvinball, hopscotch, parkour, hitball..." and claiming that you've been team captain for about half of these before the interviewer cuts you off.

    "You seem to have... <i>eclectic</i> tastes in physical activity," he comments. "That's good; we like to see a healthy interests in a variety of unique fields. I can also see that you have had ample leadership experience through your sports!"

    You can't believe he actually bought it, but sure, you'll take it. <b>You daredevil</b>.

    The interviewer continues, "So I can see that you seem very well-rounded in your activities, but tell me a little about what you do in your alone time."
    <.convnode sparetime>
    """;


/***************<Spare Time Activities>***************/

+ ConvNode 'sparetime';

++ SpecialTopic 'say reading'
['read', 'reading', 'books', 'literature']
    """
    You like your literature, and don't hesitate to let the world know.

    "I <b>love</b> reading!" you trumpet, startling the interviewer. "From Terry Pratchett to Malcolm Gladwell, Daniel Tammet to Douglas Adams, I love them all. I have a Kindle for travel, a library-in-progress at home, and I know my library card number backwards and forwards!"

    The interviewer looks pleased at your intellectual and literary curiosity. He waves at you a copy of Randy Pausch's <b>The Last Lecture</b>. "Have you read this?"
    "Of course I have! I love his commentary on the frailty of human life and on optimism in the face of mortality." What a great man.

    "He was a professor here, you know," the interviewer says, almost proudly. "Well, enough of that. You seem like a bright kid and a good fit. But I'd like to know specifically, what interests you about CMU?"
    <.convnode interest>
    """;


++ SpecialTopic 'play video games'
['play games', 'play video games', 'gaming', 'video games']
    """
    "I sometimes play video gam-"
    "You're a piece of shit!" the interviewer yells, very suddenly. He sits back in his seat with a cross-eyed look for a few seconds, and his head tilts to the side. Then, he continues on like nothing happened.

    Huh. That... hmm.
    That... seemed... uhh...
    You're not sure what to do with that one.
    """;


++ SpecialTopic 'watch TV'
['watch TV', 'watch Netflix', 'watch shows', 'watch movies']
    """
    You decide to intentionally screw with the interviewer.

    "I do very little, outside of watching television."

    It backfires.

    "Oh wonderful! It's so good to have a hobby. So, why do you want to come to CMU?" He keeps the same enormous grin for an uncomfortable period of time afterwards.

    What?

    <.convnode interest>
    """;


++ SpecialTopic 'solitaire'
['play solitaire', 'solitaire']
    """
    You really can't think of anything that might be done alone, and in the heat of the moment, you say "I play a lot of Solitaire?"

    The interviewer gives you a long, disdainful look. You can tell from that stare that he's more of a Minesweeper kind of guy.

    "Uh huh. We probably shouldn't dwell too much on your solitary pursuits, then." He flips over to a new page in his notebook. "Now then, why do you want to come to CMU?"
    <.convnode interest>
    """;


// Help me out here --jocelynh


/*******************<CMU Interest>*******************/

+ ConvNode 'interest';

++ SpecialTopic 'say academics'
['academics', 'learning']
    """
    """;

++ SpecialTopic 'ranking'
['school ranking', 'ranking']
    """
    """;

++ SpecialTopic 'robots'
['robots', 'robotics']
    """
    """;

++ SpecialTopic 'bagpipes'
['bagpipes', 'the kiltie band']
    """
    """;

/*****************************************************/


me : Topic 'myself/me';

warner_interviewer_list : ShuffledEventList, RandomFiringScript
    ['The interviewer bumbles around his office, slipping a few times on the papers under his desk, and scratches his head a bit.',
     'The interviewer now appears to have found what his previous head-scratching efforts didn\'t yield. ',
     'The interviewer begins stapling a big stack of papers. ',
     'You squirm a bit as you watch the interviewer narrowly avoid stapling his thumb to some poor student\'s application.']
    ['The interviewer continues stapling.']
    eventPercent = 80;


