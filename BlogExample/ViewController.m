//
//  ViewController.m
//  BlogExample
//
//  Created by Marija Efremova on 2/28/15.
//  Copyright (c) 2015 Marija Efremova. All rights reserved.
//
////////
// This sample is published as part of the blog article at www.toptal.com/blog
// Visit www.toptal.com/blog and subscribe to our newsletter to read great posts
////////

#import "ViewController.h"

#define appGroupSuiteName   @"group.BlogExample"
#warning "Please make sure to update this value upon (re)enabling App Group."

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *tableViewDataArray;
@property (strong, nonatomic) NSUserDefaults *sharedDefaults;
@property (nonatomic, strong) NSMutableArray *topThreeBeforeEdit;
@property (nonatomic, strong) NSMutableArray *topThreeAfterEdit;
@property (strong, nonatomic) IBOutlet UITableView *topTenTableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editBarBtn;

- (IBAction)updateTableEditingMode:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:appGroupSuiteName];
    
    self.topThreeBeforeEdit = [[NSMutableArray alloc] initWithCapacity:3];
    self.topThreeAfterEdit = [[NSMutableArray alloc] initWithCapacity:3];
    
    [self setupDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupDataSource
{
    NSLog(@"setupDataSource");
    if ([self.sharedDefaults objectForKey:@"dataArray"]) {
        self.tableViewDataArray = [[self.sharedDefaults objectForKey:@"dataArray"] mutableCopy];
    }
    else
    {
        NSArray *simpleDataArray = [[NSArray alloc] initWithObjects:@"JavaScript", @"iOS", @"Android", @"PHP", @"AngularJS", @"Ruby on Rails", @"Python", @"Django", @"Laravel", @"jQuery",  nil];
        
        [self.sharedDefaults setObject:simpleDataArray forKey:@"dataArray"];
        [self.sharedDefaults setObject:[NSDate date] forKey:@"lastUpdateDate"];
        self.tableViewDataArray = [simpleDataArray mutableCopy];
        [self.sharedDefaults synchronize];
    }
    
    [self.topTenTableView reloadData];
}

- (IBAction)updateTableEditingMode:(id)sender {
    self.topTenTableView.editing = !self.topTenTableView.editing;
    
    if (self.topTenTableView.editing)
    {
        self.editBarBtn.title = @"Done";
        [self.topThreeBeforeEdit removeAllObjects];
        
        [self.topThreeAfterEdit addObjectsFromArray:[NSArray arrayWithObjects:self.tableViewDataArray[0], self.tableViewDataArray[1], self.tableViewDataArray[2], nil]];
        
    }
    else
    {
        self.editBarBtn.title = @"Edit";
        
        [self.topThreeAfterEdit removeAllObjects];
        
        [self.topThreeAfterEdit addObjectsFromArray:[NSArray arrayWithObjects:self.tableViewDataArray[0], self.tableViewDataArray[1], self.tableViewDataArray[2], nil]];
        
        [self.sharedDefaults setObject:self.tableViewDataArray forKey:@"dataArray"];
        if (![self.topThreeBeforeEdit isEqualToArray:self.topThreeAfterEdit]) {
            [self.sharedDefaults setObject:[NSDate date] forKey:@"lastUpdateDate"];
        }
        
        [self.sharedDefaults synchronize];
    }
}

#pragma mark - Table view data source and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // The number of time zones in the section is the count of the array associated with the section in the sections array.
    return self.tableViewDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell
    cell.textLabel.textColor = [UIColor colorWithRed:34/255.0 green:78/255.0 blue:129/255.0 alpha:1];
    cell.textLabel.text = self.tableViewDataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableview shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


- (BOOL)tableView:(UITableView *)tableview canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *stringToMove = self.tableViewDataArray[sourceIndexPath.row];
    [self.tableViewDataArray removeObjectAtIndex:sourceIndexPath.row];
    [self.tableViewDataArray insertObject:stringToMove atIndex:destinationIndexPath.row];
}

@end
