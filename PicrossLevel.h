/*  $Id:$
 *  =================================================================
 */

    #import "PicrossResources.h"

    enum TileType
    {
        ETileTypeEmptyUnmarked      = 0,
        ETileTypeEmptyMarked        = 1,
        ETileTypeFullClosedUnmarked = 2,
        ETileTypeFullClosedMarked   = 3,
        ETileTypeFullOpen           = 4,
    };
   
    enum LevelSkill
    {
        ELevelEasy,
        ELevelMedium,
        ELevelHard,
    };    
                  
    @interface PicrossLevel : NSObject 
    {
        NSMutableArray*     levelData;
        NSString*           levelCaption;
    }
    
    - (void) initEasy;

    - (void) initMedium;

    - (void) initHard;

    - (NSMutableArray*) getLevelData;
    
    - (NSString*) getLevelCaption;
    
    - (void) chiselField : (int)selectorX : (int)selectorY;

    - (void) markField : (int)selectorX : (int)selectorY;
    
    - (NSMutableArray*) getNumbersCols;

    - (NSMutableArray*) getNumbersRows;   

    - (NSMutableArray*) createLevelDataFromImage : (Images)img;

    @end
