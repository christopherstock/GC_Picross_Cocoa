/*  $Id:$
 *  =================================================================
 */

    #import "LibIO.h"

    @implementation LibIO

    + (NSImage*) loadImage : (NSString*)symbolName imgType:(NSString*)imgType
    {
        NSString* imageName = [[NSBundle mainBundle] pathForResource : symbolName ofType : imgType ];
        NSImage*  tempImage = [[NSImage alloc] initWithContentsOfFile : imageName ];
        
        return tempImage;
    }

    @end
