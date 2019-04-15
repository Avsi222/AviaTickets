//
//  NewsViewController.m
//  AviaTickects
//
//  Created by Арсений Дорогин on 08/04/2019.
//  Copyright © 2019 Арсений Дорогин. All rights reserved.
//

#import "NewsViewController.h"
#import "News_Image_ViewController.h"
#import "CoreDataHelper.h"

#define ReuseIdentifier @"CellIdentifier"

@interface NewsViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *labelWithDate;
@property (nonatomic, strong) NSArray *currentArray;

@end

@implementation NewsViewController{
  BOOL isFavorites;
}

- (instancetype)initFavoriteTicketsController {
    self = [super init];
    if (self) {
        isFavorites = YES;
        self.currentArray = [NSArray new];
        self.title = @"Избранное";
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ReuseIdentifier];
    }
    return self;
}


- (instancetype)init
{
    self = [super init];
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Новости";
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _labelWithDate = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 10)];
    _labelWithDate.text = @"Новости в России";
    _currentArray = [[DataManager sharedInstance] newsArray];
    self.navigationItem.titleView = _labelWithDate;
}

-(void)viewWillAppear:(BOOL)animated{
     [super viewDidAppear:animated];
    if (isFavorites) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        _currentArray = [[CoreDataHelper sharedInstance] favorites];
        [self.tableView reloadData];
    }
}

- (void)changeSource
{
    _currentArray = [[DataManager sharedInstance] newsArray];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_currentArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
    News *valuteMon = [_currentArray objectAtIndex:indexPath.row];
    cell.textLabel.text = valuteMon.title;
    cell.detailTextLabel.text = valuteMon.descriptionNews;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isFavorites) return;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Действия с новостью" message:@"Что необходимо сделать с выбранной новостью?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *favoriteAction;
    UIAlertAction *openAction;
    openAction = [UIAlertAction actionWithTitle:@"Открыть картинку" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSInteger row = [indexPath row];
        NSLog(@"%ld",(long)row);
        
        News_Image_ViewController *placeViewController;
        News *news_i = [_currentArray objectAtIndex:row];
        placeViewController = [[News_Image_ViewController alloc] initWithTickets:news_i.urlImage];
        [self.navigationController pushViewController: placeViewController animated:YES];
    }];
    if ([[CoreDataHelper sharedInstance] isFavorite: [_currentArray objectAtIndex:indexPath.row]]) {
        favoriteAction = [UIAlertAction actionWithTitle:@"Удалить из избранного" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataHelper sharedInstance] removeFromFavorite:[self->_currentArray objectAtIndex:indexPath.row]];
        }];
    } else {
        favoriteAction = [UIAlertAction actionWithTitle:@"Добавить в избранное" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataHelper sharedInstance] addToFavorite:[self->_currentArray objectAtIndex:indexPath.row]];
        }];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:favoriteAction];
    [alertController addAction:cancelAction];
    [alertController addAction:openAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
