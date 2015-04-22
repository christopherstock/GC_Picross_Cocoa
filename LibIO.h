/*  $Id:$
 *  =================================================================
 */

    /********************************************************************
    *   Contains functionality for file i/o operations.
    *
    *   @version    1.0
    *   @author     Christopher Stock
    ********************************************************************/
    @interface LibIO : NSObject 
    {
    }

    /********************************************************************
    *   Loads and returns an image from the specified location.
    *
    *   @param  symbolName  The name of the image symbol.
    *   @param  imgType     The type of the image.
    *   @return             The loaded image.
    ********************************************************************/
    + (NSImage*) loadImage : (NSString*)symbolName imgType:(NSString*)imgType;

    @end
