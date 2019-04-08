//
//  valute.m
//  AviaTickects
//
//  Created by Арсений Дорогин on 21/03/2019.
//  Copyright © 2019 Арсений Дорогин. All rights reserved.
//

#import "valute.h"

@implementation valute

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSLog(@"%@",dictionary);
        _name = [dictionary valueForKey:@"Name"];
        _CharCode = [dictionary valueForKey:@"CharCode"];
        _Value = [dictionary valueForKey:@"Value"];
        _Previous = [dictionary valueForKey:@"Previous"];
    }
    return self;
}

@end
