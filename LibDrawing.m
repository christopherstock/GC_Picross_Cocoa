/*  $Id:$
 *  =================================================================
 */
     
    #import "LibDrawing.h"
    #import "LibUtil.h"

    @implementation LibDrawing

    + (void) drawString : (NSString*)str, int x, int y, int colFill, int colStroke, int fontSize
    {
        NSPoint pointShadow  = NSMakePoint( x + 1, y - 1 );
        NSPoint pointFg      = NSMakePoint( x,     y     );
        NSFont* font         = [ NSFont fontWithName : @"Futura-MediumItalic" size : fontSize ];
        
        NSMutableDictionary* fontAttributesShadow = 
        [
            [ NSMutableDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName,
            [ LibUtil intToColor : colStroke ], NSForegroundColorAttributeName,
            [ NSNumber numberWithFloat : -0.0 ], NSStrokeWidthAttributeName,
            [ LibUtil intToColor : colStroke ], NSStrokeColorAttributeName, nil ] retain
        ];

        NSMutableDictionary* fontAttributesFg = 
        [
            [ NSMutableDictionary dictionaryWithObjectsAndKeys: font, NSFontAttributeName,
            [ LibUtil intToColor : colFill ], NSForegroundColorAttributeName,
            [ NSNumber numberWithFloat : -0.0 ], NSStrokeWidthAttributeName,
            [ LibUtil intToColor : colStroke ], NSStrokeColorAttributeName, nil ] retain
        ];

        //draw shadow
        [ str drawAtPoint : pointShadow withAttributes : fontAttributesShadow ];

        //draw fg
        [ str drawAtPoint : pointFg     withAttributes : fontAttributesFg ];

        [ fontAttributesShadow release ];
        [ fontAttributesFg     release ];
    }

    + (void) drawImage : (NSImage*)img : (float)x : (float)y : (int)ank : (float)alpha
    {
        switch ( ank )
        {
            case EAnchorLeftTop:        x -= 0;                         y -= [ img size ].height;       break;
            case EAnchorLeftMiddle:     x -= 0;                         y -= [ img size ].height / 2;   break;
            case EAnchorLeftBottom:     x -= 0;                         y -= 0;                         break;
        
            case EAnchorCenterTop:      x -= [ img size ].width / 2;    y -= [ img size ].height;       break;
            case EAnchorCenterMiddle:   x -= [ img size ].width / 2;    y -= [ img size ].height / 2;   break;
            case EAnchorCenterBottom:   x -= [ img size ].width / 2;    y -= 0;                         break;

            case EAnchorRightTop:       x -= [ img size ].width;        y -= [ img size ].height;       break;
            case EAnchorRightMiddle:    x -= [ img size ].width;        y -= [ img size ].height / 2;   break;
            case EAnchorRightBottom:    x -= [ img size ].width;        y -= 0;                         break;
        }
    
        //load and draw img
        NSPoint point1 = NSMakePoint( x, y );
        NSCompositingOperation op = NSCompositeSourceOver;
        
        //draw the img
        [img drawAtPoint: point1 fromRect: NSZeroRect operation: op fraction : alpha ];
    }
    
    + (void) drawLine : (int)col : (int)x1 : (int)y1 : (int)x2 : (int)y2
    {
        //set stroke color
        [ [ LibUtil intToColor : col ] setStroke ];
        
        //create drawing path
        NSBezierPath* drawingPath = [ NSBezierPath bezierPath ];

        [ drawingPath moveToPoint : NSMakePoint( x1, y1 ) ];
        [ drawingPath lineToPoint : NSMakePoint( x2, y2 ) ];
    
        //stroke path
        [ drawingPath stroke ];
    }

    + (void) fillRect : (int)col : (int)x : (int)y : (int)width : (int)height
    {
        //set fill color
        [ [ LibUtil intToColor : col ] setFill ];

        //specify rect
        NSRect  rect = NSMakeRect( x, y, width, height );
        
        //create drawing path
        NSBezierPath* drawingPath = [NSBezierPath bezierPath];

        //set rect as path
        [drawingPath appendBezierPathWithRect: rect];

        //fill path
        [ drawingPath fill ];
    } 
    

    + (NSImage*) rotateImage : (NSImage*)image angle : (int)alpha
    {
        NSImage *existingImage = image;
        NSSize existingSize = [existingImage size];
        NSSize newSize = NSMakeSize(existingSize.height, existingSize.width);
        NSImage *rotatedImage = [[[NSImage alloc] initWithSize:newSize]
        autorelease];

        [rotatedImage lockFocus];
        [[NSGraphicsContext currentContext]
        setImageInterpolation:NSImageInterpolationNone];

        NSAffineTransform *rotateTF = [NSAffineTransform transform];
        NSPoint centerPoint = NSMakePoint(newSize.width / 2,
        newSize.height / 2);

        //translate the image to bring the rotation point to the center
        //(default is 0,0 ie lower left corner)
        [rotateTF translateXBy:centerPoint.x yBy:centerPoint.y];
        [rotateTF rotateByDegrees:alpha];
        [rotateTF translateXBy:-centerPoint.x yBy:-centerPoint.y];
        [rotateTF concat];

        [existingImage drawAtPoint:NSZeroPoint fromRect:NSMakeRect(0, 0,
        newSize.width, newSize.height) operation:NSCompositeSourceOver
        fraction:1.0];

        [rotatedImage unlockFocus];

        return rotatedImage;
    }    
    
    @end
