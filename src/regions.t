/* Ben Scott * bescott@andrew.cmu.edu * 2015-12-30 * Regions */

/* Ripped straight from Eric Eve's `adv3Lite` Library, found
 * [here](users.ox.ac.uk/~manc0049/TADSGuide/adv3Lite.htm). */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"


/** `Region` : **`class`**
 *
 * Represents an area containing rooms, or even other regions.
 *
 * - `regions` : **`Region[]`**
 *     A `Region` can optionally be a member of one or more
 *     other regions. This property stores the region or the
 *     list of other regions it contains.
 *
 * - `roomList` : **`Room[]`**
 *     A list of all the rooms in this region. This is built
 *     automatically at preinit and shouldn't be altered by the
 *     user/author.
 *
 * - `rooms` : **`Room[]`**
 *     A user-defined list of the rooms in this region. Upon
 *     `Preinit` this will be used along with the `regions`
 *     property of any rooms to build the local `roomList`.
 *
 * - `familiar` : **`bool`**
 *     Is the player char familiar with every room in this
 *     region? This should be set to `true` for a region whose
 *     geography the `user` starts out familiar with, e.g., the
 *     layout of their own house.
 *
 * - `extraScopeItems` : **`Item[]`**
 *     A list of items that should be added to the standard
 *     scope list for actions carried out in contained rooms.
 *
 * - `fastGoTo` : **`bool`**
 *     Should the `fastGoTo` option be used in this `Region`,
 *    (i.e. traveling from one `Room` in the region to another
 *    is all done in one turn without the need for CONTINUE,
 *    even if several steps are involved)? Note that the value
 *    of this setting has no effect if `gameMain.fastGoTo` is
 *    `true`, since then the `fastGoTo` setting is always on.
 *
 **/
class Region : object {
    regions = null;
    roomList = null;
    rooms = null;
    familiar = null;
    fastGoTo = null;
    extraScopeItems = [];


    /** `isIn()` : **`bool`**
     *
     * A Room can't be in another Room or a Thing, but it can
     * notionally be in a Region, so we check to see if we're
     * in the list of our regions.
     **/
    isIn(region) {
        return valToList(regions).indexWhich(
            {x: x.isOrIsIn(region)}) != null; }


    /** `isOrIsIn()` : **`bool`**
     *
     * Is this `Region` either itself a region or contained
     * by another `Region`?
     **/
    isOrIsIn(region) {
        return region==self || isIn(region); }


    /** `allRegions()` : **`Region[]`**
     *
     * A list of all regions this `Region` is contained by; in
     * addition to any regions this `Region` is directly in.
     * This will include all regions it's indirectly in, also.
     * for each region which directly contains this one, all
     * of its regions are appended.
     **/
    allRegions() {
        local thisRegions = new Vector(valToList(regions));
        foreach(local reg in valToList(regions))
            thisRegions.appendUnique(reg.allRegions);
        return thisRegions.toList();
    }


    /** `makeRegionLists()` : **`function`**
     *
     * Build the list of `Region`s in all the rooms in this
     * `Region` by going through every `Room` defined in
     * `roomList` and adding this to its list of regions. Note
     * that this is provided as an alternative way to define
     * what rooms start out in which regions.
     **/
    makeRegionLists() {
        if (rooms==null) return;
        foreach(local r in rooms)
            r.regions = valToList(r.regions)
                .appendUnique([self]);
    }


    /** `setFamiliarRooms()` : **`function`**
     *
     * Go through all the `Room`s in this object, setting them
     * to familiar if the region is familiar.
     **/
    setFamiliarRooms() {
        if(!familiar) return;
        foreach(local rm in valToList(roomList))
            rm.familiar = true;
    }


    /** `addToContents()` : **`function`**
     *
     * To add an object to our contents we need to add it to
     * the contents of every room in this region. If the
     * optional `vec` parameter is supplied, it must be a
     * vector. The rooms will then be added to it as well. The
     * `vec` parameter is primarily used by `MultiLoc`.
     **/
    addToContents(obj, vec?) {
        foreach(local cur in roomList)
            cur.addToContents(obj,vec); }


    /** `removeFromContents()` : **`function`**
     *
     * To remove an object from our contents we need to remove
     * it from the contents of every room in the region. If the
     * optional vec parameter is supplied it must be a vector;
     * the rooms will then be removed from the vector as well.
     **/
    removeFromContents(obj, vec?) {
        foreach(local cur in roomList)
            cur.removeFromContents(obj,vec); }


    /** `addToRoomList()` : **`function`**
     *
     * Add an additional `Room` (passed as the `rm` parameter)
     * to our list. This is intended for internal library use
     * at `PreInit` only.
     **/
    addToRoomList(rm) {
        roomList = nilToList(roomList).appendUnique([rm]);
        foreach(local cur in valToList(regions))
            cur.addToRoomList(rm);
    }


    /** `addExtraScopeItems()` : **`function`**
     *
     * Put extra items in scope when action is carried out in
     * any room in this region.
     **/
    addExtraScopeItems(action) {
        action.scopeList =
            action.scopeList.appendUnique(
                valToList(extraScopeItems));
        foreach(local reg in valToList(regions))
            reg.addExtraScopeItems(action);
    }


    /** `travelerEntering()` : **`event`**
     *
     * This is invoked when `traveler` is about to enter this
     * region from `origin` (the room traveled from).
     *
     **/
    travelerEntering(traveler, origin) { /* virtual */ }


    /** `travelerLeaving()` : **`event`**
     *
     * This event is invoked when `traveler` is about to leave
     * this region and go to `dest` (the destination room).
     **/
    travelerLeaving(traveler, dest) { /* virtual */ }


    /** `notifyBefore()` : **`event`**
     *
     * Invoked before notifications in the region.
     **/
    notifyBefore() {
        regionBeforeAction();
        foreach(local reg in valToList(regions))
            reg.notifyBefore();
    }


    /** `notifyAfter()` : **`event`**
     *
     * see `notifyBefore()`.
     **/
    notifyAfter() {
        regionAfterAction();
        foreach(local reg in valToList(regions))
            reg.notifyAfter();
    }


    /** `regionBeforeAction()` : **`event`**
     *
     * Invoked before actions taken in the region.
     **/
    regionBeforeAction() { /* virtual */ }


    /** `regionAfterAction()` : **`event`**
     *
     * see `regionBeforeAction()`.
     **/
    regionAfterAction() { /* virtual */ }


    /** `regionBeforeTravel()` : **`event`**
     *
     * Invoked before travel is undertaken in the region.
     **/
    regionBeforeTravel(traveler, connector) { /* virtual */ }


    /** `regionAfterTravel()` : **`event`**
     *
     * see `regionBeforeTravel()`.
     **/
    regionAfterTravel(traveler, connector) { /* virtual */ }


    /** `moveMLIntoAdd()` : **`function`**
     *
     * Move `ml` into this by moving it into all rooms.
     *
     * - `ml` : **`MultiLoc`**
     *     the object to be added to all contained `Room`s.
     **/
    moveMLIntoAdd(ml) {
        roomList.forEach({r: ml.moveIntoAdd(r)}); }


    /** `moveMLOutOf()` : **`function`**
     *
     * see `moveMLIntoAdd()`.
     **/
    moveMLOutOf(ml) {
        roomList.forEach({r: ml.moveOutOf(r)}); }
}


/** `regionPreinit` : **`PreinitObject`**
 *
 * Go through each room and add it to every regions it's in
 * (directly or indirectly). Then if the region is familiar,
 * mark all its rooms as familiar.
 **/
regionPreinit : PreinitObject {
    execute() {
        forEachInstance(Region, { r: r.makeRegionLists });
        forEachInstance(Room, { r: r.addToRegions() });
        forEachInstance(Region, { r: r.setFamiliarRooms() });
    }
}


