/* Ben Scott - bescott@andrew.cmu.edu - 2015-09-19 - CMU.ADV - macros */

#define null nil
#define print say
#define println(s) (say('\n'+(s)))
#define clear inputManager.getKey(null,null); cls()
#define next inputManager.getKey(null,null)

#define SUDO

Thing template 'name' @location? "desc";
Person template 'name' @location? "desc";
Room template 'roomName' "desc"? 'destName'? 'name'?;
