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
@property (nonatomic, strong) NSArray *searchArray;
@property (nonatomic, strong) UISearchController *searchController;
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
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchController.dimsBackgroundDuringPresentation = NO;
    _searchController.searchResultsUpdater = self;
    _searchArray = [NSArray new];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    if (@available(iOS 11.0, *)) {
        self.navigationItem.searchController = _searchController;
    } else {
        _tableView.tableHeaderView = _searchController.searchBar;
    }

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
#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (searchController.searchBar.text) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.CharCode CONTAINS[cd] %@", searchController.searchBar.text];
        _searchArray = [_currentArray filteredArrayUsingPredicate: predicate];
        [_tableView reloadData];
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_searchController.isActive && [_searchArray count] > 0) {
        return [_searchArray count];
    }

    return [_currentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:ReuseIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    [UIView animateWithDuration:1.0 animations:^{
        cell.frame = CGRectMake(cell.bounds.size.width, cell.frame.origin.y, 50.0, 50.0);
    } completion:^(BOOL finished) {
    }];
    
    valute *valuteMon = (_searchController.isActive && [_searchArray count] > 0) ? [_searchArray objectAtIndex:indexPath.row] : [_currentArray objectAtIndex:indexPath.row];
    cell.textLabel.text = valuteMon.CharCode;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", valuteMon.Value];
    
    return cell;
}

#pragma mark - UITableViewDelegate

@end
