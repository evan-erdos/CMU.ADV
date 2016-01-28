/* Jocelyn Huang * jocelynh@andrew.cmu.edu * 2016-01-27 * La Prima Line */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"
#pragma newline_spacing(preserve)

//****************<La Prima Line>**********************

la_prima_line : Person
'line' 'La Prima line' @la_prima
"""
It's a line of people waiting sleepily for their coffee. An underclassman stands near the front, staring, uncomprehending, at homework.
""" {
	isPlural = true;
	globalParamName = "la prima line";
}

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