/*  $Id:$
 *  =================================================================
 */

    @interface LibDialog : NSObject 
    {
    }

    + (void) showMessageDialog : (NSString*)title : (NSString*)message : (NSString*)buttonLabel;

    + (int) showQuestionDialog : (NSString*)title : (NSString*)message : (NSString*)buttonDefault : (NSString*)buttonCancel;

    @end
