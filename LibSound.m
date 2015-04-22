/*  $Id:$
 *  =================================================================
 */

    #import "LibSound.h"
    
    @implementation LibSound

    + (NSSound*) playSound : (NSString*)fileName : (BOOL)loop
    {
        NSSound* sound = [ NSSound soundNamed : fileName ];
        [ sound play ]; 
        [ sound setLoops : loop ];
        return sound;
    }

    @end
