//
//  DataManager.h
//  AviaTickects
//
//  Created by Арсений Дорогин on 21/03/2019.
//  Copyright © 2019 Арсений Дорогин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "valute.h"
#import "News.h"

#define kDataManagerLoadDataDidComplete @"DataManagerLoadDataDidComplete"

typedef enum DataSourceType {
    DataSourceTypeValute
} DataSourceType;

@interface DataManager : NSObject


+ (instancetype)sharedInstance;
- (void)loadData;
- (News *)cityForIATA:(NSDictionary *)iata;

@property (nonatomic, strong, readonly) NSArray *valutesArray;
@property (nonatomic, strong, readonly)  NSMutableArray *newsArray;
@property (nonatomic, strong, readonly) NSString *date;

@end

