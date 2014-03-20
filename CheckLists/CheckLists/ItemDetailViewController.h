//
//  ItemDetailViewController.h
//  CheckLists
//
//  Created by Claus on 14-3-20.
//  Copyright (c) 2014年 self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChecklistItem.h"

@class ChecklistItem;
@class ItemDetailViewController;

@protocol ItemDetailViewControllerDelegate <NSObject>

- (void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller;
- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item;
- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(ChecklistItem *)item;

@end

@interface ItemDetailViewController : UITableViewController

@property (nonatomic,weak) id <ItemDetailViewControllerDelegate> delegate;

@property (nonatomic,weak) IBOutlet UIBarButtonItem *btnDone;
@property (nonatomic,weak) IBOutlet UITextField *textFieldItemName;

- (IBAction)cancel;
- (IBAction)done;

@property (nonatomic,weak) ChecklistItem *itemToEdit;

@end