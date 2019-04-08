//
//  PlaceViewController.m
//  AviaTickects
//
//  Created by Арсений Дорогин on 21/03/2019.
//  Copyright © 2019 Арсений Дорогин. All rights reserved.
//

#import "PlaceViewController.h"
#define ReuseIdentifier @"CellIdentifier"

@interface PlaceViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *labelWithDate;
@property (nonatomic, strong) NSArray *currentArray;
@end

@implementation PlaceViewController

- (instancetype)init
{
    self = [super init];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _labelWithDate = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 10)];
    _labelWithDate.text = [[DataManager sharedInstance] date];
    _currentArray = [[DataManager sharedInstance] valutesArray];
    self.navigationItem.titleView = _labelWithDate;
}

- (void)changeSource
{
    _currentArray = [[DataManager sharedInstance] valutesArray];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_currentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:ReuseIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    valute *valuteMon = [_currentArray objectAtIndex:indexPath.row];
    cell.textLabel.text = valuteMon.CharCode;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", valuteMon.Value];
    
    return cell;
}

#pragma mark - UITableViewDelegate

@end
