//
//  ItemDetailViewController.m
//  CheckLists
//
//  Created by Claus on 14-3-20.
//  Copyright (c) 2014年 self.edu. All rights reserved.
//

#import "ItemDetailViewController.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.itemToEdit!=nil) {
        //init item
        self.textFieldItemName.text=self.itemToEdit.itemName;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.textFieldItemName becomeFirstResponder];
}

- (IBAction)cancel
{
    [self.delegate itemDetailViewControllerDidCancel:self];
    //[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)done
{
    if (self.itemToEdit!=nil) {
        //edit
        self.itemToEdit.itemName = self.textFieldItemName.text;
        [self.delegate itemDetailViewController:self didFinishEditingItem:self.itemToEdit];
    }
    else
    {
        //add
        ChecklistItem *newItem = [[ChecklistItem alloc]init];
        newItem.itemName = self.textFieldItemName.text;
        newItem.checked = NO;
        [self.delegate itemDetailViewController:self didFinishAddingItem:newItem];
    }
    
    //[self dismissViewControllerAnimated:YES completion:nil];
}

@end