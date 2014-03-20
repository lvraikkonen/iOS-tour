//
//  CheckListsViewController.m
//  CheckLists
//
//  Created by Claus on 14-3-20.
//  Copyright (c) 2014年 self.edu. All rights reserved.
//

#import "CheckListsViewController.h"

@interface CheckListsViewController ()

@end

@implementation CheckListsViewController
{
    NSMutableArray *_items;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _items = [[NSMutableArray alloc]initWithCapacity:20];
    
    ChecklistItem *item;
    
    item = [[ChecklistItem alloc]init];
    item.itemName=@"起床";
    item.checked=YES;
    [_items addObject:item];
    
    item = [[ChecklistItem alloc]init];
    item.itemName=@"刷牙洗脸";
    item.checked=YES;
    [_items addObject:item];
    
    item = [[ChecklistItem alloc]init];
    item.itemName=@"打扫卫生";
    item.checked=NO;
    [_items addObject:item];
    
    item = [[ChecklistItem alloc]init];
    item.itemName=@"吃饭";
    item.checked=YES;
    [_items addObject:item];
    
    item = [[ChecklistItem alloc]init];
    item.itemName=@"上班";
    item.checked=NO;
    [_items addObject:item];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configTextlabelForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item
{
    UILabel *textLabel = (UILabel *)[cell viewWithTag:1000];
    textLabel.text = item.itemName;
}

- (void)configCheckmarkForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item
{
    UILabel *checkmarkLabel = (UILabel *)[cell viewWithTag:1001];
    if (item.checked) {
        checkmarkLabel.text = @"√";
    }
    else
    {
        checkmarkLabel.text = @"";
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //get the item
    ChecklistItem *item = [_items objectAtIndex:indexPath.row];
    
    [self configTextlabelForCell:cell withChecklistItem:item];
    [self configCheckmarkForCell:cell withChecklistItem:item];
    
    return cell;
}

#pragma mark - table view delegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get the item to be reconfigured
    ChecklistItem *item = [_items objectAtIndex:indexPath.row];
    [item toggleChecked];
    
    //get the cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [self configCheckmarkForCell:cell withChecklistItem:item];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //remove item from model
    [_items removeObject:[_items objectAtIndex:indexPath.row]];
    
    //remove item from view
    NSArray *indexPaths = @[indexPath];
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end