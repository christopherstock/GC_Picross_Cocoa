/*  $Id:$
 *  =================================================================
 */
     
    #import "Picross.h"
    #import "PicrossView.h"
    #import "LibDebug.h"

    @implementation PicrossView

    PicrossView*        singletonMainView   = nil;

    - (id)initWithFrame : (NSRect) canvas 
    {
        [ LibDebug out : @"Welcome to the PICROSS project" ];

        //invoke super construct
        self = [ super initWithFrame : canvas ];
        
        if ( self ) 
        {
            //refrence singleton instance
            singletonMainView = self;

            //instanciate and init main-context
            singletonMainContext = [ Picross alloc ];
            [ singletonMainContext init : canvas ];            
        }
        return self;
    }

    - (void)drawRect : (NSRect) canvas 
    {
        [ singletonMainContext paint : canvas ];
    }

    - (void) keyDown : (NSEvent*) theEvent 
    {
        [ LibDebug out : @"Key pressed" ];
        
        [ [ singletonMainContext getKeys ] keyDown : theEvent ];
    }

    - (void) keyUp : (NSEvent*) theEvent 
    {
        [ LibDebug out : @"Key released" ];
        
        [ [ singletonMainContext getKeys ] keyUp : theEvent ];
    }
    
    - (void) mouseDown : (NSEvent*) theEvent
    {
        [ LibDebug out : (@"Mouse pressed") ];
    }

    - (void) mouseUp : (NSEvent*) theEvent
    {
        [ LibDebug out : (@"Mouse released") ];
    }

    - (BOOL) acceptsFirstResponder 
    {
        return YES;
    }

    @end
