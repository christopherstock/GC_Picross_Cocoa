/*  $Id:$
 *  =================================================================
 */
     
    #import "PicrossAppDelegate.h"

    @implementation PicrossAppDelegate

    @synthesize window;

    - (void) applicationDidFinishLaunching : (NSNotification*)aNotification 
    {
        //this is called AFTER PicrossView : initWithFrame ! do NOT init here!
    }

    - (BOOL) applicationShouldTerminateAfterLastWindowClosed : (NSApplication*)sender
    { 
        return YES;
    }

    @end
