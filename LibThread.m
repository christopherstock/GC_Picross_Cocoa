/*  $Id:$
 *  =================================================================
 */

    //TODO prune these - init with references / interface ?
    #import "PicrossView.h"
    #import "Picross.h"

    #import "LibDebug.h"
    #import "LibThread.h"
    
    @implementation LibThread

    //TODO constructor with callback and delay!

    - (void) start
    {
        [ LibDebug out : @"Thread START" ];
        [ NSThread detachNewThreadSelector : @selector (run) toTarget : self withObject : nil ];
    }

    - (void) run
    {
        [ LibDebug out : @"Thread RUN" ];
        
        //start neverending loop
        while ( true )
        {
            //[ LibDebug out : @"Thread RUNNING" ];

            //handle keys
            [ singletonMainContext handleKeys ];

            //call onRun
            [ singletonMainContext run ];
        
            //repaint
            [ singletonMainContext repaint ];

            //show system dialogs
            [ singletonMainContext showSystemDialogs ];
            
            //delay
            [ NSThread sleepForTimeInterval : 0.010f ];
        }
    }

    @end
