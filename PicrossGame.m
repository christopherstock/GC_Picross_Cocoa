/*  $Id:$
 *  =================================================================
 */

    #import "PicrossGame.h"
    #import "Picross.h"
    #import "PicrossLevel.h"
    #import "PicrossSettings.h"
    #import "PicrossResources.h"
    #import "PicrossState.h"
    #import "PicrossView.h"
    #import "LibDebug.h"
    #import "LibDialog.h"
    #import "LibDrawing.h"
    #import "LibKey.h"
    #import "LibKeySystem.h"
    #import "LibMath.h"
    #import "LibUtil.h"
    #import "LibSliver.h"

    @implementation PicrossGame

    NSImage*            tile                = nil; 
    PicrossLevel*       lvl                 = nil;
    NSMutableArray*     n                   = nil; 
    LibSliver*          sliver              = nil; 
    NSString*           caption             = nil;
    NSSize              tileSize; 

    NSMutableArray*     numbersCols         = nil;
    NSMutableArray*     numbersRows         = nil;

    int                 startTimestamp      = 0;
    int                 levelTime           = 0;

    int                 rows                = 0; 
    int                 cols                = 0; 

    int                 gamefieldWidth      = 0; 
    int                 gamefieldHeight     = 0; 

    int                 offX                = 0;
    int                 offY                = 0;
    
    int                 selectorX           = 0;
    int                 selectorY           = 0;
    
    int                 errorAnimation      = 0;
    int                 ticksTillGameOver   = 0;
    
    BOOL                gameWon             = NO;
    BOOL                gameLost            = NO;
    
    int                 colSelector         = 0;
    BOOL                selectorGetsDarker  = YES;

    - (void) init : (int)aLevelTime
    {
        //pick timestamp
        startTimestamp      = [ [ NSDate date ] timeIntervalSince1970 ];
        levelTime           = aLevelTime;

        //pick images for sliver
        NSArray* sliverImages = 
        [
            [ NSArray alloc ] initWithObjects: 
            [ [ singletonMainContext getResources ] getImage : EImgTileSliver1  ], 
            [ [ singletonMainContext getResources ] getImage : EImgTileSliver2  ], 
            [ [ singletonMainContext getResources ] getImage : EImgTileSliver3  ], 
            [ [ singletonMainContext getResources ] getImage : EImgTileSliver4  ], 
            [ [ singletonMainContext getResources ] getImage : EImgTileSliver5  ], 
            [ [ singletonMainContext getResources ] getImage : EImgTileSliver6  ], 
            [ [ singletonMainContext getResources ] getImage : EImgTileSliver7  ], 
            [ [ singletonMainContext getResources ] getImage : EImgTileSliver8  ], 
            [ [ singletonMainContext getResources ] getImage : EImgTileSliver9  ], 
            [ [ singletonMainContext getResources ] getImage : EImgTileSliver10 ], 
            nil 
        ];
        
        //init sliver
        sliver              = [ LibSliver alloc ];
        [ sliver init : sliverImages ];
    
        //TODO improve / prune level reference? store values in level?
        lvl                 = [ [ singletonMainContext getState ] getLevel ];
        map                 = [ lvl getLevelData    ];
        caption             = [ lvl getLevelCaption ];
        numbersCols         = [ lvl getNumbersCols  ];
        numbersRows         = [ lvl getNumbersRows  ];

        selectorX           = 0;
        selectorY           = 0;
        errorAnimation      = 0;
    
        tile                = [ [ singletonMainContext getResources ] getImage : EImgTileClosed ];
        tileSize            = [ tile size ];

        rows                = [ map count ];
        cols                = [ [ map objectAtIndex : 0 ] count ];

        gamefieldWidth      = ( tileSize.width + 1 ) * cols;
        gamefieldHeight     = ( tileSize.width + 1 ) * rows;
 
        offX                = ( [ singletonMainContext getCanvasWidth  ] - gamefieldWidth  ) / 2;
        offY                = ( [ singletonMainContext getCanvasHeight ] + gamefieldHeight ) / 2;
        
        //reset ticks till game over
        ticksTillGameOver   = -1;
        
        gameWon             = NO;
        gameLost            = NO;
        
        colSelector         = EGameColorSelectorBright;
        selectorGetsDarker  = YES;
    }
    
    - (void) run
    {
        //lower all key blockers
        [ [ singletonMainContext getKeys ] lowerAllKeyBlockers ];
    
        //lower error animation
        if ( errorAnimation > 0 ) --errorAnimation;
    
        //animate particles
        [ sliver animateParticles ];
        
        //animate selector
        [ self animateSelector ];
    
        //check game over if not already over
        if ( !gameWon && !gameLost )
        {
            //check game won
            if ( [ self allFieldsOpen ] )
            {
                gameWon = YES;
                ticksTillGameOver = 100;
            }
        
            //check game lost
            int elapsed     = [ [ NSDate date ] timeIntervalSince1970 ] - startTimestamp;
            int remaining   = ( levelTime - elapsed );
            if ( remaining <= 0 )
            {
                gameLost = YES;
                ticksTillGameOver = 100;
            }
        }
        else 
        {
            //game is over - ticker down
            --ticksTillGameOver;
            
            if ( gameLost )
            {
                //always display error anim
                errorAnimation = ETicksErrorAnimation;
            }
            
            if ( ticksTillGameOver == 0 )
            {
                if ( gameWon )
                {
                    //order won dialog
                    [ singletonMainContext doShowDialogWon ];
                }
                else if ( gameLost )
                {
                    //order lost dialog
                    [ singletonMainContext doShowDialogLost ];
                }
            }
        }
    }
    
    - (void) handleKeys    
    {
        //only handle keys if game is not over!
        if ( !gameWon && !gameLost )
        {
            if ( [ [ [ singletonMainContext getKeys ] getKeyDown ] isKeyPressed ] )
            {
                if ( selectorY < ( rows - 1 ) && [ [ [ singletonMainContext getKeys ] getKeyDown ] isKeyIdle ] )
                {
                    ++selectorY;
                    [ [ [ singletonMainContext getKeys ] getKeyDown ] blockKey : ETicksGameKeyBlocker ];
                }
            }    
            
            if ( [ [[ singletonMainContext getKeys ] getKeyUp ] isKeyPressed ] )
            {
                if ( selectorY > 0 && [ [ [ singletonMainContext getKeys ] getKeyUp ] isKeyIdle ] )
                {
                    --selectorY;
                    [ [ [ singletonMainContext getKeys ] getKeyUp ] blockKey : ETicksGameKeyBlocker ];
                }
            }    
            
            if ( [ [[ singletonMainContext getKeys ] getKeyLeft ] isKeyPressed ] )
            {
                if ( selectorX > 0 && [ [[ singletonMainContext getKeys ] getKeyLeft ] isKeyIdle ] )
                {
                    --selectorX;
                    [ [[ singletonMainContext getKeys ] getKeyLeft ] blockKey : ETicksGameKeyBlocker ];
                }
            }         
            
            if ( [ [[ singletonMainContext getKeys ] getKeyRight ] isKeyPressed ] )
            {
                if ( selectorX < ( cols - 1 ) && [ [[ singletonMainContext getKeys ] getKeyRight ] isKeyIdle ] )
                {
                    ++selectorX;
                    [ [ [ singletonMainContext getKeys ] getKeyRight ] blockKey : ETicksGameKeyBlocker ];
                }
            }    
            
            if ( [ [[ singletonMainContext getKeys ] getKeyEnter ] isKeyPressed ] )
            {
                //handle if enter is not blocked
                if ( [ [[ singletonMainContext getKeys ] getKeyEnter ] isKeyIdle ] )
                {
                    //enter needs release
                    [ [[ singletonMainContext getKeys ] getKeyEnter ] setNeedsRelease ];
                    
                    //chisel current field
                    [ lvl chiselField : selectorX : selectorY ];
                }
            }    
            
            if ( [ [[ singletonMainContext getKeys ] getKeySpace ] isKeyPressed ] )
            {
                //handle if space is not blocked
                if ( [ [[ singletonMainContext getKeys ] getKeySpace ] isKeyIdle ] )
                {
                    //space needs release
                    [ [[ singletonMainContext getKeys ] getKeySpace ] setNeedsRelease ];
                    
                    //mark field
                    [ lvl markField : selectorX : selectorY ];
                }
            }             
            
            if ( [ [[ singletonMainContext getKeys ] getKeyM ] isKeyPressed ] )
            {
                //handle if space is not blocked
                if ( [ [[ singletonMainContext getKeys ] getKeyM ] isKeyIdle ] )
                {
                    //space needs release
                    [ [[ singletonMainContext getKeys ] getKeyM ] setNeedsRelease ];
                    
                    //toggle bg music
                    [ singletonMainContext pawsOrResumeBgSound ];
                }
            }             
            
            if ( [ [ [ singletonMainContext getKeys ] getKeyEscape ] isKeyPressed ] )
            {
                if ( [ [ [ singletonMainContext getKeys ] getKeyEscape ] isKeyIdle ] )
                {
                    [ singletonMainContext doShowDialogPaws ];
                }
            }             
        }
    }
    
    - (void) paint : (CGRect) canvas
    {
        //fill bg
        [ LibDrawing fillRect       : EColorBlack   : 0                                         : 0                                         : canvas.size.width     : canvas.size.height    ];

        //error animation
        if ( errorAnimation > 0 )
        {
            [ LibDrawing fillRect   : EColorRed     : 0                                         : 0                                         : canvas.size.width     : canvas.size.height    ];
        }

        //draw border
        [ LibDrawing fillRect       : EColorWhite   : 0                                         : 0                                         : canvas.size.width     : EOffsetBorderFrame    ];
        [ LibDrawing fillRect       : EColorWhite   : 0                                         : canvas.size.height - EOffsetBorderFrame   : canvas.size.width     : EOffsetBorderFrame    ];
        [ LibDrawing fillRect       : EColorWhite   : 0                                         : 0                                         : EOffsetBorderFrame    : canvas.size.height    ];
        [ LibDrawing fillRect       : EColorWhite   : canvas.size.width - EOffsetBorderFrame    : 0                                         : EOffsetBorderFrame    : canvas.size.height    ];

        //draw gamefield grid
        [ self drawGamefieldGrid : canvas ];

        //draw gamefield tiles, numbers and selector ( if not pawsed )
        if ( ![ singletonMainContext isPawsed ] )
        {
            [ self drawGamefieldTiles : canvas ];
            [ self drawNumbers        : canvas ];
            [ self drawSelector       : canvas ];            
        }
        
        //draw instructions
        [ self drawInstructions : canvas ];
        
        //draw time
        [ self drawTime : canvas ];
        
        //draw particles
        [ sliver drawParticles ];
    }

    - (void) drawSelector : (CGRect) canvas
    {
        int x = offX + ( tileSize.width  + 1 ) * selectorX;
        int y = offY - ( tileSize.height + 1 ) * selectorY;
    
        [ LibDrawing fillRect : colSelector : x - EOffsetESelectorSize : y : 2 * EOffsetESelectorSize + tileSize.width   : EOffsetESelectorSize                                              ];
        [ LibDrawing fillRect : colSelector : x - EOffsetESelectorSize : y -     EOffsetESelectorSize - tileSize.height  : 2 * EOffsetESelectorSize + tileSize.width : EOffsetESelectorSize  ];
        [ LibDrawing fillRect : colSelector : x - EOffsetESelectorSize : y : EOffsetESelectorSize                        : -EOffsetESelectorSize - tileSize.height                           ];
        [ LibDrawing fillRect : colSelector : x + tileSize.width       : y : EOffsetESelectorSize                        : -EOffsetESelectorSize - tileSize.height                           ];
    }

    - (void) drawNumbers : (CGRect) canvas
    {
        //browse numbers for cols
        for ( int i = 0; i < [ numbersCols count ]; ++i )
        {
            //browse col
            NSArray* col = [ numbersCols objectAtIndex : i ];
            for ( int j = 0; j < [ col count ]; ++j )
            {
                //pick and draw this number
                NSNumber* n = [ col objectAtIndex : j ];
                NSString* s = [ LibUtil intToString : [ n intValue ] ];
                [ LibDrawing drawString : s, offX + i * ( tileSize.width + 1 ) + tileSize.width / 3, offY + ( ( [ col count ] - 1 ) * 20 ) + 10 - j * 20, EColorWhite, EColorBlack , 15 ];
            }              
        }

        //browse numbers for rows
        for ( int i = 0; i < [ numbersRows count ]; ++i )
        {
            //browse rows
            NSArray* row = [ numbersRows objectAtIndex : i ];
            for ( int j = 0; j < [ row count ]; ++j )
            {
                //pick and draw this number
                NSNumber* n = [ row objectAtIndex : j ];
                NSString* s = [ LibUtil intToString : [ n intValue ] ];
                [ LibDrawing drawString : s, offX + j * 20 - 20 - ( [ row count ] - 1 ) * 20, offY - i * ( tileSize.height + 1 ) - tileSize.height * 4 / 5, EColorWhite, EColorBlack , 15 ];
            }              
        }
    }

    - (void) drawGamefieldGrid : (CGRect) canvas
    {
        //draw horz and vert baseline
       [ LibDrawing drawLine : EGameColorLinesQuintuple : offX - EOffsetLines : offY                 : offX + gamefieldWidth : offY          ];
       [ LibDrawing drawLine : EGameColorLinesQuintuple : offX                : offY + EOffsetLines  : offX         : offY - gamefieldHeight ];
       
        //browse 2d array
        for ( int i = 0; i < [ map count ]; ++i )
        {
            NSArray* line = [ map objectAtIndex : i ];
            
            for ( int j = 0; j < [ line count ]; ++j )
            {
                //draw vert lines in 1st row only
                if ( i == 0 )
                {
                    int colVert = ( ( j + 1 ) % 5 == 0 ? EGameColorLinesQuintuple : EGameColorLinesSingle );
                    [ LibDrawing drawLine : colVert : offX + ( j + 1 ) * ( tileSize.width + 1 ) : offY + EOffsetLines  : offX + ( j + 1 ) * ( tileSize.width + 1 ) : offY - gamefieldHeight ];
                }
            }    
            
            //draw horz line
            int colHorz = ( ( i + 1 ) % 5 == 0 ? EGameColorLinesQuintuple : EGameColorLinesSingle );
            [ LibDrawing drawLine : colHorz : offX - EOffsetLines : offY - ( i + 1 ) * ( tileSize.height + 1 ) : offX + gamefieldWidth : offY - ( i + 1 ) * ( tileSize.height + 1 ) ];
        } 
    }

    - (void) drawGamefieldTiles : (CGRect) canvas
    {
        //browse 2d array
        for ( int i = 0; i < [ map count ]; ++i )
        {
            NSArray* line = [ map objectAtIndex : i ];
            
            for ( int j = 0; j < [ line count ]; ++j )
            {
                NSNumber* r = [ line objectAtIndex : j ];
                int       d = [ r intValue ];
                
                switch ( d )
                {
                    case ETileTypeFullOpen:
                    {
                        tile = [ [ singletonMainContext getResources ] getImage : EImgTileOpen ];
                        break;
                    }
                
                    case ETileTypeFullClosedUnmarked:
                    case ETileTypeEmptyUnmarked:
                    {
                        tile = [ [ singletonMainContext getResources ] getImage : EImgTileClosed ];
                        break;
                    }
                    
                    case ETileTypeFullClosedMarked:
                    case ETileTypeEmptyMarked:
                    {
                        tile = [ [ singletonMainContext getResources ] getImage : EImgTileMarked ];
                        break;
                    }
                }
                
                //draw tile
                [ LibDrawing drawImage : tile : offX + j * ( tileSize.width + 1 ) : offY - i * ( tileSize.height + 1 ) : EAnchorLeftTop : 1.0f ];
            }    
        }        
    }
    
    - (void) notifyError
    {
        //start error anim
        errorAnimation = ETicksErrorAnimation;
        
        //substract tine!
        startTimestamp -= EErrorTimeSubstraction;
    }
    
    - (void) notifyOpen
    {
        //sliver fx
        int x = offX + selectorX * ( tileSize.width  + 1 );
        int y = offY - selectorY * ( tileSize.height + 1 );        
        [ sliver addParticles : x : y ];
    }
    
    - (void) drawTime : (CGRect) canvas
    {
        //TODO redundant calc!
        int elapsed     = [ [ NSDate date ] timeIntervalSince1970 ] - startTimestamp;
        int remaining   = ( levelTime - elapsed );
        
        //clip remaining time to 0
        if (remaining < 0 ) remaining = 0;
        
        int mins        = remaining / 60;
        int secs        = remaining % 60;
        
        //construct time string
        NSString*        s1 = [ LibUtil intToString : mins ];
        NSString*        s2 = @":";
        NSString*        s3 = [ LibUtil intToString : secs ];
        NSString*        s4 = [ s1 stringByAppendingString : s2   ];
        if ( secs < 10 ) s4 = [ s4 stringByAppendingString : @"0" ]; 
                         s4 = [ s4 stringByAppendingString : s3   ];
        [ LibDrawing drawString : s4, offX + gamefieldWidth + 20, offY - gamefieldHeight - 30, EColorWhite, EColorBlack , 15 ];
    }

    - (void) drawInstructions : (CGRect) canvas
    {
        int lineHeight = 15;
    
        [ LibDrawing drawString : @"\u2193 \u2191 \u2190 \u2192",                                   EOffsetInstructions,        offY - gamefieldHeight - 30 - lineHeight * 0, EColorSynapsyBlue,    EColorBlack, 10 ];
        [ LibDrawing drawString : @"ENTER",                                                         EOffsetInstructions,        offY - gamefieldHeight - 30 - lineHeight * 1, EColorSynapsyBlue,    EColorBlack, 10 ];
        [ LibDrawing drawString : @"SPACE",                                                         EOffsetInstructions,        offY - gamefieldHeight - 30 - lineHeight * 2, EColorSynapsyBlue,    EColorBlack, 10 ];
        [ LibDrawing drawString : @"ESCAPE",                                                        EOffsetInstructions,        offY - gamefieldHeight - 30 - lineHeight * 3, EColorSynapsyBlue,    EColorBlack, 10 ];
        [ LibDrawing drawString : @"M",                                                             EOffsetInstructions,        offY - gamefieldHeight - 30 - lineHeight * 4, EColorSynapsyBlue,    EColorBlack, 10 ];

        [ LibDrawing drawString : @"Move selector",                                                 EOffsetInstructions + 75,   offY - gamefieldHeight - 30 - lineHeight * 0, EColorWhite,          EColorBlack, 10 ];
        [ LibDrawing drawString : @"Chisel field",                                                  EOffsetInstructions + 75,   offY - gamefieldHeight - 30 - lineHeight * 1, EColorWhite,          EColorBlack, 10 ];
        [ LibDrawing drawString : @"Mark/Unmark field",                                             EOffsetInstructions + 75,   offY - gamefieldHeight - 30 - lineHeight * 2, EColorWhite,          EColorBlack, 10 ];
        [ LibDrawing drawString : @"Paws",                                                          EOffsetInstructions + 75,   offY - gamefieldHeight - 30 - lineHeight * 3, EColorWhite,          EColorBlack, 10 ];
        [ LibDrawing drawString : @"Toggle background music",                                       EOffsetInstructions + 75,   offY - gamefieldHeight - 30 - lineHeight * 4, EColorWhite,          EColorBlack, 10 ];

        int modX = ( levelTime == ETimeLevelHard ? 250 : 0 );
        int modY = ( levelTime == ETimeLevelHard ? lineHeight * 3 : 0 );

        [ LibDrawing drawString : @"Numbers express connected fields",                              EOffsetInstructions + modX, offY - gamefieldHeight - 30 - lineHeight * 6 + modY, EColorWhite,          EColorBlack, 10 ];
        [ LibDrawing drawString : @"Multiple numbers are separated by at least one blank field",    EOffsetInstructions + modX, offY - gamefieldHeight - 30 - lineHeight * 7 + modY, EColorWhite,          EColorBlack, 10 ];
    }

    - (LibSliver*) getSliver
    {
        return sliver;
    }
    
    - (NSSize) getTileSize
    {
        return tileSize;
    }
    
    - (BOOL) allFieldsOpen
    {
        //browse 2d array
        for ( int i = 0; i < [ map count ]; ++i )
        {
            NSArray* line = [ map objectAtIndex : i ];
            for ( int j = 0; j < [ line count ]; ++j )
            {
                NSNumber* r = [ line objectAtIndex : j ];
                int       d = [ r intValue ];
                
                if 
                ( 
                        d == ETileTypeFullClosedMarked 
                    ||  d == ETileTypeFullClosedUnmarked
                )
                {
                    return NO;
                }
            }
        }

        return YES;
    }
    
    - (void) substractPawsedTime : (long)pawsedTime
    {
        startTimestamp += pawsedTime;                    
    }
    
    - (void) animateSelector
    {
        if ( selectorGetsDarker )
        {
            colSelector -= 0x010000;
            if ( colSelector == EGameColorSelectorDark ) selectorGetsDarker = NO;
        }
        else 
        {
            colSelector += 0x010000;
            if ( colSelector == EGameColorSelectorBright ) selectorGetsDarker = YES;
        }
    }
    
    - (NSString*) getCaption;
    {
        return caption;
    }
    
    @end
