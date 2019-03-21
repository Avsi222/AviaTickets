//
//  Country.h
//  AviaTickects
//
//  Created by Арсений Дорогин on 20/03/2019.
//  Copyright © 2019 Арсений Дорогин. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Country : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *currency;
@property (nonatomic, strong) NSDictionary *translations;
@property (nonatomic, strong) NSString *code;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

