//
//  L3SDKTextField.m
//  QRPark
//
//  Created by Domenico Vacchiano on 30/04/15.
//  Copyright (c) 2015 LamCube. All rights reserved.
//

#import "L3SDKTextField.h"


@interface L3SDKTextField ()
@property(strong, nonatomic) id currentDelegate;
@property (nonatomic,strong)UIColor* validationOkBackgroundColor;
@end

@implementation L3SDKTextField
@synthesize maxLength;
@synthesize resignKeyboardOnReturn;
@synthesize validationType;
@synthesize validateOnLostFocus;
@synthesize validationErrorBackgroundColor;
@synthesize validationMessage;
@synthesize regularExpression;
@synthesize allowNull;

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self=[super initWithCoder:aDecoder];
    if (self) {
        //wraps and init super delegate
        [super setDelegate:(id)self];
        //sets YES resignKeyboardOnReturn as default
        self.resignKeyboardOnReturn=YES;
        //sets cancel button
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        //sets validation type default value
        validationType=L3SDKTextFieldValidationTypeNone;
        //sets validation error background color default
        self.validationErrorBackgroundColor=super.backgroundColor;
        //stores uitextfield background color
        self.validationOkBackgroundColor=super.backgroundColor;
    }
    
    return self;
}


- (id)forwardingTargetForSelector:(SEL)aSelector {
    //returns proper delegate/selector
    if ([_currentDelegate respondsToSelector:aSelector]) { return _currentDelegate; }
    return [super forwardingTargetForSelector:aSelector];
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [super respondsToSelector:aSelector] || [_currentDelegate respondsToSelector:aSelector];
}

#pragma mark - UITextFieldDelegate Protocol
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    //if maxLength==0 returns YES
    if (self.maxLength==0) {
        return YES;
    }
    
    //UNCOMMENT if you want to raise the same event on the super
    /*
    //raise shouldChangeCharactersInRange on super delegate
    if (_currentDelegate != NULL && [_currentDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        [_currentDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    */
    //returns YES/NO
    return (range.location + [string length]) <= self.maxLength;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    //resigns keyboard
    if (self.resignKeyboardOnReturn) {
        [textField resignFirstResponder];
    }
    //raise event on super
    if (_currentDelegate != NULL && [_currentDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        [_currentDelegate textFieldShouldReturn:textField];
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

    //validate on lost focus
    if (self.validateOnLostFocus) {
        [self validate];
    }
    
    //raise event on super
    if (_currentDelegate != NULL && [_currentDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [_currentDelegate textFieldDidEndEditing:textField];
    }
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //reset background color
    self.backgroundColor=self.validationOkBackgroundColor;
    
    //raise event on super
    if (_currentDelegate != NULL && [_currentDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [_currentDelegate textFieldDidBeginEditing:textField];
    }
}

-(BOOL)validate{
    
    BOOL isValid=NO;
    
    if (self.allowNull && [self.text isEqualToString:@""]) {
        return YES;
    }
    
    //validate data
    switch (self.validationType) {
        case L3SDKTextFieldValidationTypeNone:
            isValid=YES;
            break;
        case L3SDKTextFieldValidationTypeEMail:
            isValid=[self isValidEmail:self.text];
            break;
        case L3SDKTextFieldValidationTypeDecimal:
            isValid=[self isValidDecimalNumber:self.text];
            break;
        case L3SDKTextFieldValidationTypeInteger:
            isValid=[self isValidIntegerNumber:self.text];
            break;
        case L3SDKTextFieldValidationTypePhoneNumber:
            isValid=[self isValidPhoneNumber:self.text];
            break;
        case L3SDKTextFieldValidationTypeCreditCard:
            isValid=[self isValidCreditCard:self.text];
            break;
        default:
            isValid=YES;
            break;
    }
    
    if (!isValid) {
        //set background error color and show an alert with a validation message
        super.backgroundColor=self.validationErrorBackgroundColor;
        if (self.validationMessage) {
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:nil message:self.validationMessage delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }else {
        super.backgroundColor=self.validationOkBackgroundColor;
    }
    
    return isValid;
    
    
}

#pragma mark - Properties override

//delegate
- (void)setDelegate:(id)newDelegate {
    //wraps and set super.delegate
    [super setDelegate:nil];
    _currentDelegate = newDelegate;
    [super setDelegate:(id)self];
}
- (id)delegate {
    return self;
}
//backgroundColor


-(void)setBackgroundColor:(UIColor *)backgroundColor{
    super.backgroundColor=backgroundColor;
    self.validationOkBackgroundColor=backgroundColor;
}
//validationType
-(void)setValidationType:(L3SDKTextFieldValidationType)aValidationType{
    
    //sets keyboardType
    
    validationType=aValidationType;
    switch (aValidationType) {
        case L3SDKTextFieldValidationTypeNone:
            //nothing
            break;
        case L3SDKTextFieldValidationTypeEMail:
            self.keyboardType=UIKeyboardTypeEmailAddress;
            break;
        case L3SDKTextFieldValidationTypeDecimal:
            self.keyboardType=UIKeyboardTypeDecimalPad;
            break;
        case L3SDKTextFieldValidationTypeInteger:
            self.keyboardType=UIKeyboardTypeNumberPad;
            break;
        case L3SDKTextFieldValidationTypePhoneNumber:
            self.keyboardType=UIKeyboardTypePhonePad;
            break;
        case L3SDKTextFieldValidationTypeCreditCard:
            self.keyboardType=UIKeyboardTypeNumberPad;
            break;
        default:
            //nothing
            break;
    }
    
}


#pragma mark - Validators
//e-mail
-(BOOL)isValidEmail:(NSString*)text{
    NSString *regex=self.regularExpression ? self.regularExpression : @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self validateWithText:text withRegularExpression:regex];
}
//phone number
-(BOOL)isValidPhoneNumber:(NSString*)text{
    NSString *regex=self.regularExpression ? self.regularExpression : @"^\\+(?:[0-9] ?){6,14}[0-9]$";
    return [self validateWithText:text withRegularExpression:regex];
}
//credit card
-(BOOL)isValidCreditCard:(NSString*)text{
    NSString *regex=self.regularExpression ? self.regularExpression : @"^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\\d{3})\\d{11})$";
    return [self validateWithText:text withRegularExpression:regex];
}
//integer
-(BOOL)isValidIntegerNumber:(NSString*)text{
    NSString *regex=self.regularExpression ? self.regularExpression : @"^[-+]?\\d+$";
    return [self validateWithText:text withRegularExpression:regex];
}
//decimal
-(BOOL)isValidDecimalNumber:(NSString*)text{
    NSString *regex=self.regularExpression ? self.regularExpression : @"^[-+]?\\d*\\.\\d+$";
    return [self validateWithText:text withRegularExpression:regex];
}

-(BOOL)validateWithText:(NSString*)text withRegularExpression:(NSString*)regex{
    //validate date with a regular expression
    @try {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        return [predicate evaluateWithObject:text];
    }
    @catch (NSException *exception) {
        @throw exception;
    }

}

@end
