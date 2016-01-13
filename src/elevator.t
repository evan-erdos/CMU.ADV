/*
 * Copyright 2003, 2006 Michael J. Roberts
 *
 * Return to Ditch Day - elevator class.  This is a set of
 * classes for implementing a typical modern elevator.
 *
 * These classes are meant to be reusable in a range of games;
 * they're a little too specialized for the main system
 * library, but other authors might find them helpful in
 * creating their own elevators. Read the comments carefully,
 * since the various objects make a certain number of
 * assumptions about their location/contents relationships to
 * one another; you can override most of these assumptions with
 * methods near the start of each class, but the default
 * assumptions are probably suitable for many situations. To
 * improve playability, we by default travel between any pair
 * of floors, no matter how far apart, in a single turn. You
 * can override this to take one turn per floor, or any other
 * pace you like, but the standard pacing is probably the best
 * compromise between playability and realistic timing, at
 * least for most cases. There's still some feeling of a real
 * elevator's cadence, since it always takes an extra turn for
 * doors to close.  Also, since the elevator moves around in
 * the background when it has work to do, it'll take extra
 * time when it has extra stops to make; for example, if you
 * push all of the buttons and get out on the first stop, then
 * call the elevator, it'll take a while to get there because
 * it'll actually have to service all of those other stops.
 */

#include <adv3.h>
#include <en_us.h>


/** `Elevator` : **`object`**
 *
 * This is a mix-in class that should be combined with
 * **`Room`**s to create the elevator's interior. An
 * **`ElevatorInnerDoor`** must be put directly within
 * `this` to serve as the elevator door.
 *
 * - `doorOpenTime` : **`int`**
 *     the standard amount of time (in turns) to leave the
 *     doors open when responding to a call
 *
 * - `buttonContainer` : **`object`**
 *     The direct container for buttons of `this`. Override
 *     to create an intermediate object to hold the buttons.
 **/
class Elevator : object {
    doorOpenTime = 2;
    buttonContainer = (self);
    elevatorDaemonRunning = null;
    doorTimer = null;
    currentDir = 0;
    isInMotion = null;


    /** `continueElevatorMotion` : **`int`**
     *
     * Continue the elevator's motion. `curFloorNum` is the
     * current floor number, and `targetFloorNum` is the target
     * floor number. This method should move the elevator as
     * far as we can go in one turn, and return the *actual*
     * new floor number - this need not be the same as the
     * target floor, since the elevator can limit its pace as
     * it sees fit. For example, you could implement this
     * routine so that it moves the elevator only one floor per
     * turn. In addition to moving the elevator, this routine
     * should comment on any changes that occur in the course
     * of the travel. For example, if the elevator has a
     * display showing the current floor number, this routine
     * should comment on the change in the displayed floor
     * number. We don't assume a display by default, so we
     * don't say anything here. By default, we'll move the
     * elevator the entire distance to the new floor. Some
     * people might find it more realistic to move the elevator
     * one turn per floor, since then the time required in
     * turns would scale with the length of the journey; but I
     * like the instant travel for two reasons. First, it's
     * simply more playable; I think it's better in general not
     * to let reality trump playability for reality's sake
     * alone, and in this regard, gratuitous 'wait' commands
     * are as bad as gratuitous sleeping and eating. The only
     * reason I'd slow down the elevator is for the sake of the
     * game design; for example, this could be useful if you
     * have a timed puzzle that depends on visiting floors in
     * an optimized order. Second, even though one-floor-per-
     * turn seems superficially "realistic," I don't think it
     * actually is. Trying to tie 'turns' to any concrete
     * measure of real-world time almost always makes a game
     * less realistic, not more; to a player, different
     * commands ought to take radically different amounts of
     * time to be realistic. Game time is almost always better
     * handled as a "narrative" or "subjective" time, where
     * the amount of time that passes depends on the amount of
     * *interesting* stuff that happens, not on the number or
     * types of commands entered.
     **/
    continueElevatorMotion(curFloorNum, targetFloorNum) {
        return targetFloorNum; }


    /** `announceStart` : **`function`**
     *
     * Announce that we're starting to move.
     *
     * - `dir` : **`int`**
     *     direction of movement, 1:up, -1:down
     **/
    announceStart(dir) {
        "The elevator starts moving. "; }


    /** `announceStop` : **`function`**
     *
     * Announce that the elevator is stopping at a floor and
     * opening our doors.
     *
     * - `moving` : **`bool`**
     *     was the elevator moving before we stopped?
     *
     * - `dir` : **`int`**
     *     direction of movement, 1:up, -1:down, 0:open
     **/
    announceStop(moving, newDir) {
        "The elevator <<if (moving)>>stops, and the<<end>> doors slide open. "; }


    getElevatorDoor() {
        return contents.valWhich(
            {x: x.ofKind(ElevatorDoor)}); }


    /** `getButtonList()` : **`ElevatorButton[]`**
     *
     * returns all of the contained **`ElevatorButton`**s.
     **/
    getButtonList() {
        return buttonContainer.contents.subset(
            {x: x.ofKind(ElevatorButton)}); }


    getFloorNum() {
        return getElevatorDoor().otherSide.floorNum; }


    getFloorName() {
        return getNameForFloor(getFloorNum); }


    getNameForFloor(floor) {
        return getButtonList().valWhich(
            {x: x.floorNum==floor}).floorName; }


    /** `noteButtonLit` : **`function`**
     *
     * If the doors are open, speed up the close timer. In
     * real elevators, pushing a floor button tends to
     * close the doors more or less right away.
     **/
    noteButtonLit() {
        local door = getElevatorDoor();
        if (door.isOpen && doorTimer>1) doorTimer = 1;
        startElevatorDaemon();
    }

    extendDoorTimer() { doorTimer = doorOpenTime; }

    /** `name` : **`function`**
     *
     * note a call from a floor button. Find the floor button
     * corresponding to this floor, and sets the call for the
     * given direction.
     **/
    noteFloorCall(floor, dir, lit) {
        local btn;
        btn = getButtonList().valWhich(
            {x: x.floorNum==floor});
        if (dir==1) btn.calledGoingUp = lit;
        else btn.calledGoingDown = lit;
        startElevatorDaemon();
    }


    cancelCallButton(door, dir) {
        local btn;
        btn = door.otherSide.buttonContainer.contents.valWhich(
            {x: x.ofKind(ElevatorCallButton) && x.buttonDir==dir});
        btn.setFloorCall(null);
    }


    startElevatorDaemon() {
        if (elevatorDaemonRunning) return;
        new SenseDaemon(self,&elevatorDaemon,1,self,sight);
        elevatorDaemonRunning = true;
    }


    /** `elevatorDaemon()` : **`function`**
     *
     * The main elevator daemon.  We keep this running whenever
     * we have any pending work: specifically, our door is
     * open, or we have any active floor call pending. When we
     * have no work, we cancel the daemon.
     **/
    elevatorDaemon() {
        local door = getElevatorDoor();
        local lst;
        local len;
        local i;
        local btn;
        local lastCallBtn;
        local floor;
        local iter;

        floor = door.otherSide.floorNum;

        if (door.isOpen) {
            if (doorTimer--<=0) {
                door.makeOpen(null);
                "The elevator doors slide shut. ";
            } return;
        }

        lst = getButtonList.sort(SortAsc,
            {a, b: a.floorNum - b.floorNum});
        len = lst.length();

        for (iter=1;;++iter) {
            local newDir;
            if (lst.indexWhich({x: x.isCalling})==null) {
                eventManager.removeCurrentEvent();
                elevatorDaemonRunning = null;
                currentDir = 0;
                return;
            }

            if (currentDir==0) {
                btn = lst.valWhich(
                    {x: x.isCalling && x.floorNum!=floor});
                if (btn!=null)
                    currentDir = (btn.floorNum<floor?-1:1);
            }

            newDir = null;

            for (i=lst.indexWhich(
                    {x: x.floorNum==floor}),
                    lastCallBtn = null;
                    i>=1&&i<=len;
                    i+=currentDir) {
                btn = lst[i];

                if (iter==1 && btn.floorNum==floor && currentDir!=0) continue;

                if (currentDir >= 0 && btn.calledGoingUp) {
                    newDir = 1; break; }
                if (currentDir <= 0 && btn.calledGoingDown) {
                    newDir = -1; break; }
                if (btn.isLit) break;
                if (btn.calledGoingUp || btn.calledGoingDown)
                    lastCallBtn = btn;
                btn = null;
            }

            if (newDir==null
            && (btn!=null || lastCallBtn!=null)) {
                if (btn!=null) {
                    local c;
                    if (currentDir!=0) {
                        local target = btn.floorNum;

                        if (currentDir==1)
                            c = lst.indexWhich(
                                {x: x.floorNum > target && x.isCalling});
                        else c = lst.indexWhich(
                                {x: x.floorNum < target && x.isCalling});
                        newDir = (c!=null ? currentDir : 0);
                    } else newDir = 0;
                } else newDir = -currentDir;
            }

            if (btn==null) btn = lastCallBtn;
            if (btn!=null) {
                goTowardFloor(door, btn, newDir, lst);
                return;
            }

            currentDir = -currentDir;
            unlightAllButtons(lst);
        }
    }

    goTowardFloor(door, btn, answerDir, btnList) {
        local newFloorNum;
        if (btn.floorNum!=door.otherSide.floorNum) {
            if (!isInMotion) {
                announceStart(currentDir);
                isInMotion = true;
            }

            newFloorNum = continueElevatorMotion(
                door.otherSide.floorNum, btn.floorNum);
        } else newFloorNum = btn.floorNum;


        forEachInstance(ElevatorDoor, new function(obj) {
            if (obj.otherSide==door && obj.floorNum==newFloorNum) door.otherSide = obj; });

        if (newFloorNum==btn.floorNum) {
            announceStop(isInMotion, answerDir);
            isInMotion = null;
            btn.isLit = null;
            if (answerDir!=0)
                cancelCallButton(door, answerDir);

            if (answerDir!=currentDir) {
                currentDir = answerDir;
                unlightAllButtons(btnList);
            } door.makeOpen(true);
        }
    }

    unlightAllButtons(lst) {
        if (lst.indexWhich({x: x.isLit})!=null) {
            "All of the buttons go dark. ";
            lst.forEach({x: x.isLit = null});
        }
    }
}

class ElevatorDoor : Door
    /*
     *   Get our associated elevator room.  This is the object that
     *   contains the interior door of the elevator.  By default, this is
     *   simply the direct container of the other side of the door; you
     *   can override this if there's some other relationship to the
     *   elevator room.
     */
    getElevator() { return otherSide.location; }

    /*
     *   Get the direct container of our up/down call buttons.  By
     *   default, this is simply our direct location.  Override this if
     *   you have some other arrangement, such as an intermediate object
     *   that contains the buttons (a control panel, for example).
     */
    buttonContainer = (location)

    /* describe our buttons - look for our buttons in our container */
    buttonDesc()
    {
        local btns;

        /* scan our container's contents for our buttons */
        btns = buttonContainer.contents.subset(
            {x: x.ofKind(ElevatorCallButton)});

        /* if we have just one, say which kind; otherwise, say we have both */
        if (btns.length()==1)
            "Next to the doors is <<btns[1].aDesc>>. ";
        else if (btns.length()==2)
            "Next to the doors are <q>up</q> and <q>down</q> buttons. ";
    }

    /* start out closed by default */
    initiallyOpen = null

    /*
     *   we're only open if the master side is open AND we're the master
     *   side's other side (i.e., the elevator is at this floor)
     */
    isOpen = (inherited()
              && (masterObject==self || masterObject.otherSide==self))

    /* we can't manually open or close the doors */
    dobjFor(Open) { action() { "The elevator doors are automatic;
        you can't open them manually. "; } }
    dobjFor(Close) { action() { "The elevator doors open and close
        automatically. "; } }

    /*
     *   since we can't open the doors manually, don't make opening the
     *   doors a precondition of travel
     */
    getDoorOpenPreCond() { return null; }

    /* if we can't travel, it's because the doors are closed */
    cannotTravel() { "The elevator doors are closed. "; }

    /*
     *   Customize the message for remote opening and closing.  This is
     *   the message that will always be used for the outside doors (i.e.,
     *   the doors to the elevator on a floor outside the elevator),
     *   because the interior side of the door always controls the door.
     */
    noteRemoteOpen(stat)
    {
        /* note the elevator's direction */
        local dir = getElevator().currentDir;

        callWithSenseContext(self, sight,
                             {: announceRemoteOpen(stat, dir) });
    }

    /* announce that the doors are opening automatically */
    announceRemoteOpen(stat, dir)
    {
        "The elevator doors slide <<stat ? 'open' : 'shut'>>. ";
    }

    /* the floor number on which this door is located */
    floorNum = 0

    /* "get in elevator" is the same as "go through doors" */
    dobjFor(Board) asDobjFor(GoThrough)
;

/*
 *   Elevator call button.  This is a button positioned alongside an
 *   elevator door, outside the elevator, to summon the elevator to this
 *   floor.
 *
 *   You must locate these buttons in the same immediate location as the
 *   associated elevator door.  Other parts of the elevator will find
 *   these buttons by looking in the door's location.
 */
class ElevatorCallButton: Button, Fixture
    '(elevator) (lift) button*buttons' 'elevator button'
    "It's <<isLit ? 'lit' : 'unlit'>>. "

    dobjFor(Push)
    {
        action()
        {
            local door;

            /*
             *   If one of our doors is already open on this floor, simply
             *   extend its timer.  Otherwise, if we're not already lit,
             *   light up and notify the elevator of the call; otherwise,
             *   do nothing.
             */
            if ((door = getElevatorDoors().valWhich(
                {x: x.otherSide.otherSide==x && x.isOpen}))
               !=null
                && door.otherSide.getElevator.currentDir is in (0, buttonDir))
            {
                /* extend the timer on the inner door */
                door.otherSide.getElevator.extendDoorTimer();

                /* nothing really happens */
                "The button lights up momentarily and then goes out. ";
            }
            else if (!isLit)
            {
                /* light it up */
                "You tap the button, and it lights up. ";

                /* notify our elevator(s) */
                setFloorCall(true);
            }
            else
            {
                /*
                 *   we're already lit, and no elevator is here, so this
                 *   has no effect at all
                 */
                "You tap the button again, but it's already lit, so
                this has no obvious effect. ";
            }

        }
    }

    /* clear our floor call */
    setFloorCall(lit)
    {
        /* note our new 'lit' status */
        isLit = lit;

        /* notify each elevator in my list */
        foreach (local door in getElevatorDoors())
        {
            /* let this door's elevator know about the change */
            door.getElevator().noteFloorCall(door.floorNum, buttonDir, lit);
        }
    }

    /*
     *   Get my associated elevator door(s).  This returns a list, to
     *   allow for elevator lobbies where a single call button summons any
     *   of a bank of available elevators.  By default, we return a list
     *   of all of the ElevatorDoor objects in our direct location.
     */
    getElevatorDoors()
    {
        /* find the elevator door among our location's contents */
        return location.contents.subset({x: x.ofKind(ElevatorDoor)});
    }

    /* the direction of travel we request - 1 for up, -1 for down */
    buttonDir = null

    /* flag: we're currently lit */
    isLit = null
;

/* an "up" call button */
class ElevatorUpButton: ElevatorCallButton '"up" -' '<q>up</q> button'
    "It depicts an arrow pointing up. "
    aDesc = "an <q>up</q> button"
    buttonDir = 1
;

/* a "down" call button */
class ElevatorDownButton: ElevatorCallButton '"down" -' '<q>down</q> button'
    "It depicts an arrow pointing down. "
    buttonDir = -1
;

/* ------------------------------------------------------------------------ */
/*
 *   Elevator inner door - this is a subclass of the elevator door for use
 *   on the *inside* of an elevator.
 */
class ElevatorInnerDoor: ElevatorDoor
    /*
     *   Each instance must initialize otherSide to point to the outer
     *   door on the floor where the elevator starts.
     */
    otherSide = null

    /* our elevator - this is by default simply our location */
    getElevator = (location)

    /* open the door */
    makeOpen(flag)
    {
        local wasOpen = isOpen;
        local elev = getElevator;

        /* do the normal work */
        inherited(flag);

        /*
         *   if we just opened, set the elevator's door timer to its
         *   standard open timeout
         */
        if (!wasOpen && isOpen)
            elev.extendDoorTimer();
    }

    /*
     *   Because our destination changes a lot, make it not apparent what
     *   our destination is when our doors are closed.
     */
    getApparentDestination(loc, actor)
    {
        /*
         *   use the inherited apparent destination if we're open; when
         *   we're closed, our destination is not apparent at all, so
         *   simply return null
         */
        return isOpen ? inherited(loc, actor) : null;
    }

    /*
     *   Our 'otherSide' changes dynamically as we move between floors; we
     *   must initialize it explicitly in each instance to the starting
     *   floor.  The different floors will try to tell us about
     *   themselves, so ignore the initMasterObject() and just use our
     *   fixed initial value.
     */
    initMasterObject(other) { }
;

/*
 *   An elevator button.  This is for floor buttons with in the elevator.
 */
class ElevatorButton: Button, Fixture 'elevator lift button*buttons'
    /* button name - by default, this is just 'button' and the floor name */
    name = ('elevator button ' + floorName)
    theName = (name)
    aName = (name)

    /*
     *   The floor number we're associated with - this must be set for
     *   each button instance.  The floor numbers should always be
     *   contiguous integers ascending in order of the 'up' direction.
     *   Note that you can give your floors names different from the floor
     *   numbers; simply use floorName to give the floor its name.
     */
    floorNum = 0

    /*
     *   The name of the floor.  By default, this simply returns the floor
     *   number as a string.  This can be overridden if the floor names
     *   are different than their numbers; for example, you might want to
     *   use 'G' for the ground floor and 'B' for the basement.
     */
    floorName = (toString(floorNum))

    /*
     *   Our elevator room object - by default, this is simply our
     *   location.  Override this if the button has some other
     *   relationship to the room (for example, you'll need to override
     *   this if you create an intermediate container, such as a control
     *   panel object that contains the buttons).
     */
    getElevator = (location)

    /* flag: we're lit */
    isLit = null

    /*
     *   flags: this floor is on call from the floor itself (so we're not
     *   lit, but the elevator is on call for the floor), with a request
     *   to go up or down
     */
    calledGoingUp = null
    calledGoingDown = null

    /*
     *   are we calling the elevator to our floor, either by being lit
     *   inside the elevator or having an up or down button lit on our
     *   floor?
     */
    isCalling = (isLit || calledGoingUp || calledGoingDown)

    dobjFor(Push)
    {
        action()
        {
            if (isLit)
            {
                /* we're already lit, so just say so */
                "You tap on the button again, but it's already lit. ";

                /*
                 *   Let the elevator know a button is lit.  Do this even
                 *   though the button was already lit, as pressing a
                 *   button has the side effect of closing the doors
                 *   earlier.
                 */
                getElevator.noteButtonLit();
            }
            else if (getElevator.getFloorNum()==floorNum
                     && getElevator.getElevatorDoor().isOpen)
            {
                /*
                 *   the door is already open at our floor; just extend the
                 *   door-open timer
                 */
                getElevator.extendDoorTimer();

                /* the visible effects are minimal, though */
                "The button lights momentarily as you tap on it,
                and then goes out. ";
            }
            else
            {
                /* note that we're lit */
                isLit = true;

                /* mention it */
                "The button lights as you touch it. ";

                /* tell the elevator about the change */
                getElevator.noteButtonLit();
            }
        }
    }
;

/*
 *   It's often nice to use a collective group to field references to an
 *   unspecified button.  Elevator button groups tend to be large, so
 *   disambiguation questions involving them can get unwieldy; the
 *   collective object avoids that by using a single, unambiguous object
 *   to represent the whole collection when no particular button is called
 *   out by name.
 *
 *   Always put the group in the same location as the individual buttons;
 *   we'll look for our individual buttons among our direct container's
 *   contents.
 */
class ElevatorButtonGroup: CollectiveGroup, Fixture
    'elevator lift button*buttons' 'elevator buttons'

    /* list the list buttons */
    listLit()
    {
        local lst;

        /* get the list of lit call buttons */
        lst = location.contents.subset(
            {x: x.ofKind(ElevatorButton) && x.isLit});

        /* show the list */
        litLister.showList(null, null, lst, 0, 0, null, null);
    }

    /* a lister for the lit buttons */
    litLister: Lister {
        showListEmpty(pov, parent) { }
        showListPrefixWide(cnt, pov, parent)
            { "Button<<cnt==1 ? '' : 's'>> "; }
        showListSuffixWide(cnt, pov, parent)
            { " <<cnt==1 ? 'is' : 'are'>> lit. "; }

        isListed(obj) { return true; }
        showListItem(obj, options, pov, info) { say(obj.floorNum); }
    }

    /* take over all actions */
    isCollectiveAction(action, whichObj) { return true; }

    /* take over all singular and unspecified quantities */
    isCollectiveQuant(np, requiredNum) { return requiredNum is in (null, 1); }

    /* for Push, don't ask which button; just say they need to say */
    dobjFor(Push)
    {
        verify() { }
        action() { "You'll have to say which button you mean. "; }
    }
;
