/*  $Id:$
 *  =================================================================
 */

    @interface LibKey : NSObject 
    {
        BOOL        isPressed;
        BOOL        needsRelease;
        int         blockTicks;
    }

    - (void) press;
    
    - (void) release;
    
    - (BOOL) isKeyPressed;
    
    - (void) setNeedsRelease;
    
    - (BOOL) isKeyIdle;

    - (void) blockKey : (int)ticksToBlock;
    
    - (void) lowerKeyBlocker;

    @end
