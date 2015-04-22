/*  $Id:$
 *  =================================================================
 */
        
    @interface LibMath : NSObject 
    {
    }

    + (int) getRandomInt : (int)from : (int)till;

    + (float) getSinFromAngle : (int) angle;

    + (float) getCosFromAngle : (int) angle;

    @end
