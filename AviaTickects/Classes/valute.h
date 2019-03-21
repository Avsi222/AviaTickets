//
//  valute.h
//  AviaTickects
//
//  Created by Арсений Дорогин on 21/03/2019.
//  Copyright © 2019 Арсений Дорогин. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface valute : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *CharCode;
@property (nonatomic, strong) NSString *Value;
@property (nonatomic, strong) NSString *Previous;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
