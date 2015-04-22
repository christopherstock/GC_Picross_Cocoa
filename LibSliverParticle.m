/*  $Id:$
 *  =================================================================
 */
    
    #import "LibDrawing.h"
    #import "LibSliverParticle.h"
    #import "LibMath.h"

    @implementation LibSliverParticle

    NSImage*    img         = nil;
    float       startX      = 0.0f;
    float       startY      = 0.0f;
    float       x           = 0.0f;
    float       y           = 0.0f;
    int         angle       = 0;
    int         radius      = 0;
    int         sliverDirX  = 0;
    int         sliverDirY  = 0;
    float       deltaX      = 0;
    float       deltaY      = 0;
    float       speedY      = 0;
    BOOL        delay       = NO;

    -(LibSliverParticle*) init : (int)aStartX : (int)aStartY : (NSImage*)aImg
    {
        centerX     = aStartX;
        centerY     = aStartY;
        img         = aImg;
        x           = aStartX;
        y           = aStartY;
        radius      = [ LibMath getRandomInt : 5 : 20 ];
        angle       = 0;
        sliverDirX  = ( [ LibMath getRandomInt : 0  : 1   ] == 0 ? ESliverDirectionLeft : ESliverDirectionRight );
        sliverDirY  = ESliverDirectionAscending;
        deltaX      = ( [ LibMath getRandomInt : 1  : 30  ] / 10.0f );
        deltaY      = ( [ LibMath getRandomInt : 50 : 200 ] / 10.0f );
        speedY      = ( [ LibMath getRandomInt : 2  : 10  ] / 10.0f );
        delay       = NO;
        
        return self;
    }

    - (NSImage*) getImage
    {
        return img;
    }

    - (float) getX
    {
        return x;
    }

    - (float) getY
    {
        return y;
    }
    
    - (void) animate
    {
        //don't care much about trigonomitry
        //x = centerX - radius + ( radius * [ LibMath getCosFromAngle : angle ] );
        
        if ( delay )
        {
            delay = NO;
            return;
        }
        else 
        {
            delay = YES;
        }

        //animate y
        switch ( sliverDirY )
        {
            case ESliverDirectionAscending:
            {
                y += deltaY;
                deltaY -= speedY;
                if ( deltaY <= 0 ) sliverDirY = ESliverDirectionDescending;
                break;
            }

            case ESliverDirectionDescending:
            {
                y -= deltaY;
                deltaY += 0.2f;
                break;
            }
        }
        
        //animate x
        switch ( sliverDirX )
        {
            case ESliverDirectionLeft:
            {
                x -= deltaX;
                break;
            }

            case ESliverDirectionRight:
            {
                x += deltaX;
                break;
            }
        }
    }

    @end
