//
//  CheckListsViewController.m
//  CheckLists
//
//  Created by Claus on 14-1-9.
//  Copyright (c) 2014年 self.edu. All rights reserved.
//

#import "CheckListsViewController.h"
#import "CheckListItem.h"

@interface CheckListsViewController ()

@end

@implementation CheckListsViewController
{
    NSMutableArray *_items;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	//Data set -- initialize CheckListItems
    _items = [[NSMutableArray alloc]initWithCapacity:20];
    
    CheckListItem *item;
    
    item=[[CheckListItem alloc]init];
    item.text=@"Walk the Dog";
    item.checked=YES;
    [_items addObject:item];
    
    item=[[CheckListItem alloc]init];
    item.text=@"Brush my Teeth";
    item.checked=YES;
    [_items addObject:item];
    
    item=[[CheckListItem alloc]init];
    item.text=@"Eat ice cream";
    item.checked=NO;
    [_items addObject:item];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    CheckListItem *item = [_items objectAtIndex:indexPath.row];
    
    [self configureTextLabelForCell:cell withCheckListItem:item];
    [self configureCheckMarkForCell:cell withCheckListItem:item];
    
    return cell;
}

//tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //get the selected cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //get the row in model
    CheckListItem *item = [_items objectAtIndex:indexPath.row];
    //reverse checked status
    [item toggleChecked];
    
    [self configureCheckMarkForCell:cell withCheckListItem:item];
    [self configureTextLabelForCell:cell withCheckListItem:item];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//config textLabel for row
- (void)configureTextLabelForCell:(UITableViewCell *)cell withCheckListItem:(CheckListItem *)item
{
    cell.textLabel.text=item.text;
}

//config isCheckMark for row
- (void)configureCheckMarkForCell:(UITableViewCell *)cell withCheckListItem:(CheckListItem *)item
{
    if (item.checked)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else
        cell.accessoryType = UITableViewCellAccessoryNone;
}

/*
//add one fake item
- (IBAction)addItem
{
    NSInteger newRowIndex = [_items count];
    
    CheckListItem *item=[[CheckListItem alloc]init];
    item.text=@"new row";
    item.checked=NO;
    [_items addObject:item];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = @[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}
 */

//commit edit --tableView delegate
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_items removeObjectAtIndex:indexPath.row];
    ////way 1 to reload data --disappear with bad user experience
    //[self.tableView reloadData];
    
    //way 2
    NSArray *indexPaths = @[indexPath];
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

//addItemViewController delegate method
- (void)addItemViewController:(AddItemViewController *)controller didFinishAddingItem:(CheckListItem *)item
{
    NSInteger newRow=[_items count];
    [_items addObject:item];
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:newRow inSection:0];
    NSArray *indexPaths=@[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addItemViewControllerDidCancel:(AddItemViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddItem"]) {
        //1
        UINavigationController *navigationController=segue.destinationViewController;
        
        //2
        AddItemViewController *addItemController=(AddItemViewController *)navigationController.topViewController;
        
        //assign delegate controller for addItemController
        addItemController.delegate=self;
    }
}

@end
