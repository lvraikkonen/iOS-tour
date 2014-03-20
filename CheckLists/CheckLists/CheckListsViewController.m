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

//sanbox document directory
- (NSString *)documentDirectory
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [path firstObject];
    
    return documentsDirectory;
}

- (NSString *)dataFilePath
{
    return [[self documentDirectory]stringByAppendingString:@"/Checklists.plist"];
}

//serilize data into plist
- (void)saveChecklistsItems
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:_items forKey:@"ChecklistsItems"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}

//decode
- (void)loadChecklistItems
{
    NSString *path = [self dataFilePath];
    if ([[NSFileManager defaultManager]fileExistsAtPath:path]) {
        //if plist file exist
        NSData *data = [[NSData alloc]initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        _items = [unarchiver decodeObjectForKey:@"ChecklistsItems"];
        [unarchiver finishDecoding];
    }
    else
    {
        _items = [[NSMutableArray alloc]initWithCapacity:20];
    }
}

//init method
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        [self loadChecklistItems];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Document folder is %@",[self documentDirectory]);
    NSLog(@"Data File path is %@",[self dataFilePath]);
    
    /*
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
     */
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
    
    //save
    [self saveChecklistsItems];
    
    //get the cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    [self configCheckmarkForCell:cell withChecklistItem:item];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //remove item from model
    [_items removeObject:[_items objectAtIndex:indexPath.row]];
    
    //save
    [self saveChecklistsItems];
    
    //remove item from view
    NSArray *indexPaths = @[indexPath];
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Prepare for sugue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddItem"]) {
        //add item
        UINavigationController *navigationController = segue.destinationViewController;
        ItemDetailViewController *detailViewController = (ItemDetailViewController *)navigationController.topViewController;
        detailViewController.delegate = self;
    }
    else if([segue.identifier isEqualToString:@"EditItem"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        ItemDetailViewController *detailViewController = (ItemDetailViewController *)navigationController.topViewController;
        detailViewController.delegate=self;
        //send object to detail view **********************???????????sender
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        ChecklistItem *item = [_items objectAtIndex:indexPath.row];
        detailViewController.itemToEdit=item;
    }
}

#pragma mark - ItemDetailView delegate methods
- (void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item
{
    NSInteger index = [_items count];
    [_items addObject:item];
    
    //save
    [self saveChecklistsItems];
    
    //get the indexPath
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    NSArray *indexPaths = @[indexPath];
    
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(ChecklistItem *)item
{
    //get the cell
    NSInteger index = [_items indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    //save
    [self saveChecklistsItems];
    
    //reconfigure textlabel in view
    [self configTextlabelForCell:cell withChecklistItem:item];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end