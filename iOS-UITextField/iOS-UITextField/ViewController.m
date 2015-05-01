//
//  ViewController.m
//  iOS-UITextField
//
//  Created by Domenico Vacchiano on 01/05/15.
//  Copyright (c) 2015 DomenicoVacchiano. All rights reserved.
//

#import "ViewController.h"

#import "L3SDKTextField.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet L3SDKTextField *emailTextField;
@property (weak, nonatomic) IBOutlet L3SDKTextField *phoneTextField;
@property (weak, nonatomic) IBOutlet L3SDKTextField *integerTextField;
@property (weak, nonatomic) IBOutlet L3SDKTextField *decimalTextField;
@property (weak, nonatomic) IBOutlet L3SDKTextField *creditCardTextField;

-(IBAction)validate:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
}
-(IBAction)validate:(id)sender{
    
    [self.emailTextField validate];
    [self.phoneTextField validate];
    [self.integerTextField validate];
    [self.decimalTextField validate];
    [self.creditCardTextField validate];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
