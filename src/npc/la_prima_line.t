/* Jocelyn Huang * jocelynh@andrew.cmu.edu * 2016-01-27 * La Prima Line */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"
#pragma newline_spacing(preserve)

//****************<La Prima Line>**********************

la_prima_line : Person
'line/underclassman' 'La Prima line' @la_prima
"""
There's a line of people waiting sleepily for their coffee. An underclassman stands near the front, staring, uncomprehending, at homework.
""" {
	isPlural = true;
	globalParamName = "la prima line";
}

+ first_talking : InConversationState
	specialDesc = """
		The line contineues to mosey forward. The pudgy freshman holding his homework is looking at you.
		""";

++ first_ready : ConversationReadyState {
	isInitState = true;
	specialDesc =
		"""
		The line inches forward a bit at a glacial pace. A pudgy freshman wearing a hat that says "PIZZA" stands near the front of the line seems to be having difficulty with his homework.
		""";
}

+++ HelloTopic
	"""
	You decide to approach the underclassman at the front of the line.
	""";

// A project for a slightly later time.

//****************<La Prima Employee>**********************

la_prima_employee : Person
'la prima employee/cashier' '<b>La Prima Employee</b>' @la_prima
"""
A cheerful La Prima employee bustles around trilling out customers' orders to her underlings, who cramble to make coffee.
""" {
	isHer = true;
	globalParamName = "la prima employee";
}

+ melee : Thing
'melee (pastry)' 'melee'
"""
A delicious pocket of fluffy pastry and Nutella.
""";

+ frizz_coffee : Thing
'frizz/coffee/carbonated coffee' 'cup of frizz coffee'
"""
A cup of bizarre carbonated coffee that stocks rarely and sells out quickly.
""";

+ danish : Thing
'danish (pastry)' 'danish'
"""
A sweet pastry filled with delicious jam.
""";

+ la_prima_tea : Thing
'(la prima) tea' 'cup of La Prima tea'
"""
A piping hot cup of tea from La Prima. Be careful!
""";

+ biscotti : Thing
'biscotti' 'biscotti'
"""
Crunchy, chocolatey, and biscuity goodness. It's so biscuity that it's called biscotti.
""";

+ chocolate_scone : Thing
'(chocolate) scone' 'scone'
"""
A crumbly, bready scone oozing with melted chocolate.
""";