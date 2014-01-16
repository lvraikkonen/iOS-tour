//
//  CheckListsViewController.h
//  CheckLists
//
//  Created by Claus on 14-1-9.
//  Copyright (c) 2014年 self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddItemViewController.h"

@interface CheckListsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,AddItemViewControllerDelegate>

@property(nonatomic,retain) IBOutlet UITableView *tableView;

//- (IBAction)addItem;

@end
