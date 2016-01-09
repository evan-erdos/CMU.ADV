/* Ben Scott * bescott@andrew.cmu.edu * 2015-12-30 * Dijkstra */

#include <adv3.h>
#include <en_us.h>
#include "macros.h"
#pragma newline_spacing(preserve)


/** `BasePathFinder` : **`object`**
 *
 * Basic pathfinder, implements Dijkstra's algorithm to find
 * the shortest path between nodes in a graph. Implementation
 * shouldn't make any assumptions about the nature of the
 * underlying graph; and inheritors must override a method to
 * provide a concrete graph implementation.
 **/
class BasePathFinder : object {


    /** `findPath()` : **`Node[]`**
     *
     * Find the best path between `fromNode` and `toNode`,
     * which are nodes in the graph. Returns a vector of graph
     * nodes, in order, yielding the shortest path between the
     * nodes. Note that `fromNode` and `toNode` are included in
     * the returned vector. If the two nodes aren't connected
     * in the graph, we'll simply return `null`.
     **/
    findPath(fromNode, toNode) {
        local i;
        local len;
        local cur;
        local list;
        local final;
        local toEntry;
        local ret;

        /* start with set containing the initial node */
        list = new Vector(32);
        list.append(new PathFinderNode(fromNode));

        /* For each node in the list, add all adjacent nodes to
         * the end of the list. Keep visiting new nodes until
         * everything has been visited once. Only add a node if
         * it's not already in the list to ensure that the loop
         * converges (since the size of the graph is finite). */
        for (i=1;i<=list.length();++i) {
            /* add each adjacent node to the working list */
            forEachAdjacent(list[i].graphNode,
                            new function(adj,dist) {
                /* add the adjacent node only if it's not
                 * already in the working list */
                if (list.indexWhich({x: x.graphNode==adj})==null)
                    list.append(new PathFinderNode(adj));
            });
        }

        /* if the destination isn't in the working list, then
         * there exists no path to it. */
        if (list.indexWhich({x: x.graphNode == toNode}) == null) return null;

        /* start with an empty list */
        final = new Vector(32);

        /* (node==node) => dist(node,node)==0 */
        cur = list[1];
        cur.bestDist = 0;
        cur.predNode = null;

        /* keep going while we have unresolved nodes */
        while (list.length()!=0) {
            local minIdx;
            local minDist;

            /* find the nearest node */
            minDist = null;
            minIdx = null;
            for (i=1,len=list.length();i<=len;++i) {
                /* store current nearest */
                cur = list[i];
                if (cur.bestDist != null
                    && (minDist == null || cur.bestDist < minDist)) {
                    /* this is the best so far */
                    minDist = cur.bestDist;
                    minIdx = i;
                }
            }

            /* move the neaest one to the seen list */
            cur = list[minIdx];
            final.append(cur = list[minIdx]);
            list.removeElementAt(minIdx);

            /* update the best distance for all nodes adjacent
             * to the one we just finished */
            forEachAdjacent(cur.graphNode, new function(adj, dist) {
                local newDist;
                local entry;

                /* Find the node of the adjacent room. If it
                 * doesn't exist, return. */
                entry = list.valWhich({x: x.graphNode==adj});
                if (entry==null) return;

                /* append the new distance to the adjacent room
                 * to the current room. */
                newDist = cur.bestDist + dist;

                /* null means no path has been found yet */
                if (entry.bestDist==null || newDist<entry.bestDist) {
                    entry.bestDist = newDist;
                    entry.predNode = cur;
                }
            });
        }

        /* Once the working list is empty, the list of nodes
         * between the start and end need be generated. Now the
         * nodes are iterated through in reverse order until a
         * null is found (the prior node is always null for the
         * starting node, so it acts as a sentinel. */
        toEntry = final.valWhich({x: x.graphNode == toNode});
        for (cur=toEntry,len=0;cur!=null;cur=cur.predNode,++len);
        /* create the vector that represents the path */
        ret = new Vector(len);

        /* Traverse again to fill in the vector. */
        for (cur=toEntry,i=len;cur!=null;cur=cur.predNode,--i)
            ret[i] = cur.graphNode;

        /* return the path */
        return ret;
    }


    /** `forEachAdjacent()` : **`function`**
     *
     * Iterates over each node adjacent to the given node in
     * the graph by invoking the given callback function for
     * each adjacent graph node. It takes two arguments: the
     * adjacent node, and the distance between them.
     *
     * - `require` : `weight(edge)>0 for all adjacent nodes`
     **/
    forEachAdjacent(node, func) { /* virtual */ }
}


/** `PathFinderNode` : **`class`**
 *
 * Encapsulates the node in the underlying graph, along with
 * additional information for the algorithm.
 **/
class PathFinderNode : object {
    construct(node) { graphNode = node; }
    graphNode = null; /* the underlying node */
    /* the best-path predecessor for this node */
    bestDist = null;
    predNode = null;
}


/** `roomPathFinder` : **`BasePathFinder`**
 *
 * A concrete implementation which finds a path between two
 * `Room`s. Traverses rooms based on any `RoomConnector`s which
 * may be present in the map. Not appropriate for all purposes,
 * as it doesn't account for `Actor` knowledge. This omniscient
 * implementation is only suitable in cases where the `Actor`'s
 * knowledge isn't relevant.
 **/
roomPathFinder : BasePathFinder {
    findPath(actor, fromLoc, toLoc) {
        actor_ = actor;
        /* return whatever the base implementation does */
        return inherited(fromLoc, toLoc);
    }

    forEachAdjacent(loc, func) {
        /* run through directions, add their destinations */
        foreach (local dir in Direction.allDirections) {
            local c;
            local dest;
            if ((c = loc.getTravelConnector(dir,actor_))!=null
            && (dest = getDestination(loc,dir,c))!=null
            && includeRoom(dest))
                (func)(dest, 1);
        }
    }


    /** `getDestination()` : **`int`**
     *
     * Get the adjacent location to the given one, to find a
     * path. By default, it returns the destination, but
     * inheritors might want to use other algorithms, e.g., if
     * an inheritor's goal is to make an NPC find its own path
     * then it should use the *apparent* destination, from the
     * NPC's perspective, rather than the actual one.
     **/
    getDestination(loc, dir, conn) {
        return conn.getDestination(loc, actor_); }


    /** `includeRoom()` : **`function`**
     *
     * Allows the graph to be filtered such that only a subset
     * of the map is included. All `Room`s are included by
     * default, but `Room`s which are not initially connected
     * to the starting location are not included.
     **/
    includeRoom(loc) { return true; }
    /* the actor who's finding the path */
    actor_ = null
}


/** `npcRoomPathFinder` : **`roomPathFinder`**
 *
 * An NPC Pathfinder which takes into account the "apparent"
 * goal, based on `Actor` knowledge.
 **/
npcRoomPathFinder : roomPathFinder {

    getDestination(loc, dir, conn) {
        return conn.getApparentDestination(loc, actor_); }
}

