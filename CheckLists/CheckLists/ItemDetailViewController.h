//
//  AddItemViewController.h
//  Checklists
//
//  Created by Claus on 14-2-1.
//  Copyright (c) 2014年 self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChecklistsItem;
@class ItemDetailViewController;

@protocol ItemDetailViewControllerDelegate <NSObject>

-(void)addItemViewControllerDidCancel:(ItemDetailViewController *)controller;
-(void)addItemViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistsItem *)item;
-(void)addItemViewController:(ItemDetailViewController *)controller didFinishEditingItem:(ChecklistsItem *)item;

@end

@interface ItemDetailViewController : UITableViewController<UITextFieldDelegate>

@property(nonatomic,weak) id <ItemDetailViewControllerDelegate> delegate;
//property textField
@property(nonatomic,weak) IBOutlet UITextField *textField;
@property(nonatomic,weak) IBOutlet UIBarButtonItem *btnDone;

@property(nonatomic,strong) ChecklistsItem *itemToEdit;

-(IBAction)cancel;
-(IBAction)done;

@end
