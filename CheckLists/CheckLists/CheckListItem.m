//
//  CheckListItem.m
//  CheckLists
//
//  Created by Claus on 14-1-9.
//  Copyright (c) 2014年 self.edu. All rights reserved.
//

#import "CheckListItem.h"

@implementation CheckListItem

- (void) toggleChecked
{
    self.checked = !self.checked;
}

@end
