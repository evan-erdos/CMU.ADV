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

     The reporter nods sagely, and jots something down on his notepad. Craning your neck slightly, you can see that he has written <q>What is Dijkstra? Very impressed with graph theory knowledge.</q>\b

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

++ SpecialTopic 'Math' ['math', 'mathematics']
    ""
;

++ SpecialTopic 'Biology' ['biology', 'bio']
    "<q>The quickest way to my heart is through biology... and through my stomach and intestines!</q> You give a cheesy grin. You're pretty sure Terry Pratchett said something like that in one of his many books. But in the context of killing people.\b
    The interviewer groans.\b
    <q>Alright, then. What extracurriculars have you been involved in that also warm your heart or something?</q><.convnode extracurriculars>"
;

++ SpecialTopic 'Chemistry' ['chemistry', 'chem']
    "<q>I'm thinking about majoring in chemistry,</q> you say. <q>I enjoy acids and bases and learning about bonds and things! As my chem teacher used to say, 'If you're not part of the problem, you're part of the precipitate.</q> Wait, you think you screwed that one up. Crap. The interviewer doesn't seem to notice, though.\b
    <q>Ahh, yes. Looking to invent the next superglue or Kevlar, are we? Did you know that Kevlar was invented here?</q>\b
    <q>Nah, I just like silly putty,</q> you shrug.\b
    The interviewer seems put out, but staunchly keeps going. <q>We may have to work on those long-term goals, I guess. What are you interested in outside of class, then?</q><.convnode extracurriculars>"
;

++ SpecialTopic 'Physics' ['physics']
    ""
;

/*****************<Extracurriculars>*****************/
+ ConvNode 'extracurriculars'
;

++ SpecialTopic, ShuffledEventList 'say none' ['no', 'none', 'nothing', 'nope']
    ['You think you\'ll have a little fun and break the model applicant mold. <q>Nope,</q> you say cheerfully.\b
    The interviewer looks shocked and scandalized, and his expression alternates between horror and surprise, then compromises by settling into dignified disgust.\b
    You realize that this may have been a mistake. Better make something up real quick! <q>Haha, I\'m just joking, I\'m actually in...</q><.convstay>']

    ['You probably shouldn\'t be pushing your luck further. Nice try, buster. Nearly got yourself kicked out, there.']
;

++ SpecialTopic 'computer club' ['computing', 'computer', 'club']
    "Heh, you suck-up.\b
    <q>I'm in computer club,</q> you declare proudly."
;

++ SpecialTopic 'drama' ['acting', 'drama', 'theatre', 'theater']
    ""
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


