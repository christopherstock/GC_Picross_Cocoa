/*  $Id:$
 *  =================================================================
 */

    #import "LibUtil.h"

    @implementation LibUtil

    + (NSString*) intToString : (int)aInt
    {
        NSString* ret = [ NSString stringWithFormat : @"%d", aInt ];            
        return ret;
    }
    
    + (NSString*) longToString : (long long)aLong
    {
        NSString* ret = [ NSString stringWithFormat : @"%qi", aLong ];            
        return ret;
    }

    + (NSColor*) intToColor : (int)aInt
    {
        float a = ( ( aInt >> 24 ) & 0xff ) / 256.0f;
        float r = ( ( aInt >> 16 ) & 0xff ) / 256.0f;
        float g = ( ( aInt >> 8  ) & 0xff ) / 256.0f;
        float b = ( ( aInt >> 0  ) & 0xff ) / 256.0f;

        NSColor* col = [ NSColor colorWithCalibratedRed: r green : g blue : b alpha : a ];

        return col;
    }

    @end

/*
        //create test level data
        levelData = 
        [
            [
                  [ NSArray alloc ] initWithObjects: 
                [ [ [ NSArray alloc ] initWithObjects: [ NSNumber numberWithInt : ETileTypeFullClosedUnmarked ], [ NSNumber numberWithInt : ETileTypeFullClosedUnmarked ], [ NSNumber numberWithInt : ETileTypeFullClosedUnmarked ], [ NSNumber numberWithInt : ETileTypeFullClosedUnmarked ], [ NSNumber numberWithInt : ETileTypeFullClosedUnmarked ], nil ] mutableCopy ],
                [ [ [ NSArray alloc ] initWithObjects: [ NSNumber numberWithInt : ETileTypeFullClosedUnmarked ], [ NSNumber numberWithInt : ETileTypeEmptyUnmarked      ], [ NSNumber numberWithInt : ETileTypeEmptyUnmarked      ], [ NSNumber numberWithInt : ETileTypeEmptyUnmarked      ], [ NSNumber numberWithInt : ETileTypeEmptyUnmarked      ], nil ] mutableCopy ],
                [ [ [ NSArray alloc ] initWithObjects: [ NSNumber numberWithInt : ETileTypeFullClosedUnmarked ], [ NSNumber numberWithInt : ETileTypeFullClosedUnmarked ], [ NSNumber numberWithInt : ETileTypeFullClosedUnmarked ], [ NSNumber numberWithInt : ETileTypeFullClosedUnmarked ], [ NSNumber numberWithInt : ETileTypeEmptyUnmarked      ], nil ] mutableCopy ],
                [ [ [ NSArray alloc ] initWithObjects: [ NSNumber numberWithInt : ETileTypeFullClosedUnmarked ], [ NSNumber numberWithInt : ETileTypeEmptyUnmarked      ], [ NSNumber numberWithInt : ETileTypeEmptyUnmarked      ], [ NSNumber numberWithInt : ETileTypeEmptyUnmarked      ], [ NSNumber numberWithInt : ETileTypeEmptyUnmarked      ], nil ] mutableCopy ],
                [ [ [ NSArray alloc ] initWithObjects: [ NSNumber numberWithInt : ETileTypeFullClosedUnmarked ], [ NSNumber numberWithInt : ETileTypeEmptyUnmarked      ], [ NSNumber numberWithInt : ETileTypeEmptyUnmarked      ], [ NSNumber numberWithInt : ETileTypeEmptyUnmarked      ], [ NSNumber numberWithInt : ETileTypeEmptyUnmarked      ], nil ] mutableCopy ],
                nil 
            ] 
            mutableCopy
        ];
*/
