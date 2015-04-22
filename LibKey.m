/*  $Id:$
 *  =================================================================
 */

    #import "LibKey.h"

    @implementation LibKey

    BOOL        isPressed       = NO;
    BOOL        needsRelease    = NO;
    int         blockTicks      = 0;

    - (void) press
    {
        isPressed = YES;
    }
    
    - (void) release
    {
        isPressed    = NO;
        needsRelease = NO;
        blockTicks   = 0;
    }
    
    - (BOOL) isKeyPressed
    {
        return isPressed;
    }
    
    - (void) setNeedsRelease
    {
        needsRelease = YES;
    }
    
    - (BOOL) isKeyIdle
    {
        return
        (
                ( needsRelease == NO )
            &&  ( blockTicks   == 0  )
        );
    }

    - (void) blockKey : (int)ticksToBlock
    {
        blockTicks = ticksToBlock;
    }

    - (void) lowerKeyBlocker
    {
        if ( blockTicks > 0 ) --blockTicks;
    }

    @end
