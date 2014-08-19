//
//  ViewController.m
//  InstaMakers
//
//  Created by Albert Saucedo on 8/18/14.
//  Copyright (c) 2014 Albert Saucedo. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import "Person.h"


#define PersonClass @"Person"
#define UserName @"username"
#define Password @"password"
#define FirstName @"firstname"
#define LastName @"lastname"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *logInLabel;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property NSArray *persons;
@property BOOL isSignIn;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refreshDisplay];
    self.isSignIn = YES;
}

- (IBAction)onSignUpButtonPressed:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"Sign-Up"]) {
        self.isSignIn = NO;
        [sender setTitle:@"Sign-In" forState:UIControlStateNormal];
        [UIView animateWithDuration:1 animations:^{
            self.logInLabel.transform = CGAffineTransformMakeTranslation(0, -60 );
            self.logInLabel.transform = CGAffineTransformMakeTranslation(0, -120);
            self.firstNameTextField.hidden = NO;
            self.lastNameTextField.hidden = NO;
            self.firstNameTextField.alpha = 1;
            self.lastNameTextField.alpha = 1;
            sender.enabled = NO;
        } completion:^(BOOL finished) {
            sender.enabled = YES;
        }];
    } else {
        self.isSignIn = YES;
        [sender setTitle:@"Sign-Up" forState:UIControlStateNormal];
        [UIView animateWithDuration:1 animations:^{
            self.logInLabel.transform = CGAffineTransformMakeTranslation(0, -50 );
            self.logInLabel.transform = CGAffineTransformMakeTranslation(0, 5);
            self.firstNameTextField.alpha = 0;
            self.lastNameTextField.alpha = 0;
            sender.enabled = NO;
        } completion:^(BOOL finished) {
            sender.enabled = YES;
            self.firstNameTextField.hidden = YES;
            self.lastNameTextField.hidden = YES;
        }];
    }
}

- (IBAction)onLoginButtonPressed:(UIButton *)sender {

    if (self.isSignIn) {
        for (Person* aPerson in self.persons) {
            NSString* userName = aPerson.userName;
            NSString* password = aPerson.password;
            if ([userName isEqualToString:self.usernameTextField.text] && [password isEqualToString:self.passwordTextField.text]) {
                //[self performSegueWithIdentifier:@"WriteSegue" sender:self];
            }
        }
    } else {
        if (![self.firstNameTextField.text isEqualToString:@""] && ![self.lastNameTextField.text isEqualToString:@""] && ![self.usernameTextField.text isEqualToString:@""]  && ![self.passwordTextField.text isEqualToString:@""]) {
            PFObject* aPerson = [PFObject objectWithClassName:PersonClass];
            aPerson[UserName] = self.usernameTextField.text;
            aPerson[Password] = self.passwordTextField.text;
            aPerson[FirstName] = self.firstNameTextField.text;
            aPerson[LastName] = self.lastNameTextField.text;
            if (![self.persons containsObject:aPerson]) {
                [aPerson saveEventually:^(BOOL succeeded, NSError *error) {
                    if (error) {
                        NSLog(@"%@", [error userInfo]);
                    } else {
                        [self refreshDisplay];
                    }
                }];
                //[self performSegueWithIdentifier:@"WriteSegue" sender:self];
            }
        } else {
            NSString* message = @"You are missing: ";
            if ([self.firstNameTextField.text isEqualToString:@""] || [self.firstNameTextField.text isEqualToString:@"First Name"]) {
                [message stringByAppendingString:@"Your first name\n"];
            }
            if ([self.lastNameTextField.text isEqualToString:@""] || [self.lastNameTextField.text isEqualToString:@"Last Name"]) {
                [message stringByAppendingString:@"Your last name\n"];
            }
            if ([self.usernameTextField.text isEqualToString:@""] || [self.usernameTextField.text isEqualToString:@"username"]) {
                [message stringByAppendingString:@"Your username\n"];
            }
            if ([self.passwordTextField.text isEqualToString:@""] || [self.passwordTextField.text isEqualToString:@"password"]) {
                [message stringByAppendingString:@"Your password"];
            }
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Missing Information" message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
        }
    }
}

- (void) refreshDisplay
{
    PFQuery *query = [PFQuery queryWithClassName:@"Person"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"%@", [error userInfo]);
        } else {
            self.persons = objects;
        }
    }];
}

@end
