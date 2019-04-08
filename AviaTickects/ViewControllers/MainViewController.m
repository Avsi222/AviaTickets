//
//  MainViewController.m
//  AviaTickects
//
//  Created by Арсений Дорогин on 20/03/2019.
//  Copyright © 2019 Арсений Дорогин. All rights reserved.
//

#import "MainViewController.h"
#import "PlaceViewController.h"
#import "NewsViewController.h"

@interface MainViewController () <PlaceViewControllerDelegate>
@property (nonatomic, strong) UIButton *valuteButton;
@property (nonatomic, strong) UIButton *newsButton;
@end

@implementation MainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[DataManager sharedInstance] loadData];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.title = @"Валюта";
    
    _valuteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_valuteButton setTitle:@"Загрузить валюту" forState: UIControlStateNormal];
    _valuteButton.tintColor = [UIColor blackColor];
    _valuteButton.frame = CGRectMake(30.0, 140.0, [UIScreen mainScreen].bounds.size.width - 60.0, 60.0);
    _valuteButton.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [_valuteButton addTarget:self action:@selector(placeButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_valuteButton];
    
    _newsButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_newsButton setTitle:@"Новости" forState: UIControlStateNormal];
    _newsButton.tintColor = [UIColor blackColor];
    _newsButton.frame = CGRectMake(30.0, 210.0, [UIScreen mainScreen].bounds.size.width - 60.0, 60.0);
    _newsButton.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [_newsButton addTarget:self action:@selector(newsButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_newsButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataLoadedSuccessfully) name:kDataManagerLoadDataDidComplete object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDataManagerLoadDataDidComplete object:nil];
}


- (void)dataLoadedSuccessfully {
    [[NewsManager sharedInstance] cityForCurrentIP:^(News *city) {
        NSLog(@"%@",city);
    }];
}

- (void)placeButtonDidTap:(UIButton *)sender {
    PlaceViewController *placeViewController;
    if ([sender isEqual:_valuteButton]) {
        placeViewController = [[PlaceViewController alloc] init];
    }
    placeViewController.delegate = self;
    [self.navigationController pushViewController: placeViewController animated:YES];
}
- (void)newsButtonDidTap:(UIButton *)sender {
    NewsViewController *newsViewController;
    if ([sender isEqual:_newsButton]) {
        newsViewController = [[NewsViewController alloc] init];
    }
    [self.navigationController pushViewController: newsViewController animated:YES];
}



@end
