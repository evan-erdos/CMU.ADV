/* Ben Scott - bescott@andrew.cmu.edu - 2015-09-19 - CMU.ADV - about */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

versionInfo : GameID {
	name = 'CMU.ADV';
	byline = 'by Ben Scott';
	originalbyline = '<by Galloway & Kuehner & Pawlinger>';
	authorEmail = 'bescott@andrew.cmu.edu';
	genre = 'An adventure...';
	version = 'v2.0.1';
	firstPublished = '1986 (2015)';
	IFID = 'TADS3CMU-ADV3-77C6-042E-278CEDED4BDC';

	showAbout() {
		"\b<center><b><u><<versionInfo.name.toUpper()>></u></b>
		\b<<versionInfo.byline>>, <<versionInfo.authorEmail>>
		\boriginally <<versionInfo.originalbyline>>
		\nVersion <<versionInfo.version>>, <<versionInfo.firstPublished>>
		\n<<versionInfo.genre>></center>\b";
	} /* showAbout */
} /* versionInfo */

