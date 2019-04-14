//
//  City.h
//  AviaTickects
//
//  Created by Арсений Дорогин on 20/03/2019.
//  Copyright © 2019 Арсений Дорогин. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descriptionNews;
@property (nonatomic, strong) NSString *urlImage;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

