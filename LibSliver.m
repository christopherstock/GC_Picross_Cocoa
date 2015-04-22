/*  $Id:$
 *  =================================================================
 */

    #import "LibDebug.h"
    #import "LibDrawing.h"
    #import "LibSliver.h"
    #import "LibSliverParticle.h"

    @implementation LibSliver

    NSMutableArray*     particles       = nil;
    NSArray*            particleImages  = nil;

    - (void) init : (NSArray*) aParticleImages
    {
        //init particle system
        particles   = [ [ NSMutableArray alloc ] initWithCapacity : 0 ];
        
        //assign images
        particleImages = aParticleImages;
    }

    - (void) addParticles : (int)x : (int)y
    {
        [ LibDebug out : @"Create particles !!" ]; 
    
        //create and add particles
        for ( int i = 0; i < 5; ++i )
        {
            //add all images
            for ( int j = 0; j < [ particleImages count ]; ++j )
            {
                [ particles addObject : [ [ LibSliverParticle alloc ] init : x : y : [ particleImages objectAtIndex : j ] ] ];
            }
        }
    }
    
    - (void) animateParticles
    {
        //browse all particles reversed
        for ( int i = [ particles count ] - 1; i >= 0; --i )
        {
            LibSliverParticle* p = [ particles objectAtIndex : i ];
            [ p animate ];
            if ( [ p getY ] < 0 ) [ particles removeObjectAtIndex : i ];
        }
    }
    
    - (void) drawParticles
    {
        //browse all particles
        for ( int i = 0; i < [ particles count ]; ++i )
        {
            LibSliverParticle* p = [ particles objectAtIndex : i ];
            [ LibDrawing drawImage : [ p getImage ] : [ p getX ] : [ p getY ] : EAnchorLeftTop : 1.0f ];
        }
    }

    @end
