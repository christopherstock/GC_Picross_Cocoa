/*  $Id:$
 *  =================================================================
 */

    #import "LibDebug.h"
    #import "LibKey.h"
    #import "LibKeySystem.h"

    @implementation LibKeySystem

    LibKey*         keyDown;
    LibKey*         keyUp;
    LibKey*         keyLeft;
    LibKey*         keyRight;
    LibKey*         keyEnter;
    LibKey*         keySpace;
    LibKey*         keyEscape;
    LibKey*         keyM;

    - (void) init
    {
        keyDown     = [ LibKey alloc ];
        keyUp       = [ LibKey alloc ];
        keyLeft     = [ LibKey alloc ];
        keyRight    = [ LibKey alloc ];
        keyEnter    = [ LibKey alloc ];
        keySpace    = [ LibKey alloc ];
        keyEscape   = [ LibKey alloc ];
        keyM        = [ LibKey alloc ];
    }

    - (void) keyDown : (NSEvent*) theEvent 
    {
        [ LibDebug out : @"Test KEY PRESSED !!" ];
        
        switch( [theEvent keyCode] ) 
        {
            case EKeycodeRight:
            {
                [ LibDebug out : @"Arrow key right pressed!" ];
                [ keyRight press ];
                break;
            }
            
            case EKeycodeLeft:
            {
                [ LibDebug out : @"Arrow key left pressed!" ];
                [ keyLeft press ];
                break;
            }
                
            case EKeycodeUp:
            {
                [ LibDebug out : @"Arrow key up pressed!" ];
                [ keyUp press ];
                break;
            }
                
            case EKeycodeDown:
            {
                [ LibDebug out : @"Arrow key down pressed!" ];
                [ keyDown press ];
                break;
            }
           
            case EKeycodeEnter:
            {
                [ LibDebug out : @"Enter key pressed!" ];
                [ keyEnter press ];
                break;
            }

            case EKeycodeSpace:
            {
                [ LibDebug out : @"Space key pressed!" ];
                [ keySpace press ];
                break;
            }

            case EKeycodeEscape:
            {
                [ LibDebug out : @"Escape key pressed!" ];
                [ keyEscape press ];
                break;
            }

            case EKeycodeM:
            {
                [ LibDebug out : @"M key pressed!" ];
                [ keyM press ];
                break;
            }
                          
            default:
            {
                //ignore this key
                NSLog( @"%d", [theEvent keyCode] );
                break;
            }
        }
    }

    - (void) keyUp : (NSEvent*) theEvent 
    {
        [ LibDebug out : @"Test KEY RELEASED !!" ];
        
        switch( [theEvent keyCode] ) 
        {
            case EKeycodeRight:
            {
                [ LibDebug out : @"Arrow key right released!" ];
                [ keyRight release ];
                break;
            }
            
            case EKeycodeLeft:
            {
                [ LibDebug out : @"Arrow key left released!" ];
                [ keyLeft release ];
                break;
            }
                
            case EKeycodeUp:
            {
                [ LibDebug out : @"Arrow key up released!" ];
                [ keyUp release ];
                break;
            }
                
            case EKeycodeDown:
            {
                [ LibDebug out : @"Arrow key down released!" ];
                [ keyDown release ];
                break;
            }
              
            case EKeycodeEnter:
            {
                [ LibDebug out : @"Enter key released!" ];
                [ keyEnter release ];
                break;
            }
              
            case EKeycodeSpace:
            {
                [ LibDebug out : @"Space key released!" ];
                [ keySpace release ];
                break;
            }

            case EKeycodeEscape:
            {
                [ LibDebug out : @"Escape key released!" ];
                [ keyEscape release ];
                break;
            }
            
            case EKeycodeM:
            {
                [ LibDebug out : @"M key released!" ];
                [ keyM release ];
                break;
            }
                                
            default:
            {
                //ignore this key
                NSLog( @"%d", [theEvent keyCode] );
                break;
            }
        }    
    }
    
    - (LibKey*) getKeyDown
    {
        return keyDown;
    }

    - (LibKey*) getKeyUp
    {
        return keyUp;
    }
    
    - (LibKey*) getKeyLeft
    {
        return keyLeft;
    }

    - (LibKey*) getKeyRight
    {
        return keyRight;
    }

    - (LibKey*) getKeyEnter
    {
        return keyEnter;
    }

    - (LibKey*) getKeySpace
    {
        return keySpace;
    }

    - (LibKey*) getKeyEscape
    {
        return keyEscape;
    }
    
    - (LibKey*) getKeyM
    {
        return keyM;
    }

    - (void) releaseAllKeys
    {
        [ keyUp     release ];
        [ keyDown   release ];
        [ keyLeft   release ];
        [ keyRight  release ];
        [ keyEnter  release ];
        [ keyEscape release ];
    }    
    
    - (void) lowerAllKeyBlockers
    {
        //lower the key blockers for all keys
        [ keyUp     lowerKeyBlocker ];
        [ keyDown   lowerKeyBlocker ];
        [ keyLeft   lowerKeyBlocker ];
        [ keyRight  lowerKeyBlocker ];
        [ keyEnter  lowerKeyBlocker ];
        [ keyEscape lowerKeyBlocker ];
    }

    @end
