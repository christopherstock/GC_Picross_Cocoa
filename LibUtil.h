/*  $Id:$
 *  =================================================================
 */

    /********************************************************************
    *   All simple directions in steps of 45°.
    ********************************************************************/
    enum Directions
    {
        EDirectionNorth     = 0,
        EDirectionNorthEast = 1,
        EDirectionEast      = 2,
        EDirectionSouthEast = 3,
        EDirectionSouth     = 4,
        EDirectionSouthWest = 5,
        EDirectionWest      = 6,
        EDirectionNorthWest = 7,
    };

    /********************************************************************
    *   Contains utility functions like type conversion or formatting.
    *
    *   @version    1.0
    *   @author     Christopher Stock
    ********************************************************************/
    @interface LibUtil : NSObject 
    {
    }

    /********************************************************************
    *   Converts an int to a String object.
    *
    *   @param      aInt    The int to convert to a String.
    *   @return             The given int as a String object.
    ********************************************************************/
    + (NSString*) intToString : (int)aInt;

    + (NSString*) longToString : (long long)aLong;

    + (NSColor*) intToColor : (int)aInt;

    @end
