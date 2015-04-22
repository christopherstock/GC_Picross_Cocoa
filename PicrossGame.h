/*  $Id:$
 *  =================================================================
 */

    @class PicrossLevel;
    @class LibSliver;
    
    @interface PicrossGame : NSObject
    {
        NSImage*            tile; 
        PicrossLevel*       lvl;
        NSMutableArray*     map; 
        LibSliver*          sliver; 
        NSString*           caption;
        NSSize              tileSize; 

        NSMutableArray*     numbersCols;
        NSMutableArray*     numbersRows;

        int                 startTimestamp;
        int                 levelTime;
    
        int                 rows; 
        int                 cols; 

        int                 gamefieldWidth; 
        int                 gamefieldHeight; 
 
        int                 offX; 
        int                 offY; 
        
        int                 selectorX;
        int                 selectorY;
        
        int                 errorAnimation;
        int                 ticksTillGameOver;
        
        BOOL                gameWon;
        BOOL                gameLost;
        
        int                 colSelector;
        BOOL                selectorGetsDarker;
    }
    
    - (void) init : (int)aLevelTime; 

    - (void) run;
    
    - (void) handleKeys;
        
    - (void) notifyError;
        
    - (void) paint : (NSRect) canvas;

    - (void) drawSelector : (NSRect) canvas;

    - (void) drawNumbers : (NSRect) canvas;

    - (void) drawGamefieldGrid : (NSRect) canvas;

    - (void) drawGamefieldTiles : (NSRect) canvas;
    
    - (void) drawTime : (NSRect) canvas;

    - (void) drawInstructions : (NSRect) canvas;
    
    - (LibSliver*) getSliver;

    - (NSString*) getCaption;

    - (void) notifyError;
    
    - (void) notifyOpen;
    
    - (BOOL) allFieldsOpen;
    
    - (NSSize) getTileSize;
    
    - (void) substractPawsedTime : (long)pawsedTime;
    
    - (void) animateSelector;
    
    @end
