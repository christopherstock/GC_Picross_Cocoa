/*  $Id:$
 *  =================================================================
 */

    #import "LibDialog.h"

    @implementation LibDialog

    + (void) showMessageDialog : (NSString*)title : (NSString*)message : (NSString*)buttonLabel
    {
        NSRunAlertPanel
        (
            title, 
            message,
            buttonLabel,
            nil,
            nil
        ); 
    }
    
    + (int) showQuestionDialog : (NSString*)title : (NSString*)message : (NSString*)buttonDefault : (NSString*)buttonCancel
    {
        return NSRunAlertPanel
        (
            title, 
            message,
            buttonDefault,
            buttonCancel,
            nil
        ); 
    }

    @end
