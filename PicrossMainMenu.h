/*  $Id:$
 *  =================================================================
 */

    enum MainMenuItems
    {
        EMainMenuItemStartEasyGame      = 0,
        EMainMenuItemStartMediumGame    = 1,
        EMainMenuItemStartHardGame      = 2,
        EMainMenuItemIndices            = 3,
    };

    @interface PicrossMainMenu : NSObject 
    {
        int     currentIndex;
           
        float   alphaLogo;
                 
        float   bgX;        
        float   bgY;        
        int     bgDirection;        
    }

    - (void) handleKeys;

    - (void) run;

    - (void) paint : (NSRect)canvas;

    - (void) init : (NSRect) canvas;

    - (void) changeBgDirection;

    @end
