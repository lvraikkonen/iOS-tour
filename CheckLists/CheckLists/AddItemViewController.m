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
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
