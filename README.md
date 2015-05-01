# iOS-UITextField
A subclass of UITextField with some useful functionalities

# How to use
<h5>properties</h5>

  name                        |     type                    |   description    
------------------------------| ----------------------------|--------------------------------------------------------
maxLength                     | int                         | sets the max length allowed (default zero not used)
resignKeyboardOnReturn        | BOOL                        | if true it resigns keyboard on return key (default true)
validationType                | L3SDKTextFieldValidationType| it allows to set the validation type (see L3SDKTextFieldValidationType enumeration, default L3SDKTextFieldValidationTypeNone)
validateOnLostFocus           | BOOL                        | if true validate data on lost focus (default false)
allowNull                     | BOOL                        | it allows to leave the field empty (default false)
validationErrorBackgroundColor| UIColor                     | it allows to set a background color on validation error
validationMessage             | NSString                    | it allows to set a message text raised on validation error with an alert
regularExpression             | NSString                    | it allows to set a custom regular expression

<h5>methods</h5>
  name                  |     type        |   description    
--------------          | ----------------|-------------------------------------------------------------------
validate                | BOOL            | it allows to validate date

<h5>enumerations</h5>

```objectivec
typedef NS_ENUM(NSInteger, L3SDKTextFieldValidationType) {
    L3SDKTextFieldValidationTypeNone,
    L3SDKTextFieldValidationTypeInteger,
    L3SDKTextFieldValidationTypeDecimal,
    L3SDKTextFieldValidationTypeEMail,
    L3SDKTextFieldValidationTypePhoneNumber,
    L3SDKTextFieldValidationTypeCreditCard
};
```

<h5>examples</h5>
```objectivec

    //EMAIL
    self.emailTextField.validationType=L3SDKTextFieldValidationTypeEMail;
    self.emailTextField.validationErrorBackgroundColor=[UIColor redColor];
    self.emailTextField.validationMessage=@"Please insert a valid E-Mail address";
    self.emailTextField.validateOnLostFocus=YES;
    
    //PHONE
    self.phoneTextField.validationType=L3SDKTextFieldValidationTypePhoneNumber;
    self.phoneTextField.validationErrorBackgroundColor=[UIColor redColor];
    self.phoneTextField.validationMessage=@"Please insert a valid phone number";
    self.phoneTextField.allowNull=YES;
    
    //INTEGER
    self.integerTextField.validationType=L3SDKTextFieldValidationTypeInteger;
    self.integerTextField.validationErrorBackgroundColor=[UIColor redColor];
    self.integerTextField.validationMessage=@"Please insert a valid integer number";
    
    //DECIMAL
    self.decimalTextField.validationType=L3SDKTextFieldValidationTypeDecimal;
    self.decimalTextField.validationErrorBackgroundColor=[UIColor redColor];
    self.decimalTextField.validationMessage=@"Please insert a valid decimal number";
    
    //CREDIT CARD
    self.creditCardTextField.validationType=L3SDKTextFieldValidationTypeCreditCard;
    self.creditCardTextField.validationErrorBackgroundColor=[UIColor redColor];
    self.creditCardTextField.validationMessage=@"Please insert a valid credit card number";
    
    //MAX LENGTH (NO VALIDATION)
    self.simpleTextField.maxLength=2;

```
<!--
<br/>
![ScreenShot](https://raw.github.com/alchimya/iOS-UITextField/master/screenshots/iOS-UITextField.gif)
-->
