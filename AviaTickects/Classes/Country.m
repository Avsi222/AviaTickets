//
//  Country.m
//  AviaTickects
//
//  Created by Арсений Дорогин on 20/03/2019.
//  Copyright © 2019 Арсений Дорогин. All rights reserved.
//

#import "Country.h"

@implementation Country

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _currency = [dictionary valueForKey:@"currency"];
        _translations = [dictionary valueForKey:@"name_translations"];
        _name = [dictionary valueForKey:@"name"];
        _code = [dictionary valueForKey:@"code"];
    }
    return self;
}

@end
