//
//  TLListListViewController.m
//  CoreDataDemo
//
//  Created by alejandro henao on 12/8/15.
//  Copyright (c) 2015 HenServer. All rights reserved.
//

#import "TLListListViewController.h"
#import "TLTaskList.h"
#import "TLAppDelegate.h"

@interface TLListListViewController ()

@property (nonatomic,strong)NSArray * lists;
@property (nonatomic,readonly) NSManagedObjectContext *managedObjectContext;
-(IBAction)addList:(id)sender;

@end

@implementation TLListListViewController

@synthesize lists = _lists;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //ask the managedObjectContext to retrieve all of the stored lists
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"TLTaskList"]; // by default get all the lists
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"created" ascending:YES]];
    
    NSError *error = nil;
    self.lists = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if(error)
    {
        //handle the error such as looking for entitey names that don't exist
    }
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSManagedObjectContext * )managedObjectContext
{
    return [(TLAppDelegate*) [[UIApplication sharedApplication]delegate] managedObjectContext];
}

#pragma mark - IBAction
-(void)addList:(id)sender
{
   TLTaskList *newList = [NSEntityDescription insertNewObjectForEntityForName:@"TLTaskList" inManagedObjectContext:self.managedObjectContext];
    
    newList.created = [NSDate date];
    newList.title = [NSString stringWithFormat:@"Task list %lu", self.lists.count];
    
    [self.managedObjectContext save:nil]; // this will cause problems if you've written the code wrong
    
    //after save...assume this will be the most recent one made
    self.lists = [self.lists arrayByAddingObject:newList];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.lists.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    TLTaskList *currentList = [self.lists objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    
    cell.textLabel.text = currentList.title;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
