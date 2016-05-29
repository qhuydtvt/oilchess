//
//  LoginViewController.m
//  Techkid_Chess
//
//  Created by admin on 5/29/16.
//  Copyright © 2016 TechKid. All rights reserved.
//

#import "LoginViewController.h"
#import "GamePlayViewController.h"
#import "NetworkConfig.h"

#define PRE_DEFINED_USERNAME 1

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#if PRE_DEFINED_USERNAME
    self.tfUsername.text = @"user1";
#endif
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginTapped:(id)sender {
    
    [NetworkConfig sharedInstance].userName = self.tfUsername.text;
    
    GamePlayViewController* gamePlayVC = (GamePlayViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"GamePlay"];
    
    [self presentViewController:gamePlayVC animated:YES completion:nil];
}

@end
