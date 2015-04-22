/*  $Id:$
 *  =================================================================
 */
     
    @class LibThread;
    @class LibKeySystem;
    @class PicrossResources;
    @class PicrossState;
         
    @interface Picross : NSObject 
    {
        float               canvas_width;
        float               canvas_height;
            
        NSSound*            soundBg;
        BOOL                soundBgPlays;
            
        BOOL                enableSounds;
            
        LibThread*          thread;
        PicrossResources*   resources;
        PicrossState*       state;
        LibKeySystem*       keys;

        BOOL                showDialogWon;
        BOOL                showDialogLost;
        BOOL                showDialogPaws;
    }
       
    extern  Picross*    singletonMainContext;

    - (void) init : (NSRect) canvas ;

    - (void) paint : (NSRect) canvas;
    
    - (void) repaint;
    
    - (void) handleKeys;
    
    - (void) run;
    
    - (PicrossState*) getState;

    - (PicrossResources*) getResources;
    
    - (int) getCanvasWidth;

    - (int) getCanvasHeight;
    
    - (LibKeySystem*) getKeys;
    
    - (void) pawsOrResumeBgSound;
    
    - (void) showSystemDialogs;
    
    - (void) doShowDialogWon;

    - (void) doShowDialogLost;

    - (void) doShowDialogPaws;
    
    - (BOOL) isPawsed;
    
    @end
