/*  $Id:$
 *  =================================================================
 */
         
    @interface LibSliver : NSObject 
    {
    }

    extern  NSMutableArray*     particles;

    - (void) init : (NSArray*) aParticleImages;

    - (void) addParticles : (int)x : (int)y;
    
    - (void) drawParticles;

    - (void) animateParticles;

    @end
