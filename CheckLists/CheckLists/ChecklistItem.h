//
//  ChecklistItem.h
//  CheckLists
//
//  Created by Claus on 14-3-20.
//  Copyright (c) 2014年 self.edu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject<NSCoding>

@property (nonatomic,copy) NSString *itemName;
@property (nonatomic,assign) BOOL checked;

- (void)toggleChecked;

@end
