/*  $Id:$
 *  =================================================================
 */

    #import "PicrossMainMenu.h"
    #import "Picross.h"
    #import "PicrossResources.h" 
    #import "PicrossSettings.h" 
    #import "PicrossState.h" 
    #import "LibDrawing.h" 
    #import "LibKey.h" 
    #import "LibKeySystem.h" 
    #import "LibMath.h" 
    #import "LibUtil.h" 

    @implementation PicrossMainMenu

    int     currentIndex        = EMainMenuItemStartEasyGame;
    
    float   alphaLogo           = 0.0f;
    float   bgX                 = 0;
    float   bgY                 = 0;
    int     bgDirection         = 0;
    
    - (void) init : (NSRect) canvas 
    {
        //center bg image 
        bgX = - ( [ [ [ singletonMainContext getResources ] getImage : EImgMenuBg ] size ].width  - canvas.size.width  ) / 2;
        bgY = - ( [ [ [ singletonMainContext getResources ] getImage : EImgMenuBg ] size ].height - canvas.size.height ) / 2;
        
        //let random select start direction
        [ self changeBgDirection ];
    }
    
    - (void) changeBgDirection
    {
        bgDirection = [ LibMath getRandomInt : EDirectionNorth : EDirectionNorthWest ];
        
        //NSLog( @"random direction >>> %d", bgDirection );
    }

    - (void) handleKeys
    {
        if ( [ [[ singletonMainContext getKeys ] getKeyDown ] isKeyPressed ] )
        {
            if ( currentIndex < EMainMenuItemIndices - 1 && [ [ [ singletonMainContext getKeys ] getKeyDown ] isKeyIdle ] )
            {
                ++currentIndex;
                [ [[ singletonMainContext getKeys ] getKeyDown ] blockKey : ETicksMenuKeyBlocker ];
            }
        } 
        
        if ( [ [[ singletonMainContext getKeys ] getKeyUp ] isKeyPressed ] )
        {
            if ( currentIndex > 0 && [ [ [ singletonMainContext getKeys ] getKeyUp ] isKeyIdle ] )
            {
                --currentIndex;
                [ [[ singletonMainContext getKeys ] getKeyUp ] blockKey : ETicksMenuKeyBlocker ];
            }
        }
        
        if ( [ [[ singletonMainContext getKeys ] getKeyEnter ] isKeyPressed ] )
        {
            if ( [ [ [ singletonMainContext getKeys ] getKeyEnter ] isKeyIdle ] )
            { 
                //switch menu item
                switch ( currentIndex )
                {
                    case EMainMenuItemStartEasyGame:
                    {
                        //block enter key
                        [ [ [ singletonMainContext getKeys ] getKeyEnter ] blockKey : ETicksMenuKeyBlocker ];
                    
                        //start easy game
                        [ [ singletonMainContext getState ] startEasyGame ];
                        break;
                    }
                
                    case EMainMenuItemStartMediumGame:
                    {
                        //block enter key
                        [ [ [ singletonMainContext getKeys ] getKeyEnter ] blockKey : ETicksMenuKeyBlocker ];
                    
                        //start medium game
                        [ [ singletonMainContext getState ] startMediumGame ];
                        break;
                    }

                    case EMainMenuItemStartHardGame:
                    {
                        //block enter key
                        [ [ [ singletonMainContext getKeys ] getKeyEnter ] blockKey : ETicksMenuKeyBlocker ];
                    
                        //start hard game
                        [ [ singletonMainContext getState ] startHardGame ];
                        break;
                    }
                }
            }
        }
    }

    - (void) run
    {
        //lower all key blockers
        [ [ singletonMainContext getKeys ] lowerAllKeyBlockers ];        

        //fade in logo
        alphaLogo += 0.003f;
        if ( alphaLogo > 1.0f ) alphaLogo = 1.0f;         
        
        //animate bg image
        {
            //move bg UP
            switch ( bgDirection )
            {
                case EDirectionNorth:
                case EDirectionNorthEast:
                case EDirectionNorthWest:
                {
                    if ( bgY < 0 ) 
                    {
                        ++bgY;
                    }
                    else 
                    {
                        [ self changeBgDirection ];
                    }
                    break;
                }
            }

            //move bg DOWN
            switch ( bgDirection )
            {
                case EDirectionSouth:
                case EDirectionSouthEast:
                case EDirectionSouthWest:
                {
                    if ( bgY > - ( [ [ [ singletonMainContext getResources ] getImage : EImgMenuBg ] size ].height - [ singletonMainContext getCanvasHeight ] ) ) 
                    {
                        --bgY;      
                    }
                    else 
                    {
                        [ self changeBgDirection ];
                    }
                    break;
                }
            }
            
            //move bg LEFT
            switch ( bgDirection )
            {
                case EDirectionNorthWest:
                case EDirectionWest:
                case EDirectionSouthWest:
                {
                    if ( bgX > - ( [ [ [ singletonMainContext getResources ] getImage : EImgMenuBg ] size ].width - [ singletonMainContext getCanvasWidth ] ) ) 
                    {
                        --bgX;
                    }
                    else 
                    {
                        [ self changeBgDirection ];
                    }
                    break;
                }
            }        
            
            //move bg RIGHT
            switch ( bgDirection )
            {
                case EDirectionNorthEast:
                case EDirectionEast:
                case EDirectionSouthEast:
                {
                    if ( bgX < 0 ) 
                    {
                        ++bgX;
                    }
                    else 
                    {
                        [ self changeBgDirection ];
                    }
                    break;
                }
            } 
        }       
    }
    
    - (void) paint : (NSRect) canvas
    {
        //fill screen white
        [ LibDrawing fillRect : EColorWhite : 0 : 0 : canvas.size.width : canvas.size.height ];

        //draw translucent img
        [ LibDrawing drawImage  : [ [ singletonMainContext getResources ] getImage : EImgMenuBg ] : bgX : bgY : EAnchorLeftBottom : EAlphaBg ];

        //draw border
        [ LibDrawing fillRect   : EColorWhite : 0                                       : 0                                       : canvas.size.width  : EOffsetBorderFrame ];
        [ LibDrawing fillRect   : EColorWhite : 0                                       : canvas.size.height - EOffsetBorderFrame : canvas.size.width  : EOffsetBorderFrame ];
        [ LibDrawing fillRect   : EColorWhite : 0                                       : 0                                       : EOffsetBorderFrame : canvas.size.height ];
        [ LibDrawing fillRect   : EColorWhite : canvas.size.width - EOffsetBorderFrame  : 0                                       : EOffsetBorderFrame : canvas.size.height ];

        //draw logo
        [ LibDrawing drawImage  : [ [ singletonMainContext getResources ] getImage : EImgLogoBig ] : canvas.size.width / 2 : canvas.size.height * 3 / 4 : EAnchorCenterMiddle : alphaLogo ];
        
        //draw items
        [ LibDrawing drawString : @"START EASY GAME",   285, 250, ( currentIndex == EMainMenuItemStartEasyGame    ? EMenuItemSelectedFill : EMenuItemUnselectedFill ), ( currentIndex == EMainMenuItemStartEasyGame    ? EMenuItemSelectedBorder : EMenuItemUnselectedBorder ), 25 ];
        [ LibDrawing drawString : @"START MEDIUM GAME", 270, 200, ( currentIndex == EMainMenuItemStartMediumGame  ? EMenuItemSelectedFill : EMenuItemUnselectedFill ), ( currentIndex == EMainMenuItemStartMediumGame  ? EMenuItemSelectedBorder : EMenuItemUnselectedBorder ), 25 ];
        [ LibDrawing drawString : @"START HARD GAME",   285, 150, ( currentIndex == EMainMenuItemStartHardGame    ? EMenuItemSelectedFill : EMenuItemUnselectedFill ), ( currentIndex == EMainMenuItemStartHardGame    ? EMenuItemSelectedBorder : EMenuItemUnselectedBorder ), 25 ];
    
        //draw instructions
        [ LibDrawing drawString : @"\u2193 \u2191", 330,         75, EColorSynapsyBlue,    0x00ffffff, 15 ];
        [ LibDrawing drawString : @"ENTER",         330,         50, EColorSynapsyBlue,    0x00ffffff, 15 ];
        [ LibDrawing drawString : @"Select",        400,         75, EColorBlack,          EColorWhite, 15 ];
        [ LibDrawing drawString : @"Start game",    400,         50, EColorBlack,          EColorWhite, 15 ];
    
        //draw line
        //[ LibDrawing drawLine : 0xffff0000 : 0 : 0 : canvas.size.width : canvas.size.height ];
    }

    @end
