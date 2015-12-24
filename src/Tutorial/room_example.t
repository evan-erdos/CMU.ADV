/* Ben Scott * bescott@andrew.cmu.edu * 2015-11-21 * Room Example */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"

/** `RoomExample` : **`Room`**
 *
 * This is a basic setup for a room. It isn't connected to
 * anything yet, as the directions have been commented out to
 * prevent it from screwing with the real rooms elsewhere in
 * the build.
 **/
room_example : Room

/** `name`
 *
 * Full title, this is printed at the top of the screen.
 **/
'Room Example'

/** `destName`
 *
 * What to print when the room is referred to from somewhere
 * else. The lister used when describing other rooms uses this
 * value implicitly.
 **/
'that room over there'

/** `desc`
 *
 * Main description of this `Room`.
 **/
"This is definitely a room, with all of the usual things that a room has, for sure, and it has things and stuff in it. " {


//    north = room_that_is_north_from_here; // north of here!
//    south = the_south;
//    se = another_room_southeast;
    down = weird_ladder; // down the hatch!
}

/** `weird_ladder` : **`SecretDoor`**
 *
 * This is an example of a nested object which uses the `+`
 * syntax to put this object in the room.
 **/
+ weird_ladder : Lockable, SecretDoor
'(metal) grate/grating/hatch' 'metal grating'
"A metal grating is set in the ground here, as well. " { isLocked = true; }



