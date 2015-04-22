/*  $Id:$
 *  =================================================================
 */

    #include "LibDrawing.h"

    #define         EAlphaBg            0.1f

    enum MenuColors
    {
        EMenuItemUnselectedFill         = 0xff303030,
        EMenuItemUnselectedBorder       = 0xffffffff,
        EMenuItemSelectedFill           = EColorSynapsyBlue,
        EMenuItemSelectedBorder         = 0xffffffff,
    };
    
    enum GameColors
    {
        EGameColorLinesSingle           = 0xff444444,
        EGameColorLinesQuintuple        = 0xffffffff,
        EGameColorSelectorBright        = 0xffff0000,
        EGameColorSelectorDark          = 0xff880000,
    };
    
    enum Settings
    {
        ETimeLevelEasy                  = 300,  //sec
        ETimeLevelMedium                = 600,  //sec
        ETimeLevelHard                  = 900,  //sec
        
        EErrorTimeSubstraction          = 30,   //sec
    
        ETicksMenuKeyBlocker            = 30,
        ETicksGameKeyBlocker            = 30,
        ETicksErrorAnimation            = 10,
    };

    enum Offsets
    {
        EOffsetBorderFrame              = 10,
        EOffsetLines                    = 50,
        EOffsetESelectorSize            = 3,
        EOffsetInstructions             = 50,
    };

    @interface PicrossSettings : NSObject 
    {
    }
    
    @end
