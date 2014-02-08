//
//  ChecklistsItem.h
//  Checklists
//
//  Created by Claus on 14-2-1.
//  Copyright (c) 2014年 self.edu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistsItem : NSObject

@property(nonatomic,copy) NSString *text;
@property(nonatomic,assign) BOOL checked;

-(void)toggleChecked;

@end
