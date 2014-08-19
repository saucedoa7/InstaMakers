//
//  ViewController.m
//  InstaMakers
//
//  Created by Albert Saucedo on 8/18/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import "ViewController.h"

#define PersonClass @"Person"
#define UserName @"username"
#define Password @"password"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *logInLabel;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTExtField;
@property NSArray *persons;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)onSignUpButtonPressed:(UIButton *)sender {
        [UIView animateWithDuration:1 animations:^{
            self.logInLabel.transform = CGAffineTransformMakeTranslation(0, -60 );
            self.logInLabel.transform = CGAffineTransformMakeTranslation(0, -120);
            self.firstNameTextField.hidden = NO;
            self.lastNameTextField.hidden = NO;
            self.firstNameTextField.alpha = 1;
            self.lastNameTextField.alpha = 1;
        }];
}

- (IBAction)onLoginButtonPressed:(UIButton *)sender {

    PFObject *person = [PFObject objectWithClassName:PersonClass];
    person[UserName] = @"saucedoa7";
    person[Password] = @"12345";

    NSLog(@"%@ & %@", person[UserName], person[Password]);

    self.usernameTextField.text = person [UserName];
    self.passwordTExtField.text = person [Password];

    [person saveEventually:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"%@", [error userInfo]);
        } else {
            [self refreshDisplay];
        }
    }];
}

- (void) refreshDisplay
{
    PFQuery *query = [PFQuery queryWithClassName:@"Person"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"%@", [error userInfo]);
        } else {
            NSLog(@"Display Refreshed");
            self.persons = objects;
        }
    }];
}

@end
