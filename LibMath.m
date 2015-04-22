/*  $Id:$
 *  =================================================================
 */
        
    #import "LibMath.h"

    @implementation LibMath

    + (int) getRandomInt : (int)from : (int)till
    {
        int ret = from + ( rand() % ( 1 + till - from ) );
        return ret;
    }

    + (float) getSinFromAngle : (int) angle;
    {
        float s = sin( angle * M_PI / 180.0f );
        return s;
    }

    + (float) getCosFromAngle : (int) angle
    {
        float s = cos( angle * M_PI / 180.0f );
        return s;
    }

    @end
