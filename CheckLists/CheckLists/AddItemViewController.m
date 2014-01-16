//
//  AddItemViewController.m
//  CheckLists
//
//  Created by Claus on 14-1-11.
//  Copyright (c) 2014年 self.edu. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()

@end

@implementation AddItemViewController

- (IBAction)cancel
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)done
{
    NSLog(@"Text input is %@",self.textInput.text);
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.textInput becomeFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString=[textField.text stringByReplacingCharactersInRange:range withString:string];
    
    self.barButton.enabled=([newString length]>0);
    
    return YES;
}

@end
