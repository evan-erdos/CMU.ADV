/* Jocelyn Huang * jocelynh@andrew.cmu.edu * 2015-11-24 * interviewer */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

warner_interviewer : Person 'interviewer' '<b>Harried Interviewer</b>' @interview_room
"He looks baffled at your presence but seems to be too confused about his own schedule to chase you out of the interview room. He's offered you an interview, so what are you waiting for?"
    isHim = true
    globalParamName = "interviewer"

    /* To be awarded at the completion of the interview */
    interview_achievement : Achievement {+3 "took an admissions interview as a student... oops."}
;

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

     <q>Great. As you know, admissions are very competitive, but students learn a lot through our vigorous program! Of course, I'll need to know if you've had any prior experience. Do you want to tell me about any of your extracurriculars?<.convnode extracurriculars></q>"
;

++ NoTopic, SuggestedNoTopic
    "<q>Oh, no, I'm just a fan of Cobot,</q> you say. <q>I think he's cute! And he carries candy sometimes, so I like to hang around.</q>\b

     The interviewer seems mildly amused by your response. He flounders for a bit, then apparently realizes that he still hasn't found out what you're interested in. <q>What school are you applying to, then? Or... wait, did you say you were going for CS?</q><.convstay>"
;

++ SpecialTopic 'CIT' ['cit', 'engineering', 'ece', 'meche', 'college of engineering']
    "You're in it for the engineering, of course! You love resistors, or bridges, or civil people or something. Or civil people on jammed bridges. <q></q>"
;

++ SpecialTopic 'Drama' ['drama', 'school of drama']
    "Okay, taking a quick break from narrating to say, <b>what are you doing in the CClub text adventure</b>? But. Anyway.\b
     <q>The gods have sent me yonder way, whenceforth I have taken upon me to apply to this divine school for its splendiferous Dramatization Program!</q> You have no idea if half of the things you've said are even words, and for some reason you appear to be holding a skull in your hand as you kneel to the interviewer. He seems impressed with your yowling, though.\b
     <q>Oh, what splendid acting! So you're a fan of the performing arts! What's your favorite play?</q><.convnode drama>"
;

++ SpecialTopic 'Tepper' ['tepper', 'business', 'socializing', 'tepper school of business', 'suit wearing']
    "Agh, how could he possibly think that you would willingly associate with those socially-blind androids?! <q>Ohh, nooo,</q> you quickly say, <q>I aspire to be an entrepreneur! I take my inspiration from the great Andrew Carnegie himself.</q>\b
    The interviewer nods sagely. <q>Ah, yes. Here to make... <i>connections</i>.</q> He coughs, then moves on. <q>Please, tell me about your socialization and the connections you've made through extracurriculars.</q><.convnode extracurriculars>"
;

++ SpecialTopic 'Dietrich' ['dietrich', 'humanities', 'school of arts and sciences']
    "What do they even do in there? You don't really know, but decide to take a potshot and claim you're applying here anyway. <q>Dietrich!</q> you announce in your most overenthusiastic voice. Hopefully, your faux-excitement will carry you through here.\b
    <q></q>" /***/
;

/*********************<CIT>*************************/

/********************<Drama>************************/
+ ConvNode 'drama'
;

++ DefaultAnyTopic
	"The interviewer seems dissatisfied with your response. <q>Did you mean <b>Pippin</b>?</q><.convstay>"
;

++ SpecialTopic 'say Pippin' ['Pippin']
	"<q>GREAT!</q> he says, a little bit too excitedly. You lean away slightly from flying spittle. <q>Yes. Anyway.</q> He coughs. <q>Back on (Tartan)Tra(c)k. Do you participate in any extracurricular activities?<.convnode extracurriculars></q>"
;

/*******************<Dietrich>***********************/

/**********************<MCS>*************************/

/*****************<Extracurriculars>*****************/
+ ConvNode 'extracurriculars'
;

++ SpecialTopic 'none' ['no', 'none', 'nothing', 'nope']
    "You think you'll have a little fun and break the model applicant mold. <q>Nope,</q> you say cheerfully.\b
    The interviewer looks shocked and scandalized."
;

me : Topic 'myself/me';