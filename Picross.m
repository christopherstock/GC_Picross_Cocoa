/*  $Id:$
 *  =================================================================
 */

    #import "Picross.h"
    #import "PicrossGame.h"
    #import "PicrossResources.h"
    #import "PicrossSettings.h"
    #import "PicrossState.h"
    #import "PicrossView.h"
    #import "LibDebug.h"
    #import "LibDialog.h"
    #import "LibKey.h"
    #import "LibKeySystem.h"
    #import "LibSound.h"
    #import "LibThread.h"

    @implementation Picross

    float               canvas_width            = 0.0f;
    float               canvas_height           = 0.0f;

    NSSound*            soundBg                 = nil;
    BOOL                soundBgPlays            = YES;

    BOOL                enableSounds            = YES;

    LibKeySystem*       keys                    = nil;
    PicrossResources*   resources               = nil;
    PicrossState*       state                   = nil;
    LibThread*          thread                  = nil;
    
    BOOL                showDialogWon           = NO;
    BOOL                showDialogLost          = NO;
    BOOL                showDialogPaws          = NO;

    Picross*            singletonMainContext    = nil;

    - (void) init : (NSRect) canvas 
    {
        [ LibDebug out : @"INIT MAIN CONTEXT" ];
        
        //assign dimensions
        canvas_width  = canvas.size.width;
        canvas_height = canvas.size.height;
                
        //enable sounds by default
        enableSounds = YES;
        
        //dialogs
        showDialogWon  = NO;
        showDialogLost = NO;
        showDialogPaws = NO;
                
        //init key, resources and state system
        keys        = [ LibKeySystem     alloc ];
        resources   = [ PicrossResources alloc ];
        state       = [ PicrossState     alloc ];
        thread      = [ LibThread        alloc ];        
        
        //init key system
        [ keys init ];
        
        //load images
        [ resources loadImages ];
        
        //init state system
        [ state init : canvas ];

        //init and play bg sound
        soundBg      = [ LibSound playSound : @"bg.mp3" : YES ];
        soundBgPlays = YES;
        
        //start main thread
        thread.start;
    }
    
    - (void) paint : (NSRect) canvas
    {
        //draw state
        [ state paint : canvas ];
    }

    - (void) handleKeys
    {
        //[ LibDebug out : @"context handleKeys" ];
    
        //let the state handle the keys
        [ state handleKeys ];
    
    }
    
    - (void) run
    {
        //[ LibDebug out : @"context onRun" ];
    
        //tick current state
        [ state run ];
    
    }

    - (void) repaint
    {
        [ singletonMainView setNeedsDisplay : YES ];
    }
    
    - (int) getCanvasWidth
    {
        return (int)canvas_width;
    }

    - (int) getCanvasHeight
    {
        return (int)canvas_height;
    }
    
    - (PicrossResources*) getResources
    {
        return resources;
    }

    - (PicrossState*) getState
    {
        return state;
    }
    
    - (LibKeySystem*) getKeys
    {
        return keys;
    }  
    
    - (void) pawsOrResumeBgSound  
    {
        if ( soundBgPlays ) 
        {
            [ LibDebug out : @"PLAYS NOW" ];
            [ soundBg pause ];
            soundBgPlays = NO;
        }
        else 
        {
            [ LibDebug out : @"PLAYS NOT" ];
            [ soundBg resume ];
            soundBgPlays = YES;
        }
    }
    
    - (void) doShowDialogWon
    {
        showDialogWon = YES;
    }

    - (void) doShowDialogLost
    {
        showDialogLost = YES;
    }

    - (void) doShowDialogPaws
    {
        showDialogPaws = YES;
    }
    
    - (void) showSystemDialogs
    {
        if ( showDialogWon )
        {
            //show message
            NSString* message1 = @"You have solved this Picross correctly!\n";
            NSString* message2 = [[[ self getState ] getGame ] getCaption ];
            NSString* message3 = @"\nPush Ok to return to main menu!";
            
            NSString* message = message1;
                      message = [ message stringByAppendingString : message2 ];            
                      message = [ message stringByAppendingString : message3 ];            
            
            [ LibDialog showMessageDialog : @"You WON !" : message : @"OK" ];

            showDialogWon = NO;
            
            //release all keys ( enter key release is not notified on accepting dialog .. )
            [ [ singletonMainContext getKeys ] releaseAllKeys ];            

            //block enter key for main menu!
            [ [ [ self getKeys ] getKeyEnter ] blockKey : ETicksMenuKeyBlocker ];            
            
            //return to main menu
            [ [ singletonMainContext getState ] returnToMainMenu ];
        }
        else if ( showDialogLost )
        {
            //show message
            [ LibDialog showMessageDialog : @"You LOST !" : @"You are out of time!\nPush Ok to return to main menu!" : @"OK" ];

            showDialogLost = NO;
             
            //release all keys ( enter key release is not notified on accepting dialog .. )
            [ [ singletonMainContext getKeys ] releaseAllKeys ];            

            //block enter key for main menu!
            [ [ [ singletonMainContext getKeys ] getKeyEnter ] blockKey : ETicksMenuKeyBlocker ];            
            
            //return to main menu
            [ [ singletonMainContext getState ] returnToMainMenu ];
        }
        else if ( showDialogPaws )
        {
            long timeBeforePaws = [ [ NSDate date ] timeIntervalSince1970 ];

            //show dialog
            int n = [ LibDialog showQuestionDialog : @"GAME PAUSED" : @"Push Continue to continue the game\nPush Exit to return to main menu!" : @"Continue" : @"Exit" ];

            showDialogPaws = NO;
            
            //release all keys ( enter key release is not notified on accepting dialog .. )
            [ [ singletonMainContext getKeys ] releaseAllKeys ];            

            //block enter key
            [ [ [ singletonMainContext getKeys ] getKeyEnter ] blockKey : ETicksMenuKeyBlocker ];            

            //switch return code
            switch ( n )
            {
                case NSAlertDefaultReturn:
                {
                    //continue game
                    long timeAfterPaws = [ [ NSDate date ] timeIntervalSince1970 ];
                    long pawsedTime    = ( timeAfterPaws - timeBeforePaws );
                    [ [ state getGame ] substractPawsedTime : pawsedTime ];
                    break;
                }

                default:
                {
                    //return to main menu
                    [ [ singletonMainContext getState ] returnToMainMenu ];
                    break;
                }
            }
        }
    }

    - (BOOL) isPawsed
    {
        return showDialogPaws;
    }
    
    @end
