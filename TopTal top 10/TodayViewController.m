//
//  TodayViewController.m
//  TopTal top 10
//
//  Created by Marija Efremova on 3/2/15.
//  Copyright (c) 2015 Marija Efremova. All rights reserved.
//

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

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    [self setPreferredContentSize:CGSizeMake(self.view.bounds.size.width, 176)];
//}

//- (void)updatePreferredContentSize
//{
//    self.preferredContentSize = CGSizeMake(self.view.frame.size.width, [self.topThreeTableView numberOfRowsInSection:0]*self.topThreeTableView.rowHeight);
//    
//    //[self.topThreeTableView numberOfRowsInSection:0]*self.topThreeTableView.rowHeight
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupDataSource];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
//{
//    NSLog(@"extension viewWillTransitionToSize");
//    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context){
//        //        self.topThreeTableView.frame = CGRectMake(0, 0, size.width, size.height);
//        [self updatePreferredContentSize];
//        
//    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context)
//     {
//         
//     }];
//    
//    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
//}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    NSLog(@"extension widgetPerformUpdateWithCompletionHandler");
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    [self setupDataSource];
    
    completionHandler(NCUpdateResultNewData);
}

- (IBAction)showAllTapped:(id)sender {
    [self.extensionContext openURL:[NSURL URLWithString:@"topTenTechnologies://home"] completionHandler:nil];
}

- (void) setupDataSource
{
    NSLog(@"extension setupDataSource");
    NSUserDefaults *sharedDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.TopTalBlogExample"];
    
    if ([sharedDefaults objectForKey:@"dataArray"]) {
        self.tableViewDataArray = [[sharedDefaults objectForKey:@"dataArray"] mutableCopy];
    }
    
    [self.latestUpdateLbl setText:[self lastUpdateLabelText]];
    
    [self.topThreeTableView reloadData];
//    [self updatePreferredContentSize];
}

- (void)userDefaultsDidChange:(NSNotification *)notification {
    //    [self.topThreeTableView reloadData];
    [self setupDataSource];
}

- (NSString *) lastUpdateLabelText {
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.TopTalBlogExample"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    
    NSDate *date = [defaults objectForKey:@"lastUpdateDate"];
    
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    NSLog(@"formattedDateString: %@", formattedDateString);
    
    return [NSString stringWithFormat:@"Latest update: %@", formattedDateString];
}

#pragma mark - Table view data source and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // The number of time zones in the section is the count of the array associated with the section in the sections array.
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ExtensionIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell
    //    if (indexPath.row == 3) {
    //        cell.textLabel.text = [self lastUpdateLabelText];
    //    }
    //    else
    //        cell.textLabel.text = self.tableViewDataArray[indexPath.row];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = self.tableViewDataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
