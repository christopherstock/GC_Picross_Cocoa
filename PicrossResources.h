/*  $Id:$
 *  =================================================================
 */

    typedef enum 
    {
        EImgLogoBig         = 0,
        EImgTileClosed      = 1,
        EImgTileOpen        = 2,
        EImgMenuBg          = 3,
        EImgTileSliver1     = 4,
        EImgTileSliver2     = 5,
        EImgTileSliver3     = 6,
        EImgTileSliver4     = 7,
        EImgTileSliver5     = 8,
        EImgTileSliver6     = 9,
        EImgTileSliver7     = 10,
        EImgTileSliver8     = 11,
        EImgTileSliver9     = 12,
        EImgTileSliver10    = 13,
        EImgTileMarked      = 14,
        EImgLevelEasy1      = 15,
        EImgLevelMedium1    = 16,
        EImgLevelHard1      = 17,
        EImgIndices         = 18,
    }
    Images;      

    @interface PicrossResources : NSObject 
    {
        NSMutableArray*     images;
    }
    
    - (void) loadImages;
        
    - (NSImage*) getImage : (Images) index;
        
    @end
