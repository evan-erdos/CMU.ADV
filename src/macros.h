/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-19 * Macros */


#ifndef MACROS_H
#define MACROS_H


/** `null` : **`macro`**
 *
 * Because we ain't no Lispers here
 **/
#define null nil


/** `print()` : **`macro`**
 *
 * Make programmers feel at home
 **/
#define print say


/** `println()` : **`macro`**
 *
 * Same as print, adds a newline
 **/
#define println(s) (say('\n'+(s)))


/** `clear` : **`macro`**
 *
 * Clears the screen after waiting for any user input. These
 * enforce good practices, and also simplify code a bit. There
 * are web / otherwise more generally safe methods of clearing
 * and getting input, waiting for input, etc. Should not be
 * used in single-statements, as this is not one statement.
 **/
#define clear inputManager.getKey(null,null); cls()


/** `next` : **`macro`**
 *
 * Waits for the user to press any key before continuing to
 * print text to the output.
 **/
#define next inputManager.getKey(null,null)


/** `ConvNode` : **`template`**
 *
 * Allows the `@location` to be specified in the template, as
 * it cannot otherwise be separated from its `ActorState` in
 * the source code.
 **/
//ConvNode template 'name' @location;


/** `ActorState` : **`template`**
 *
 * Allows the `stateDesc` to be specified in the template.
 **/
ActorState template @location? "stateDesc"?;


/** `Area` : **`template`**
 *
 * Uses custom parameters under the hood to allow the class to
 * insert shared data into **`AreaRoom`**s.
 **/
Area template 'areaName' 'destName'? [eventList]? "sharedDesc"?;


/** `AreaRoom` : **`template`**
 *
 * Uses custom parameters under the hood to allow the class to
 * insert shared data into **`AreaRoom`**s.
 **/
AreaRoom template -> masterArea 'areaRoomName' "areaDesc"?;


#endif /* MACROS_H */

