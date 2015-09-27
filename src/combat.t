/* Ben Scott - bescott@andrew.cmu.edu - 2015-09-19 - CMU.ADV - combat */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

combat : object {

    cmp_hit(p0,p1) { return (p0.swing>p1.dodge)?(1):(0); }

    attack (person0,person1?) {
        if (!person1) {
            person1 = person0;
            person0 = user;
        } person1.Harm(cmp_hit(person0,person1)*person0.attackDamage());
    }
}
