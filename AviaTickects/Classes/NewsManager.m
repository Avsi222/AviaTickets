//
//  NewsManager.m
//  AviaTickects
//
//  Created by Арсений Дорогин on 08/04/2019.
//  Copyright © 2019 Арсений Дорогин. All rights reserved.
//

#import "NewsManager.h"
#define API_TOKEN @"5ebd16177fd64c29ad89a9f76c990db6"
#define API_URL_IP_ADDRESS @"https://newsapi.org/v2/top-headlines"
#define API_URL_CITY_FROM_IP @"https://newsapi.org/v2/top-headlines?country=ru&apiKey="

@implementation NewsManager

+ (instancetype)sharedInstance {
    static NewsManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NewsManager alloc] init];
    });
    return instance;
}

- (void)cityForCurrentIP:(void (^)(News *city))completion {
        [self load:[NSString stringWithFormat:@"%@%@", API_URL_CITY_FROM_IP, API_TOKEN] withCompletion:^(id  _Nullable result) {
            NSDictionary *json = result;
            NSLog(@"The class is %@",[json class]);
            NSMutableArray *mutableArray = [[NSMutableArray alloc]init];
            
            
            NSLog(@"Array is: %@",mutableArray);
            NSDictionary *iata = [json valueForKey:@"articles"];
            if (iata) {
                News *city = [[DataManager sharedInstance] cityForIATA:iata];
                if (city) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion(city);
                    });
                }
            }
        }];
}


- (void)load:(NSString *)urlString withCompletion:(void (^)(id _Nullable result))completion {
    NSLog(@"%@",urlString);
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    });
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        });
        NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"The class is %@",[json class]);
        completion([NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]);
    }] resume] ;
}

@end

