/* Ben Scott - bescott@andrew.cmu.edu - 2015-09-20 - CMU.ADV - officer */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

cmu_officer : Readable, Person 'police/officer' 'Cmu Campus Officer'  @the_cut
"This cop is mean and ugly; he's the Clint Eastwood of the academic world. You'd better not mess with him." {
	specialDesc = "A campus police officer is here, eyeing you suspiciously.";
	readDesc = "The cop has <b>mean<\b> written all over him.";
}