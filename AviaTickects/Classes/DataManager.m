//
//  DataManager.m
//  AviaTickects
//
//  Created by Арсений Дорогин on 21/03/2019.
//  Copyright © 2019 Арсений Дорогин. All rights reserved.
//

#import "DataManager.h"


@interface DataManager ()
@property (nonatomic, strong) NSMutableArray *valutesArray;
@end

@implementation DataManager

+ (instancetype)sharedInstance
{
    static DataManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DataManager alloc] init];
    });
    return instance;
}

- (void)loadData
{
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
        //NSArray *countriesJsonArray = [self arrayFromFileName:@"countries" ofType:@"json"];
        //self->_countriesArray = [self createObjectsFromArray:countriesJsonArray withType: DataSourceTypeCountry];
        
       // NSArray *citiesJsonArray = [self arrayFromFileName:@"cities" ofType:@"json"];
        //self->_citiesArray = [self createObjectsFromArray:citiesJsonArray withType: DataSourceTypeCity];
        
      //  NSArray *airportsJsonArray = [self arrayFromFileName:@"airports" ofType:@"json"];
       // self->_airportsArray = [self createObjectsFromArray:airportsJsonArray withType: DataSourceTypeAirport];
        NSArray *valutesJsonArray = [self arrayFromFileName:@"Valute" ofType:@"json"];
        //NSLog(@"%@", valutesJsonArray);
        self->_valutesArray = [self createObjectsFromArray:valutesJsonArray withType: DataSourceTypeValute];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kDataManagerLoadDataDidComplete object:nil];
        });
        NSLog(@"Complete load data");
    });
}

- (NSMutableArray *)createObjectsFromArray:(NSArray *)array withType:(DataSourceType)type
{
    NSMutableArray *results = [NSMutableArray new];
    NSArray *vlutesArray = [array valueForKey:@"Valute"];
    NSLog(@"%@", vlutesArray);
        for (NSDictionary *dicr in vlutesArray){
            NSLog(@"%@",[dicr valueForKey:@"Value"]); //НЕ ПОЛУЧАЕТСЯ ЗДЕСЬ ВЗЯТЬ ДАННЫЕ  и дальше в классе соответственно
            if (type == DataSourceTypeValute) {
                valute *value = [[valute alloc] initWithDictionary: dicr];
                [results addObject: value];
            }
        }
    
    return results;
}

- (NSArray *)arrayFromFileName:(NSString *)fileName ofType:(NSString *)type
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}


- (NSArray *)valute
{
    return _valutesArray;
}

@end
