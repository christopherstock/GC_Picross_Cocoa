/*  $Id:$
 *  =================================================================
 */
    
    enum States
    {
        EStateMainMenu      = 0,
        EStateIngame        = 1,
    };    

    @class PicrossLevel;
    @class PicrossMainMenu;
    @class PicrossGame;

    @interface PicrossState : NSObject 
    {
        PicrossMainMenu*    mainMenu            ;
        PicrossLevel*       level               ;
        PicrossGame*        game                ;

        int                 currentState        ;
    }
    
    - (void) startEasyGame;

    - (void) startMediumGame;

    - (void) startHardGame;

    - (void) init : (NSRect) canvas;

    - (void) run;
    
    - (void) handleKeys;
    
    - (void) paint : (NSRect) canvas;
    
    - (PicrossGame*) getGame;

    - (PicrossLevel*) getLevel;
    
    - (void) returnToMainMenu;
    
    @end
