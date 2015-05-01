//
//  L3SDKTextField.h
//  QRPark
//
//  Created by Domenico Vacchiano on 30/04/15.
//  Copyright (c) 2015 LamCube. All rights reserved.
//

#import <UIKit/UIKit.h>

//NOTE: if you add a new member you have to modify
// - validate
// - setValidationType
typedef NS_ENUM(NSInteger, L3SDKTextFieldValidationType) {
    L3SDKTextFieldValidationTypeNone,
    L3SDKTextFieldValidationTypeInteger,
    L3SDKTextFieldValidationTypeDecimal,
    L3SDKTextFieldValidationTypeEMail,
    L3SDKTextFieldValidationTypePhoneNumber,
    L3SDKTextFieldValidationTypeCreditCard
};

@interface L3SDKTextField : UITextField
//sets the max length allowed (default zero not used)
@property (nonatomic,assign) int maxLength;
//if true it resigns keyboard on return key (default true)
@property (nonatomic,assign)BOOL resignKeyboardOnReturn;
//it allows to set the validation type (see L3SDKTextFieldValidationType enumeration, default L3SDKTextFieldValidationTypeNone)
@property (nonatomic,assign) L3SDKTextFieldValidationType validationType;
//if true validate data on lost focus (default false)
@property (nonatomic,assign)BOOL validateOnLostFocus;
//it allows to leave the field empty (default false)
@property (nonatomic,assign)BOOL allowNull;
//it allows to set a background color on validation error
@property (nonatomic,strong)UIColor* validationErrorBackgroundColor;
//it allows to set a message text raised on validation error with an alert
@property (nonatomic,strong)NSString*validationMessage;
//it allows to set a custom regular expression
@property (nonatomic,strong)NSString*regularExpression;
//it allows to validate date
-(BOOL)validate;
@end

