//
//  City.m
//  AviaTickects
//
//  Created by Арсений Дорогин on 20/03/2019.
//  Copyright © 2019 Арсений Дорогин. All rights reserved.
//

#import "News.h"

@implementation News

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _author = [dictionary valueForKey:@"author"];
        _title = [dictionary valueForKey:@"title"];
        _descriptionNews = [dictionary valueForKey:@"description"];
        _urlImage = [dictionary valueForKey:@"urlToImage"];
    }
    return self;
}

@end
