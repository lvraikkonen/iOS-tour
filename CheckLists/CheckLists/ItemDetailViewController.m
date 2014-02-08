//
//  AddItemViewController.m
//  Checklists
//
//  Created by Claus on 14-2-1.
//  Copyright (c) 2014年 self.edu. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "ChecklistsItem.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.itemToEdit != nil) {
        self.title = @"Edit Item";
        self.textField.text = self.itemToEdit.text;
        self.btnDone.enabled = YES;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.textField becomeFirstResponder];
}

-(IBAction)cancel
{
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate addItemViewControllerDidCancel:self];
}

-(IBAction)done
{
    if (self.itemToEdit ==nil)
    {
        ChecklistsItem *item = [[ChecklistsItem alloc]init];
    
        item.text = self.textField.text;
        item.checked = NO;
    
        //[self dismissViewControllerAnimated:YES completion:nil];
        [self.delegate addItemViewController:self didFinishAddingItem:item];
    }
    else
    {
        self.itemToEdit.text = self.textField.text;
        [self.delegate addItemViewController:self didFinishEditingItem:self.itemToEdit];
    }
    
}

//tableview delegate method
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;//cannot be selected
}

//textField delegate method
-(BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    
    self.btnDone.enabled = ([newText length]>0);
	
    return YES;
}


@end
