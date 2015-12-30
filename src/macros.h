/* Ben Scott * bescott@andrew.cmu.edu * 2015-09-19 * Macros */


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
 * and getting input, waiting for input, etc.
 **/
#define clear inputManager.getKey(null,null); cls()


/** `clear` : **`macro`**
 *
 * Waits for the user to press any key before continuing to
 * print text to the output.
 **/
#define next inputManager.getKey(null,null)


/** `Thing` : **`template`**
 *
 * Reorganizes the usual `Thing` `template`
 **/
Thing template 'name' @location? "desc";


/** `Person` : **`template`**
 *
 * Reorganizes the usual `Person` `template`
 **/
Person template 'name' @location? "desc";


/** `Room` : **`template`**
 *
 * This alters the `Room` `template` to not use the positional
 * name, e.g., what prints when it says "east, to the room".
 **/
Room template 'roomName' "desc"? 'destName'? 'name'?;


