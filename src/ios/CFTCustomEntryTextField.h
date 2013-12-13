/*
 *****************************************************************
 * CFTCustomEntryTextField.h
 *
 * Public facing interfaces to the private custom manual entry
 * textfields.
 *
 * Appearance method calls are sent to a CFTCustomEntryTextField
 * contained in a CFTCustomView to set the look and feel of the
 * private textfields that are actually displayed on screen.
 *
 * Currently the frame can only be set directly, auto layout is
 * not supported. Additionally, the frame and appearance must be
 * set in code, interface builder is not supported.
 *
 * Copyright (c) 2013 CardFlight Inc. All rights reserved.
 *****************************************************************
 */

#import <UIKit/UIKit.h>

@protocol CustomEntryTextFieldDelegate <NSObject>

/**
 * Protocol methods are implemented privately to provide
 * access to appearance of the manual entry textfields.
 */

@required
- (void)textFieldFrame:(CGRect)newFrame;

@optional
- (void)textFieldText:(NSString *)newText;
- (void)textFieldTag:(NSInteger)newTag;
- (void)textFieldBackgroundImage:(UIImage *)newBackgroundImage;
- (void)textFieldFont:(UIFont *)newFont;
- (void)textFieldTextColor:(UIColor *)newColor;
- (void)textFieldPlaceholderText:(NSString *)newText;
- (void)textFieldAttributedPlaceholder:(NSAttributedString *)newAttributedPlaceholder;
- (void)textFieldTextAlignment:(NSTextAlignment)newAlignment;
- (void)textFieldBorderStyle:(UITextBorderStyle)newBorder;
- (void)textFieldKeyboardStyle:(UIKeyboardType)newKeyboard;
- (void)textFieldKeyboardAppearance:(UIKeyboardAppearance)newKeyboardAppearance;
- (void)textFieldReturnKeyType:(UIReturnKeyType)newReturnKeyType;
- (void)textFieldResignFirstResponder;

@end

@interface CFTCustomEntryTextField : UIView

@property (nonatomic, weak) id <CustomEntryTextFieldDelegate> delegate;

/**
 * The following public methods allow customization of the manual
 * entry textfields while preventing direct access to the contents.
 * You can set the text but cannot read it.
 * Currently, auto layout is not supported.
 */

- (void)customFieldFrame:(CGRect)newFrame;
- (void)customFieldText:(NSString *)newText;
- (void)customFieldTag:(NSInteger)newTag;
- (void)customFieldBackground:(UIImage *)newBackground;
- (void)customFieldFont:(UIFont *)newFont;
- (void)customFieldTextColor:(UIColor *)newColor;
- (void)customFieldPlaceholder:(NSString *)newPlaceholder;
- (void)customFieldAttributedPlaceholder:(NSAttributedString *)newAttributedPlaceholder;
- (void)customFieldTextAlignment:(NSTextAlignment)newAlignment;
- (void)customFieldBorderStyle:(UITextBorderStyle)newBorder;
- (void)customFieldKeyboardType:(UIKeyboardType)newKeyboard;
- (void)customFieldKeyboardAppearance:(UIKeyboardAppearance)newKeyboardAppearance;
- (void)customFieldReturnKeyType:(UIReturnKeyType)newReturnKeyType;
- (void)customFieldResignFirstResponder;

@end
