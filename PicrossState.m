/*  $Id:$
 *  =================================================================
 */
     
    #import "Picross.h"
    #import "PicrossState.h"
    #import "PicrossMainMenu.h"
    #import "PicrossGame.h"
    #import "PicrossLevel.h"
    #import "PicrossSettings.h"
    #import "PicrossView.h"
    #import "LibDebug.h"
    #import "LibDrawing.h"
    #import "LibKeySystem.h"

    @implementation PicrossState

    PicrossLevel*       level               = nil;
    PicrossMainMenu*    mainMenu            = nil;
    PicrossGame*        game                = nil;

    int                 currentState        = EStateMainMenu;

    - (void) init : (NSRect) canvas 
    {
        //create systems
        mainMenu = [ PicrossMainMenu alloc ];
        game     = [ PicrossGame     alloc ];
        level    = [ PicrossLevel    alloc ];
        
        //init main menu
        [ mainMenu init : canvas ];
    }

    - (void) startEasyGame
    {
        //init level
        [ level initEasy ];
        
        //init game system
        [ game init : ETimeLevelEasy ];

        //change main state
        currentState = EStateIngame;
    }

    - (void) startMediumGame
    {
        //init level
        [ level initMedium ];
        
        //init game system
        [ game init : ETimeLevelMedium ];

        //change main state
        currentState = EStateIngame;
    }

    - (void) startHardGame
    {
        //init level
        [ level initHard ];
        
        //init game system
        [ game init : ETimeLevelHard ];

        //change main state
        currentState = EStateIngame;
    }
    
    - (void) returnToMainMenu
    {
        //change main state
        currentState = EStateMainMenu;
    }

    - (void) handleKeys
    {
        //propagate handleKeys to sub system
        switch ( currentState )
        {
            case EStateMainMenu:
            {
                [ mainMenu handleKeys ];
                break;
            }
        
            case EStateIngame:
            {
                [ game handleKeys ];
                break;
            }
        } 
    }

    - (void) run
    {
        //propagate run to sub system
        switch ( currentState )
        {
            case EStateMainMenu:
            {
                [ mainMenu run ];
                break;
            }
        
            case EStateIngame:
            {
                [ game run ];
                break;
            }
        }        
    }
    
    - (void) paint : (NSRect)canvas
    {
        //debug out
      //[ LibDebug out : @"Draw the rect and an image" ];
        
        switch ( currentState )
        {
            case EStateMainMenu:
            {
                //propagate paint to main menu
                [ mainMenu paint : canvas ];
                break;
            }
        
            case EStateIngame:
            {
                //propagate paint to main menu
                [ game paint : canvas ];
                break;
            }
        }
    }
    
    - (PicrossLevel*) getLevel 
    {
        return level;
    }

    - (PicrossGame*) getGame 
    {
        return game;
    }
        
    @end
