//
//  AddItemViewController.h
//  CheckLists
//
//  Created by Claus on 14-1-11.
//  Copyright (c) 2014年 self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

//define protocol--step 1
@class AddItemViewController;
@class CheckListItem;

@protocol AddItemViewControllerDelegate <NSObject>

- (void)addItemViewControllerDidCancel:(AddItemViewController *)controller;
- (void)addItemViewController:(AddItemViewController *)controller didFinishAddingItem:(CheckListItem *)item;

@end

@interface AddItemViewController : UITableViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textInput;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButton;
//property to handle delegate--step 2
@property (nonatomic,weak) id <AddItemViewControllerDelegate> delegate;

- (IBAction)cancel;
- (IBAction)done;


@end
