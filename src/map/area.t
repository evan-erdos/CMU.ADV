/* Ben Scott * bescott@andrew.cmu.edu * 2016-01-10 * Areas */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"
#pragma newline_spacing(preserve)


/** `Area` : **`ShuffledEventList`**
 *
 * A class to manage large groups of rooms which all share
 * certain properties, such as their description, or the
 * atmospheric events.
 *
 * - `areaName` : **`string`**
 *     The name to be applied to all nested **`AreaRoom`**s
 *
 * - `sharedDesc` : **`string`**
 *     A description of the area itself, added to the start of
 *     the normal room's `desc`.
 *
 * - `eventList` : **`string[]`**
 *     This is the inherited list of events, defined explicitly
 *     to avoid a null reference when an **`Area`** does not
 *     define any events in its definition.
 **/
class Area : ShuffledEventList {
    areaName = 'Area';
    sharedDesc = "";
    eventList = [''];
}


/** `AreaRoom` : **`Room`**
 *
 * This class applies the effecs of `masterArea` to itself.
 *
 * - `areaRoomName` : **`string`**
 *     this is the specific name of the room to be used
 *
 * - `masterArea` : **`Area`**
 *     an **`Area`** instance to use as a template.
 **/
class AreaRoom : Room {
    areaRoomName = '';
    masterArea = null;
    areaDesc = "";
    name = '<<masterArea.areaName>> (<<areaRoomName>>)';
    desc =
        """
        <<masterArea.sharedDesc>>
        <br>
        <<areaDesc>>
        """;

    specialDesc { masterArea.doScript(); }
}
