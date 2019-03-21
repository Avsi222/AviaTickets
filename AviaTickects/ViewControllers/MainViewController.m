//
//  MainViewController.m
//  AviaTickects
//
//  Created by Арсений Дорогин on 20/03/2019.
//  Copyright © 2019 Арсений Дорогин. All rights reserved.
//

#import "MainViewController.h"
#import "PlaceViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 100.0, [UIScreen mainScreen].bounds.size.height/2 - 25.0, 200.0, 50.0);
    UIButton *button = [UIButton buttonWithType: UIButtonTypeSystem];
    [button setTitle:@"Дальше" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    button.tintColor = [UIColor whiteColor];
    button.frame = frame;
    [button addTarget:self action:@selector(changeColorButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

// Метод, который будет вызван при нажатии на кнопку
- (void)changeColorButtonDidTap:(UIButton *)sender
{
    UIViewController *vc = [[PlaceViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:true];
    
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
