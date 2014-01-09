//
//  CheckListItem.h
//  CheckLists
//
//  Created by Claus on 14-1-9.
//  Copyright (c) 2014年 self.edu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckListItem : NSObject

@property(nonatomic,copy) NSString *text;
@property(nonatomic,assign) BOOL checked;

- (void)toggleChecked;

@end
