/* Jocelyn Huang * jocelynh@andrew.cmu.edu * 2015-11-24 * interviewer */
/* Ford Seidel * fseidel@andrew.cmu.edu * 2015-11-25 * CIT text */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

warner_interviewer : Person 'interviewer' 'Harried Interviewer' @interview_room
"He looks baffled at your presence but seems to be too confused about his own schedule to chase you out of the interview room. He's offered you an interview, so what are you waiting for?" {
    isHim = true;
    globalParamName = "interviewer";

    initSpecialDesc {
        isInInitState = null;
        "The interviewer in the room jumps and drops some papers as you enter, then waves you in while surreptitiously sliding the fallen sheaf under his desk with his foot. \"You must be... uh... Well, are you here for an interview?\" He trails off and scratches his head. Maybe you should leave before confusing him even more.";
    }

    specialDesc { warner_interviewer_list.doScript(); }

    /* To be awarded at the completion of the interview */
    interview_achievement : Achievement {+3 "taking an admissions interview as a student... oops."}
    // present tense for achievements --bescott
}

+ interviewerTalking : InConversationState
    specialDesc = "The interviewer looks at you expectantly."
;

++ interview_state : ConversationReadyState
    isInitState = true
    commonDesc = 'shuffling papers on his desk.'
    specialDesc = 'The interviewer is <<commonDesc>>'
    stateDesc = 'He is <<commonDesc>>'
;

+++ HelloTopic, ShuffledEventList
    ['<q>I\'m here for my interview!</q> you announce.\b
      <q>Ah, very good,</q> he replies, looking relieved that you seem to know what you\'re doing. <q>Why don\'t we get started?<\q>\b
      Perhaps you should tell him a little about yourself.']
    ['He smiles at you.']
;

// Eventually need to change the point awarding to the end of the interview, not arbitrarily when you say bye
+++ ByeTopic, ShuffledEventList
    [{: "<q>Thanks for the interview!</q> you say.\b
     <q>Best of luck to you in your college process, I'm sure you'll be fine!</q> the interviewer replies, scribbling madly on a notepad. <q>Thanks for coming by and considering Carnegie Mellon.</q> ",
     warner_interviewer.interview_achievement.awardPointsOnce()}]
;

+++ ImpByeTopic
    "The interviewer turns back to his desk while awkwardly avoiding looking at you."
;

++ DefaultAskTopic, ShuffledEventList
    ['He doesn\'t seem to be certain about anything, but gives you a puzzled but reassuring nod.',
     'He doesn\'t seem to know what you\'re talking about, but in an effort to look professional he puts a finger to his chin and then doodles on his notepad.']
;

++ DefaultTellTopic, ShuffledEventList
    ['He listens carefully and says, <q>Hmmm, yes.</q> You\'re pretty sure he has no idea what you\'re talking about.']
;

// Tell the interviewer about yourself (e.g. "tell him about me")
++ TellTopic, ShuffledEventList @me
    ['You\'re already a student here, but you\'re starting to find this whole situation rather amusing.\b
      <q>I\'m a Pittsburgh native who has been interested in Carnegie Mellon for years! I practically live on campus already, I\'m here so often.</q> ...Well, technically, you\'re not lying. So far, so good. The interviewer still seems enthusiastic but expectant, so you think hard for something generic to say so that your cover doesn\'t get blown.\b
      <q>I love Cobot!</q> You blurt out.\b
      The interviewer\'s face lights up. <q>Oh, you know about <b>Cobot</b>?</q> He seems interested in hearing more.
      <.convnode cobot>']

    ['You have already told the interviewer a bit about yourself, so you figure you should try talking to him about something else. He probably won\'t kick you out.']

    name = 'yourself'
;

// Start of interview conversation node.
+ ConvNode 'cobot'
;

++ DefaultAnyTopic
    "You should probably tell him about Cobot. <.convstay>"
;

++ TellTopic 'cobot'
    "Now you\'re in familiar territory! You\'ve spent countless hours following Cobot around Gates and occasionally tormenting it by opening and closing the elevator doors before it could get on or off. You guys are tight. You just have to make sure you don\'t say too much and give yourself away.\b
     <q>He\'s that robot that rolls around the Computer Science program, right? When I come for... events, I sometimes see him mapping the area and carrying papers on errands.</q>\b
     The interviewer nods, seemingly impressed by your knowledge of GHC happenings. <q>I assume you\'re applying to our School of Computer Science, then?</q> <.convnode major>"
;

/* A conversation node about your major. Pick the school you're in. */
+ ConvNode 'major'
;

++ DefaultAnyTopic
    "What school do you want to tell him you're \"applying\" to? <.convstay>"
;

++ YesTopic, SuggestedYesTopic
    /* I'm not biased, nope not at all --jocelynh */
    "Of course you are! CS is only the absolute coolest major there is. You enthusiastically tell him, <q>I love computer science! I've been in love with Graph Theory since I was a toddler and my mom told me to find the nearest shopping cart. After implementing a quick shortest path algorithm in my head (Dijkstra for efficient parallelization, of course), I was absolutely smitten.</q>\b

     The interviewer nods sagely, and jots something down on his notepad. Craning your neck slightly, you can see that he has written <q>What is Dijkstra? Very impressed with graph theory knowledge.</q>\b

     <q>Great! As you know, admissions are very competitive, but students learn a lot through our vigorous program! Of course, I'll need to know if you've had any prior experience. Do you want to tell me about any of your extracurriculars?</q><.convnode extracurriculars>"
;

++ NoTopic, SuggestedNoTopic
    "<q>Oh, no, I'm just a fan of Cobot,</q> you say. <q>I think he's cute! And he carries candy sometimes, so I like to hang around.</q>\b

     The interviewer seems mildly amused by your response. He flounders for a bit, then apparently realizes that he still hasn't found out what you're interested in. <q>What school are you applying to, then? Or... wait, did you say you were going for CS?</q> What a confused man.<.convstay>"
;

++ SpecialTopic 'CIT' ['cit', 'engineering', 'ece', 'meche', 'college of engineering']
    "You're in it for the engineering, of course! You love resistors, or bridges, or civil people or something. Or civil people on jammed bridges.\b
    <q>I want to be an engineer. My father and his father before him were engineers, and since birth, I've known that engineering was my calling. Plus, I hear you guys have a great engineering program. Out of curiosity, why does it take four years to learn how to operate a machine that can only speed up and slow down along a track?</q>\b
    The interviewer steeples his fingers and looks down his nose at you. <q>It's a fine art of balance and morality, especially when you're faced with either running one person over or two. Now, I need to know, do you have the background in extracurriculars to undertake this rigorous training?</q><.convnode extracurriculars>"
;

++ SpecialTopic 'Drama' ['drama', 'school of drama']
    "Okay, taking a quick break from narrating to say, <b>what are you doing in the CClub text adventure</b>? But. Anyway.\b
    <q>The gods have sent me yonder way, whenceforth I have taken upon me to apply to this divine school for its splendiferous Dramatization Program!</q> You have no idea if half of the things you've said are even words, and for some reason you appear to be holding a skull in your hand as you kneel to the interviewer. He seems impressed with your yowling, though.\b
    <q>Oh, what splendid acting! So you're a fan of the performing arts! What's your favorite play?</q>\b
    Oh come on, the answer is obvious.<.convnode drama>"
;

++ SpecialTopic 'Tepper' ['tepper', 'business', 'socializing', 'tepper school of business', 'suit wearing']
    "Agh, how could he possibly think that you would willingly associate with those socially-blind androids?! <q>Ohh, nooo,</q> you quickly say, <q>I aspire to be an entrepreneur! I take my inspiration from the great Andrew Carnegie himself.</q>\b
    The interviewer nods sagely. <q>Ah, yes. Here to make... <i>connections</i>.</q> He coughs, then moves on. <q>Please, tell me about your socialization and the connections you've made through extracurriculars.</q><.convnode extracurriculars>"
;

++ SpecialTopic 'Dietrich' ['dietrich', 'humanities', 'school of arts and sciences']
    "What do they even do in there? You don't really know, but decide to take a potshot and claim you're applying here anyway. <q>Dietrich!</q> you announce in your most overenthusiastic voice. Hopefully, your faux-excitement will carry you through here.\b
    <q>Oh, yes! I'm a graduate of Dietrich, myself.</q>\b
    Oh, crap. <q>Oh... that's, uh. That's great! How did you like it?</q>\b
    Thankfully, your question seems to have diverted the interviewer's interest in you, and he spends five minutes rambling about his college experience. You listen attentively and retain nothing of what he has said.\b
    <q>Er, right. So... where were we?</q> He asks sheepishly, then glances a bit too obviously at a post-it note on his monitor labeled <q>Generic Interview Questions</q>. <q>Oh. Right. Extracurriculars. Yes. Do you have them?</q><.convnode extracurriculars>"
;

++ SpecialTopic 'MCS' ['mcs', 'mellon', 'college of science', 'science', 'math']
    "Beakers, flasks (containing alcohol, or otherwise), and equations are your thing. You live for biology/chemistry/physics/math/jesuschristhowmanymajorsareinthisonecollege. <q>I am a pursuer of the truth! I live by the scientific method and aspire to discover the laws of universe. To discover the secrets residing in the natural world and in higher mathematics is my goal!</q>\b
    The interviewer looks at you blankly, and slowly writes <q>MCS</q> in large block letters on his notepad. <q>Right. Do you know what major you would want to pursue?</q><.convnode mcsmajor>"
;

++ SpecialTopic 'CFA' ['arts', 'college of fine arts']
    "<q>Warhooooool!</q> you yell madly as a sort of interview war-cry.\b
    The interviewer lets out a small squeak and scrambles backwards. His chair tips over, dumping him unceremoniously on his side. As he clambers back up and rights his chair, you hear him mutter, <q>Oh joy, another crazy art person.</q>\b
    He grabs his notepad and licks the tip of his pencil. It's kind of gross. <q>I'm guessing that you spend a lot of time on art projects, but what else do you do outside of class?</q><.convnode extracurriculars>"
;

/********************<Drama>************************/
+ ConvNode 'drama'
;

++ DefaultAnyTopic
	"The interviewer seems dissatisfied with your response. Did you mean <b>Pippin</b>?<.convstay>"
;

++ SpecialTopic 'say Pippin' ['Pippin']
	"<q><b>GREAT!</b></q> he says, a little bit too excitedly. You lean away slightly from flying spittle. <q>Yes. Anyway.</q>\b
     He coughs. <q>Back on (Tartan)Tra(c)k. Given that you seem to have a solid acting background, I assume you participate in extracurricular activities?<.convnode extracurriculars></q>"
;

/**********************<MCS>*************************/
+ ConvNode 'mcsmajor'
;

++ SpecialTopic 'Math' ['math', 'mathematics'] // But we must have Paul Erdos! --jocelynh
    ""
;

++ SpecialTopic 'Biology' ['biology', 'bio']
    "<q>The quickest way to my heart is through biology... and through my stomach and intestines!</q> You give a cheesy grin. You're pretty sure Terry Pratchett said something like that in one of his many books. But in the context of assassins. What a legend.\b
    The interviewer groans.\b
    <q>Alright, then. What extracurriculars have you been involved in that also warm your heart or whatever?</q><.convnode extracurriculars>"
;

++ SpecialTopic 'Chemistry' ['chemistry', 'chem']
    "<q>I'm thinking about majoring in chemistry,</q> you say. <q>I enjoy acids and bases and learning about bonds and things! As my chem teacher used to say, 'If you're not part of the problem, you're part of the precipitate.</q> Wait, you think you screwed that one up. Crap. The interviewer doesn't seem to notice, though.\b
    <q>Ahh, yes. Looking to invent the next superglue or Kevlar, are we? Did you know that Kevlar was invented here?</q>\b
    <q>Nah, I just like silly putty and I want there to be more of it in the world,</q> you shrug.\b
    The interviewer seems put out, but staunchly keeps going. <q>That's a... unique goal. We may have to work on those long-term goals, I guess. What are you interested in outside of class, then?</q><.convnode extracurriculars>"
;

++ SpecialTopic 'Physics' ['physics']
    "You have a deep love of spherical cows and frictionless surfaces. In a perfect world, you've always believed there would be no thermal energy loss or drag force.\b
    <q>Physics!</q> you declare proudly, <q>My role models are Einstein and Feynman, though the admiration sadly doesn't go as far as bongo drums.</q>
    <q>May the force be with you,</q> the interviewer intones."
;

/*****************<Extracurriculars>*****************/
+ ConvNode 'extracurriculars'
;

++ SpecialTopic, ShuffledEventList 'say none' ['no', 'none', 'nothing', 'nope']
    ['You think you\'ll have a little fun and break the model applicant mold. <q>Nope,</q> you say cheerfully.\b
    The interviewer looks shocked and scandalized, and his expression alternates between horror and surprise, then compromises by settling into dignified disgust.\b
    You realize that this may have been a mistake. Better make something up real quick! <q>Haha, I\'m just joking, I\'m actually in...</q><.convstay>']

    ['You probably shouldn\'t be pushing your luck further. Nice try, buster. Nearly got yourself kicked out, there.<.convstay>',
    'No, seriously, just make something up if you really don\'t have any experience in anything.<.convstay>',
    'Please?',
    'Seriously, just pick anything. Responses are gonna start looping soon.',
    'You have a life, trust me. Pick an extracurricular!']
;

++ SpecialTopic 'computer club' ['computing', 'programming', 'computer', 'club']
    "(Heh, you suck-up.)\b
    <q>I'm in computer club,</q> you declare proudly."
;

++ SpecialTopic 'drama' ['acting', 'drama', 'theatre', 'theater', 'improv']
    "<q>I act, of course!</q>"
;

// The only correct answer is... (--jocelynh)
++ SpecialTopic 'stage crew' ['stage', 'construction', 'lighting', 'light', 'sound', 'tech', 'crew']
    ""
; // (I'm really biased.)

++ SpecialTopic 'bridge' ['american contract', 'bridge', 'contract bridge', 'bridge club']
    "American Contract Bridge. Ah, the game of intellectuals. <q>I am personally rather fond of Bridge, and not the one that you cross to get into Pittsburgh. 'Bridge, and not chess, is the ultimate war game,'</q> you quote. Michael Leeden.\b
    <q>Ah, good, you enjoy strategy and thinking games!</q> He discreetly scribbles <q>Gets along with old people and plays cards</q> on his notepad. <q>I think I have something for you, then...</q>\b
    The interviewer flails his hands briefly across his desk before hastily yanking a battered-looking flyer from under a desk lamp.\b
    <q>Here it is. We don't have a Bridge club proper, but we do have a group that plays Bridge every Saturday morning in the UC!</q> Glancing at the flyer, you see <b>9:30AM</b> printed in large font, and decide against waking up early to go. You like Bridge, but you also like sleep.\b
    <q>Thanks for letting me know,</q> you say, flapping the paper briefly and then placing it aside to be immediately lost in the clutter.\b
    <q>Bridge is a pretty specialized group activity, though; so what do you do in your own free time?</q><.convnode sparetime>"
;

// fseidel, do you want to take this one? --jocelynh
++ SpecialTopic 'robotics' ['FIRST', 'robotics', 'robotics club']
    ""
;

++ SpecialTopic 'anime club' ['anime', 'anime club', 'japanese', 'japanese club', 'weeaboo', 'weeb']
    ""//"<q>私はアニメが大好きです~~~!</q>"
;

++ SpecialTopic 'sports' ['sports', 'exercise', 'football', 'basketball', 'baseball', 'soccer', 'tennis', 'generic sport', 'golf', 'track', 'and field', 'badminton', 'lacrosse', 'rugby', 'field', 'hockey']
    "You pride yourself in sports, or at least you'll pretend to. Flexing your not-particularly-defined biceps, you declare, <q>I love sports! I love watching all the tournaments, from the Superbowl to the World Cup to the US Open. In fact, I'm so devoted to sports that I've practiced enough to become the captain of my school's</q> (you mumble something) <q>team, carrying us to the championship for the past two years in a row.</q>\b
    <q>Ah, you're an athlete!</q> the interviewer enthuses, <q>we like good athletes and I think you would fit in well here please come I promise we actually do have football fields and soccer fields and golf and everything.</q>\b
    There seems to be a touch of desperation in his voice. He sees your surprise at his outburst and mistakes it for hesitation. Eager to further the conversation and usher you through the interview, he continues:\b
    <q>You seem like a great fit for the school and I'd like to learn more about you! We have a lot of unique people and cultures here, and so I'd like to ask--what hobbies do you have outside of sports that you enjoy in your own time?</q><.convNode sparetime>"
;

++ SpecialTopic 'eavesdropped sports' ['quidditch', 'jai alai', 'flag football', 'foosball', 'calvinball', 'hopscotch', 'parkour', 'hitball']
    "You decide to take a leaf out of that random other interviewee's book and chuck up some random ridiculous sports. You manage to rattle off <q>Quidditch, Jai Alai, flag football, foosball, Calvinball, hopscotch, parkour, hitball...</q> and claiming that you've been team captain for about half of these before the interviewer cuts you off.\b
    <q>You seem to have eclectic tastes in physical activity,</q> he comments. <q>That's good; we like to see a healthy interests in a variety of unique fields. I can also see that you have had ample leadership experience through your sports!</q>\b
    You can't believe he actually bought it, but sure, you'll take it. You daredevil.\b
    The interviewer continues, <q>So I can see that you seem very well-rounded in your activities, but tell me a little about what you do in your alone time.</q><.convnode sparetime>"
;

/***************<Spare Time Activities>***************/
+ ConvNode 'sparetime'
;

++ SpecialTopic 'say reading' ['read', 'reading', 'books', 'literature']
    "You like your literature, and don't hesitate to let the world know.\b
    <q>I <b>love</b> reading!</q> you trumpet, startling the interviewer. <q>From Terry Pratchett to Malcolm Gladwell, Daniel Tammet to Douglas Adams, I love them all. I have a Kindle for travel, a library-in-progress at home, and I know my library card number backwards and forwards!</q>\b
    The interviewer looks pleased at your intellectual and literary curiosity. He waves at you a copy of Randy Pausch's <b>The Last Lecture</b>. <q>Have you read this?</q>\b
    <q>Of course I have! I love his commentary on the frailty of human life and on optimism in the face of mortality.</q> What a great man.\b
    <q>He was a professor here, you know,</q> the interviewer says, almost proudly. <q>Well, enough of that. You seem like a bright kid and a good fit. But I'd like to know specifically, what interests you about CMU?</q><.convnode interest>"
;

++ SpecialTopic 'play video games' ['play games', 'play video games', 'gaming', 'video games']
    ""
;

++ SpecialTopic 'watch Netflix' ['watch TV', 'watch Netflix', 'watch shows']
    ""
;

++ SpecialTopic 'solitaire' ['play solitaire', 'solitaire']
    "You really can't think of anything that might be done alone, and in the heat of the moment, you say <q>I play a lot of Solitaire!</q>\b
    The interviewer gives you a long, disdainful look. You can tell from that stare that he's more of a Minesweeper kind of guy.\b
    <q>Uh huh. We probably shouldn't dwell too much on your solitary pursuits, then.</q> He flips over to a new page in his notebook. <q>Now then, why do you want to come to CMU?</q><.convnode interest>"
;

// Help me out here --jocelynh

/*******************<CMU Interest>*******************/
+ ConvNode 'interest'
;

/*****************************************************/

me : Topic 'myself/me';

warner_interviewer_list : ShuffledEventList, RandomFiringScript
    ['The interviewer bumbles around his office, slipping a few times on the papers under his desk, and scratches his head a bit.',
     'The interviewer now appears to have found what his previous head-scratching efforts didn\'t yield. ',
     'The interviewer begins stapling a big stack of papers. ',
     'You squirm a bit as you watch the interviewer narrowly avoid stapling his thumb to some poor student\'s application.']
    ['The interviewer continues stapling.']
    eventPercent = 80;


