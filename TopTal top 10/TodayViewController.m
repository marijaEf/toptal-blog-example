//
//  TodayViewController.m
//  TopTal top 10
//
//  Created by Marija Efremova on 3/2/15.
//  Copyright (c) 2015 Marija Efremova. All rights reserved.
//
////////
// This sample is published as part of the blog article at www.toptal.com/blog
// Visit www.toptal.com/blog and subscribe to our newsletter to read great posts
////////

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>
@property (strong, nonatomic) IBOutlet UITableView *topThreeTableView;
@property (strong, nonatomic) IBOutlet UILabel *latestUpdateLbl;
@property (nonatomic, strong) NSMutableArray *tableViewDataArray;
@property (nonatomic) CGSize preferredContentSize;
- (IBAction)showAllTapped:(id)sender;

@end

@implementation TodayViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(userDefaultsDidChange:)
                                                     name:NSUserDefaultsDidChangeNotification
                                                   object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    [self updateTableView];
    
    completionHandler(NCUpdateResultNewData);
}

- (IBAction)showAllTapped:(id)sender {
//    open the containing app
    [self.extensionContext openURL:[NSURL URLWithString:@"topTenTechnologies://home"] completionHandler:nil];
}

- (void) updateTableView
{
//    get the shared data from NSUserDefaults
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.TopTalBlogExample"];
    
    if ([sharedDefaults objectForKey:@"dataArray"]) {
        self.tableViewDataArray = [[sharedDefaults objectForKey:@"dataArray"] mutableCopy];
    }
    
    [self.latestUpdateLbl setText:[self lastUpdateLabelText]];
    
    [self.topThreeTableView reloadData];
}

- (void)userDefaultsDidChange:(NSNotification *)notification {
    [self updateTableView];
}

- (NSString *) lastUpdateLabelText {
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.TopTalBlogExample"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    NSDate *date = [defaults objectForKey:@"lastUpdateDate"];
    
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    return [NSString stringWithFormat:@"Latest update: %@", formattedDateString];
}

#pragma mark - Table view data source and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ExtensionIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell
    cell.textLabel.text = self.tableViewDataArray[indexPath.row];
    
    return cell;
}

@end
