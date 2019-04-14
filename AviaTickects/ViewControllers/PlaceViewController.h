//
//  PlaceViewController.h
//  AviaTickects
//
//  Created by Арсений Дорогин on 21/03/2019.
//  Copyright © 2019 Арсений Дорогин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"


@protocol PlaceViewControllerDelegate <NSObject>
- (void)selectPlace:(id)place withDataType:(DataSourceType)dataType;
@end

@interface PlaceViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) id<PlaceViewControllerDelegate>delegate;
- (instancetype)init;

@end
