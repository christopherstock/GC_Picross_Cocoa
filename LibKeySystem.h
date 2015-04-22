/*  $Id:$
 *  =================================================================
 */

    enum Keycodes 
    {
        EKeycodeUp      = 126,
        EKeycodeDown    = 125,
        EKeycodeLeft    = 123,
        EKeycodeRight   = 124,
        EKeycodeEnter   = 36,
        EKeycodeSpace   = 49,
        EKeycodeEscape  = 53,
        EKeycodeM       = 46,
    };

    @class LibKey;

    @interface LibKeySystem : NSObject 
    {
        LibKey*         keyDown;
        LibKey*         keyUp;
        LibKey*         keyLeft;
        LibKey*         keyRight;
        LibKey*         keyEnter;
        LibKey*         keySpace;
        LibKey*         keyEscape;
        LibKey*         keyM;
    }

    - (void) init;

    - (void) keyDown : (NSEvent*) theEvent; 

    - (void) keyUp : (NSEvent*) theEvent; 

    - (LibKey*) getKeyDown;

    - (LibKey*) getKeyUp;

    - (LibKey*) getKeyLeft;

    - (LibKey*) getKeyRight;
    
    - (LibKey*) getKeyEnter;

    - (LibKey*) getKeySpace;

    - (LibKey*) getKeyEscape;

    - (LibKey*) getKeyM;

    - (void) releaseAllKeys;

    - (void) lowerAllKeyBlockers;

    @end
