//
//  DataManager.m
//  AviaTickects
//
//  Created by Арсений Дорогин on 21/03/2019.
//  Copyright © 2019 Арсений Дорогин. All rights reserved.
//

#import "DataManager.h"
#import <UIKit/UIKit.h>
#define API_URL @"https://www.cbr-xml-daily.ru/daily_json.js"

@interface DataManager ()
@property (nonatomic, strong) NSMutableArray *valutesArray;
@property (nonatomic, strong) NSMutableArray *newsArray;
@property (nonatomic, strong) NSString *date;
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

- (News *)cityForIATA:(NSDictionary *)iata {
    if (iata) {
        self->_newsArray = [self createNewsFromArray:iata withType: DataSourceTypeValute];

        return _newsArray;
    }
    return nil;
}

- (valute *)valuteForIATA:(NSDictionary *)iata {
    if (iata) {
        self->_valutesArray = [self createObjectsFromArray:iata withType: DataSourceTypeValute];
        
        return _valutesArray;
    }
    return nil;
}

- (NSMutableArray *)createNewsFromArray:(NSDictionary *)array withType:(DataSourceType)type
{
    NSMutableArray *results = [NSMutableArray new];
    
    //NSLog(@"%@", array);
    for (NSString *dicr in array){
        //NSLog(@"%@", dicr);
        if (type == DataSourceTypeValute) {
            News *value = [[News alloc] initWithDictionary: dicr];
            [results addObject: value];
        }
    }
    
    return results;
}

- (void)load:(NSString *)urlString withCompletion:(void (^)(id _Nullable result))completion {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    });
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        });
        NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        //NSLog(@"The class is %@",[json class]);
        completion([NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]);
    }] resume] ;
}

- (void)loadData
{
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
        
        [self load:[NSString stringWithFormat:@"%@", API_URL] withCompletion:^(id  _Nullable result) {
            NSDictionary *json = result;
            
            self->_valutesArray = [self createObjectsFromArray:json withType: DataSourceTypeValute];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:kDataManagerLoadDataDidComplete object:nil];
            });
            NSLog(@"Complete load data");
    
        }];
    });
}



- (void)valutesForCurrentIP:(void (^)(valute *valute))completion {
    [self load:[NSString stringWithFormat:@"%@", API_URL] withCompletion:^(id  _Nullable result) {
        NSDictionary *json = result;
        //NSLog(@"The class is %@",[json class]);
        NSMutableArray *mutableArray = [[NSMutableArray alloc]init];
        
        
        //NSLog(@"Array is: %@",mutableArray);
        //NSDictionary *iata = [json valueForKey:@"articles"];
        if (json) {
            valute *valutess = [[DataManager sharedInstance] valuteForIATA:json];
            if (valutess) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(valutess);
                });
            }
        }
    }];
}

- (NSMutableArray *)createObjectsFromArray:(NSArray *)array withType:(DataSourceType)type
{
    NSMutableArray *results = [NSMutableArray new];
    self->_date = [array valueForKey:@"Date"];
    NSDictionary *vlutesArray = [array valueForKey:@"Valute"];
    
    for (NSString *dicr in [vlutesArray allValues]){
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
