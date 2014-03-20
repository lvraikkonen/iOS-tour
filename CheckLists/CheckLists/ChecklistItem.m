//
//  ChecklistItem.m
//  CheckLists
//
//  Created by Claus on 14-3-20.
//  Copyright (c) 2014年 self.edu. All rights reserved.
//

#import "ChecklistItem.h"

@implementation ChecklistItem

- (void)toggleChecked
{
    self.checked = !self.checked;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.itemName forKey:@"ItemName"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init])) {
        self.itemName = [aDecoder decodeObjectForKey:@"ItemName"];
        self.checked = [aDecoder decodeBoolForKey:@"Checked"];
    }
    
    return self;
}

@end
