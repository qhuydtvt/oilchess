//
//  LoginViewController.h
//  Techkid_Chess
//
//  Created by admin on 5/29/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

- (IBAction)loginTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *tfUsername;

@property (weak, nonatomic) IBOutlet UITextField *tfPassword;

@end
