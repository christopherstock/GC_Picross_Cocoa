/*  $Id:$
 *  =================================================================
 */

    /********************************************************************
    *   The main view extends NSView and overrides the functions
    *   for drawing and receiving key and mouse events.
    *
    *   @version    1.0
    *   @author     Christopher Stock
    ********************************************************************/
    @interface PicrossView : NSView
    {
    }

    /********************************************************************
    *   A reference to the singleton main view.
    ********************************************************************/
    extern      PicrossView*      singletonMainView;

    @end
