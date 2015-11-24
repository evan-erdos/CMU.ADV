/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-20 * people */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

/* I've added this file as a kind of tutorial, for those who'd
 * like to become rich and famous, (i.e., people who want to be
 * in the game, but aren't hacking the mainframe enough to have
 * added themselves in already).
 *
 * You can add yourself in as a person, put something somewhere
 * on campus, &/| add your dorm room. There are no rules, aside
 * from not breaking anything / adding comments that say things
 * like, "THE NEXT INSTANCE OF PERSON DEFINED BELOW THIS POINT
 * IS A LITTLE BIIIITTTCCCCHHHHH!! HAHAA!! BUSH-REAGAN 1984!!!"
 * I trust you people. */

/* Humans of CMU something something mumble hipster */

/* object definition (don't objectify me!)
 * but still, I'm an instance of the Person class */
ben_scott : Person
/* I'm using the actor template, so these are the vocabWords */
'ben/scott/bescott/ben scott/cool kid'
/* similar story for the name and location. It's s&p to use the
 * @location syntax instead of the + notation for people and
 * items which have a tendency to move about */
'<b>Ben Scott</b>' @ghc_9_window
/* this is the explicit description, which is run when the user
 * looks directly at me, or examines me */
"He wears an obnoxiously neon shirt, and looks at you expectantly when you approach him. He knows that he's better than you, but he's frankly too kind to say so. Even if he did, you'd probably agree: He's pretty clever. " {
    isBetterThanYou = true; // you can add properties to anything like this
    initSpecialDesc { // special message, runs when user !ben_scott.seen
        isInInitState = null; // set to null once we've run
        user.name = user.name.toUpper(); // name trick
        achievement.awardPointsOnce(); // award points
        "Ben Scott is standing here. He turns to you and says \"<b>So</b>, full disclosure here: I lost my script. Yeah, they didn't tell me what to say here, so, eh... Hi? How are you...\" he squints a bit, and looks at your chest, where, all of a sudden, a nametag has appeared! \"<<user.name.toLower()>>? So, eh, you're... not a big fan of capital letters then, huh?\" Sure enough, you look down again and it's written differently! Your name is in all caps now. <<user.engender('What a guy.','You just can\'t help but think how dreamy he is.')>>"; }
    specialDesc { ben_scott_list.doScript(); } // prints with room
    /* This is a template also. This is a large number of points. */
    achievement : Achievement { +64 "finding the infamous Ben Scott. " }
}

/* Shuffled event lists are pretty useful, it iterates through
 * the first list in the template in order, and then it runs
 * any of the elements in the second list chaotically, i.e., /c
 * no element played twice in a row */
ben_scott_list : ShuffledEventList
['He seats himself in the weird chair, but just as soon as he leans into his computer, he leans back out again, and puts his feet up. You glance at his screen, and you can tell that he\'s rewritten his entire kernel from memory or something I mean, I dunno, does that sound like an impressive thing? Asking for a friend.\"<b>cd ../;2D;2D;2D;2C</b>whoops<b>:quit:q</b>how do i...<b>C-c C-c is undefined</b>come on<b>C-x C-c</b>',
/* this is actually a short anonymous function, it prints the
 * string and awards points for the button puzzle */
{: "He just starts speaking to you out of nowhere. \"I once killed a man in the desert, just because I wanted to see if it would inspire me artistically. It didn't. Do you know the elevator trick? That's how I got here. You take the bigger elevator down to the first floor, and when the door opens, you can reach outside to a button on the frame to your left, and then get to any floor you want! I think it's pretty neat. Do you like coffeecake? I don't know how I feel about it, really...\" You stop listening.",
    ghc_button.achievement.awardPointsOnce()} ]
['He gets up to strech, and looks out the window. It is an exceptional view. ',
 'His titanium cup is full of coffee again. You didn\'t notice him leave. ',
 'He types something, giggles to himself, but then instantly returns to looking stoic and stately when he realizes you\'re still here. '];

/*****************************/

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
     <q>He\'s that robot that rolls around the Computer Science program, right? When I come for... events, I sometimes see him mapping carrying something on an errand.</q>\b
     The interviewer nods, seemingly impressed by your knowledge of GHC happenings. <q>I assume you\'re applying to our School of Computer Science, then?</q> <.convnode major>"
;

+ ConvNode 'major'
;

++ DefaultAnyTopic
    "Should you tell him you're applying to SCS? <.convstay>"
;

++ YesTopic, SuggestedYesTopic
    /* I'm not biased, nope not at all --JH */
    "Of course you are! CS is only the absolute coolest major there is. You enthusiastically tell him, <q>I love computer science! I've been in love with Graph Theory since I was a toddler and my mom told me to find the nearest shopping cart. After implementing a quick shortest path algorithm in my head (Dijkstra for efficient parallelization, of course), I was absolutely smitten.</q>"
;

++ NoTopic, SuggestedNoTopic
    "<q>Oh, no, I'm just a fan of Cobot,</q> you say. <q>I think he's cute! And he carries candy sometimes, so I like to hang around.</q>\b

     The interviewer seems mildly amused by your response. He flounders for a bit, then apparently realizes that he still hasn't found out what you're interested in. <q>What school are you applying to, then?</q>"
;

me : Topic 'myself/me';

/*****************************/

// Eventually she'll want those student tears.
sad_251_ta : Person 'ta/teaching assistant/sad ta' '<b>Sad TA</b>' @ghc_citadel_commons
"A dejected-looking TA wearing her 15-251 sweatshirt sits mournfully at an overcrowded table. Everyone seems to be ignoring her." {
    isHer = true;
}