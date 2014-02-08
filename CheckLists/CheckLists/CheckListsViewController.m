//
//  ChecklistsViewController.m
//  Checklists
//
//  Created by Claus on 14-2-1.
//  Copyright (c) 2014年 self.edu. All rights reserved.
//

#import "ChecklistsViewController.h"
#import "ChecklistsItem.h"

@interface ChecklistsViewController ()

@end

@implementation ChecklistsViewController
{
    NSMutableArray *_sampleData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _sampleData = [[NSMutableArray alloc]initWithCapacity:20];
    
    ChecklistsItem *item;
    item=[[ChecklistsItem alloc]init];
    item.text = @"起床";
    item.checked = YES;
    [_sampleData addObject:item];
    
    item=[[ChecklistsItem alloc]init];
    item.text = @"刷牙洗脸";
    item.checked = NO;
    [_sampleData addObject:item];
    
    item=[[ChecklistsItem alloc]init];
    item.text = @"收拾床铺";
    item.checked = YES;
    [_sampleData addObject:item];
    
    item=[[ChecklistsItem alloc]init];
    item.text = @"吃早饭";
    item.checked = YES;
    [_sampleData addObject:item];
    
    item=[[ChecklistsItem alloc]init];
    item.text = @"出门锻炼";
    item.checked = NO;
    [_sampleData addObject:item];
    
    item=[[ChecklistsItem alloc]init];
    item.text = @"看书看报";
    item.checked = NO;
    [_sampleData addObject:item];
    
    item=[[ChecklistsItem alloc]init];
    item.text = @"上班";
    item.checked = YES;
    [_sampleData addObject:item];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_sampleData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    ChecklistsItem *item = _sampleData[indexPath.row];
    
    [self configTextLabelForCell:cell withChecklistItem:item];
    [self configCheckmarkForCell:cell withChecklistItem:item];
    
    return cell;
}

#pragma mark - configure textLabel&checkmark
//configure textLabel
-(void)configTextLabelForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistsItem *)item
{
    UILabel *textLabel = (UILabel *)[cell viewWithTag:1000];
    textLabel.text = item.text;
}

//config checkmark for cell
-(void)configCheckmarkForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistsItem *)item
{
    UILabel *checkmarkLabel = (UILabel *)[cell viewWithTag:1001];
    if (item.checked) {
        checkmarkLabel.text = @"√";
    }
    else{
        checkmarkLabel.text = @"";
    }
}

#pragma mark - tableview delegate method
//tableview delgate method
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get the cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //get the item to be change status
    ChecklistsItem *item = _sampleData[indexPath.row];
    [item toggleChecked];
    
    [self configCheckmarkForCell:cell withChecklistItem:item];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//tableview edit
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get the item to be deleted
    ChecklistsItem *item = [_sampleData objectAtIndex:indexPath.row];
    [_sampleData removeObject:item];
    
    NSArray *indexPaths = @[indexPath];
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - implement ItemDetailView protocol
//implement add item viewcontroller delegate
-(void)addItemViewControllerDidCancel:(ItemDetailViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//implement add item viewcontroller delegate
-(void)addItemViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistsItem *)item
{
    //for debug
    NSLog(@"Contents of the item is %@",item.text);
    
    //add the new item into _sampleData
    NSInteger index = [_sampleData count];
    [_sampleData addObject:item];
    
    //get the new indexPath
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    NSArray *indexPaths = @[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addItemViewController:(ItemDetailViewController *)controller didFinishEditingItem:(ChecklistsItem *)item
{
    //for debug
    NSLog(@"Edited item is %@",item.text);
    
    NSInteger index = [_sampleData indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    //get the cell
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    [self configTextLabelForCell:cell withChecklistItem:item];
    [self configCheckmarkForCell:cell withChecklistItem:item];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation
// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addItem"]) {
        UINavigationController *naviController = segue.destinationViewController;
        
        //get the add item viewcontroller
        ItemDetailViewController *controller = (ItemDetailViewController *)naviController.topViewController;
        
        //assign delegate
        controller.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"editItem"])
    {
        UINavigationController *naviController = segue.destinationViewController;
        
        //get the add item viewcontroller
        ItemDetailViewController *controller = (ItemDetailViewController *)naviController.topViewController;
        
        //assign delegate
        controller.delegate = self;
        
        //send the item to the detail view
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        controller.itemToEdit = [_sampleData objectAtIndex:indexPath.row];
    }
}

@end
