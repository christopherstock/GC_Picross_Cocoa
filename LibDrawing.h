/*  $Id:$
 *  =================================================================
 */
     
    enum Anchor
    {
        EAnchorLeftTop      = 0,
        EAnchorLeftMiddle   = 1,
        EAnchorLeftBottom   = 2,
        EAnchorCenterTop    = 3,
        EAnchorCenterMiddle = 4,
        EAnchorCenterBottom = 5,
        EAnchorRightTop     = 6,
        EAnchorRightMiddle  = 7,
        EAnchorRightBottom  = 8,
    };
    
    enum Colors
    {
        EColorBlack         = 0xff000000,
        EColorWhite         = 0xffffffff,
        EColorRed           = 0xffff0000,
        EColorSynapsyBlue   = 0xff3a7ca9,
    };
     
    /********************************************************************
    *   Specifies 2D drawing functionality.
    *
    *   @version    1.0
    *   @author     Christopher Stock
    ********************************************************************/
    @interface LibDrawing : NSObject 
    {
    }

    /********************************************************************
    *   Draws a string on the specified location.
    *
    *   @param  str The string to draw.
    *   @param  x   The location x for the string to draw.
    *   @param  y   The location y for the string to draw.
    ********************************************************************/
    + (void) drawString : (NSString*)str, int x, int y, int colFill, int colStroke, int fontSize;

    /********************************************************************
    *   Draws an image on the specified location.
    *
    *   @param  img The image to draw.
    *   @param  x   The location x for the string to draw.
    *   @param  y   The location y for the string to draw.
    ********************************************************************/
    + (void) drawImage : (NSImage*)img : (float)x : (float)y : (int)ank : (float)alpha;

    /********************************************************************
    *   Draws a line between the specified points.
    *
    *   @param  col     The color to draw as an ARGB value.
    *   @param  x1      The location x of the 1st point.
    *   @param  y1      The location y of the 1st point.
    *   @param  x2      The location x of the 2nd point.
    *   @param  y2      The location y of the 2nd point.
    ********************************************************************/    
    + (void) drawLine : (int)col : (int)x1 : (int)y1 : (int)x2 : (int)y2;

    /********************************************************************
    *   Fills a rect on the screen.
    *
    *   @param  col     The color to draw as an ARGB value.
    *   @param  x       The location x for the rect to fill.
    *   @param  y       The location y for the rect to fill.
    *   @param  width   The width  for the rect to fill.
    *   @param  height  The height for the rect to fill.
    ********************************************************************/    
    + (void) fillRect : (int)col : (int)x : (int)y : (int)width : (int)height;

    + (NSImage*) rotateImage : (NSImage*)image angle : (int)alpha;

    @end
