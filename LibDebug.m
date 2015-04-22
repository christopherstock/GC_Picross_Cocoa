/*  $Id:$
 *  =================================================================
 */

    #import "LibDebug.h"

    @implementation LibDebug

    + (void) out : (NSString*)msg
    {
        NSLog( @"%@", msg );
    }

    @end
