/*  $Id:$
 *  =================================================================
 */

    @interface LibSound : NSObject 
    {
    }

    + (NSSound*) playSound : (NSString*)fileName : (BOOL)loop;

    @end
