/* Ben Scott - bescott@andrew.cmu.edu - 2015-09-19 - CMU.ADV - hints */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

TopHintMenu 'Hints';

+ HintMenu 'General Questions';

++ Goal 'How do I even' [
    'First text adventure, huh?',
    'Yeah, it figures. It might be helpful to read over the <b>Basic Commands</b> section.',
    'If you sort-of know what you\'re doing, maybe pour over <b>Command Aliases</b> for some game-specific commands you might not know.',
    'There aren\'t a lot of special formats here, but it is important to note that the bolded and caps-locked texts represent commands that you might enter.',
    'Additionally, the listed commands are just the most common usages: usually, if you\'re close enough, the parser will understand.'];

++ HintMenu 'Commands';

+++ Goal 'Basic Commands' [
    'Lots of things can be accomplished with a single word: you can <b>LOOK</b>, <b>WAIT</b>, <b>DANCE</b>, well, really, you can <i>try</i> to do anything, but you\'ll be able to look and wait, among other things.',
    'The most common commands are abbreviated to a single letter, e.g., <b>L</b> will look around the room. Instead of typing <b>GO NORTHWEST</b>, you could simply type <b>NW</b>.'];

+++ Goal 'Direct-Object Commands' [
    '<b>Direct-Object Commands</b> are quite common, given the number of verbs that are used with objects. One might reasonably expect to be able to <b>GET LAMP</b> or <b>READ THE BOOK</b>, and you usually can. A list of such verbs can be found elsewhere in this menu.' ];

+++ Goal 'Indirect-Object Commands' [
    'Even more complicated are <b>Indirect-Object Commands</b>, which allows you to use such lexical acrobatics as <b>UNLOCK THE DOOR WITH THEY KEY</b>, or <b>PUT THE LOTION IN THE BASKET</b>. In these ways, you can use objects on other objects, put such-n-such on top of this-or-that, etc.',
    'Additionally, you can string commands together with periods or writing <b>AND</b> between two other valid commands. A quick way to travel through places you\'ve already been would be to type <b>N. SW. NW. W</b>, if indeed you wanted to go north then southwest then northwest then west.'];

+++ Goal 'A Note About Grammar' [
    'That note being "we ain\'t got none." While you can certainly be grammatically correct if it pleases you, the program will automatically ignore language constructs it finds irrelelvant, e.g., "the" and "thank you", "lovely weather we\'re having.", etc., and in some cases, these pleasantries may actually confuse the poor thing. So, for everyone\'s sake, be terse. Type <b>GET LAMP</b> in the stead of things like <b>PLEASE MR. COMPUTER SIR WOULD YOU KINDLY GET ME THAT BRASS FIRE-CONTAINING CYLINDER? I FEAR THAT I WOULD BE SIMPLY <B>OVERCOME</B> WITH GRIEF IF I WERE TO BE EATEN BY ONE OF THOSE HORRENDOUS, HOW DID YOU CALL THEM? AH YES,\'GRUES\', HOW DREADFUL, JUST THE THOUGHT OF THEM! WE REALLY MUST GET OUT OF THE COLD, MR. VESPERS, IT CAN REALLY DO A NUMBER ON YOUR COMPLEXION.</b>"',
    'Moreover, sometimes the limitations of the technology make very specific syntaxes a requirement, rather than a guideline. Talking to people starts up a whole system of it\'s own, and you have to specifically initiate conversation by typing something like <b>TALK TO KAREN</b>. This is different from the way other text adventures work, so it might take some getting used to.',
    'While it may seem a bit clunky now, the syntax will grow on you, and before you know it you\'ll be <b>GET LAMP</b>-ing with the best of them.'];

+++ HintMenu 'List of Commands';

++++ Goal 'Command Aliases' [
    'Look Around: <b>L</b>',
    'Examine: <b>X</b>',
    'Wait: <b>Z</b>',
    'Tell About: <b>T</b>',
    'Inventory: <b>I</b>',
    'Quit Game: <b>Q</b>'];

++++ Goal 'Directional Commands' [
    'Go East: <b>E</b>',
    'Go Northeast: <b>NE</b>',
    'Go North: <b>N</b>',
    'Go Northwest: <b>NW</b>',
    'Go West: <b>W</b>',
    'Go Southwest: <b>SW</b>',
    'Go South: <b>S</b>',
    'Go Southeast: <b>SE</b>',
    'Go Down: <b>D</b>',
    'Go Up: <b>U</b>'];

+ HintMenu 'On Campus';

++ Goal -> (some.achievement) 'How do I anything?' [
    'Try the door.',
    'Try the knob, on the door.',
    'Hmm... that didn\'t work. You can\'t reach?',
    'Maybe you could find something to help you reach it.',
    'Perhaps the chair, from the kitchen.',
    'This is just temporary text.'];

++ noise_goal : Goal -> (some.achievement)
'What is that noise? It\'s driving me insane!' [
    'Well, you can\'t easily go outside to invesigate, but perhaps you can still figure this out.',
    'Perhaps you can see what\'s happening without going out.',
    'You got up high enough to mess with the door by pushing the chair.',
    'Try examining the window while on the chair.'];

+ HintMenu 'Hammerschlag';

++ Goal 'Where did your grades go?' [
    'Up the stairwell, to the north.', [fence_goal]];

+++ fence_goal : Goal -> (some.achievement)
'I can\'t use that gate! You saw how much trouble I had with that door!' [
    'Yeah, that was pretty rough. Maybe a full-frontial assault isn\'t your best play, here.',
    'Maybe there are other ways out.',
    'You can\'t go THROUGH, you can\'t go OVER, and you can\'t go AROUND.',
    'Perhaps going under is your best bet.',
    'DIG a hole along the fence somewhere, maybe you can wriggle through.'];

+ HintMenu '"Cheating"';

++ Goal 'Morning'
    ['go south',
    'push chair north',
    'push chair east',
    'get on chair',
    'examine window',
    'sleep'];

some : object {
    achievement : Achievement { +3 "Well, I mean, you got in, didn't you?" };
}

