/*  $Id:$
 *  =================================================================
 */
    
    enum SliverDirection
    {
        ESliverDirectionAscending,
        ESliverDirectionDescending,
        ESliverDirectionLeft,
        ESliverDirectionRight,
    };
    
    @interface LibSliverParticle : NSObject 
    {
        NSImage*    img;
        float       centerX;
        float       centerY;
        float       x;
        float       y;    
        int         angle;
        int         radius;
        int         sliverDirX;
        int         sliverDirY;
        float       deltaX;
        float       deltaY;
        float       speedY;
        BOOL        delay;
    }

    - (LibSliverParticle*) init : (int)aStartX : (int)aStartY : (NSImage*)aImg;

    - (NSImage*) getImage;

    - (float) getX;

    - (float) getY;
    
    - (void) animate;

    @end
