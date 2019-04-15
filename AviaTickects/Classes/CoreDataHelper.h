//
//  CoreDataHElper.h
//  AviaTickects
//
//  Created by Арсений Дорогин on 11/04/2019.
//  Copyright © 2019 Арсений Дорогин. All rights reserved.
//

#import <Foundation/Foundation.h>

// CoreDataHelper.h

#import <CoreData/CoreData.h>
#import "DataManager.h"
#import "NewsFavourite+CoreDataClass.h"

@interface CoreDataHelper : NSObject

+ (instancetype)sharedInstance;

- (BOOL)isFavorite:(News *)news;
- (NSArray *)favorites;
- (void)addToFavorite:(News *)news;
- (void)removeFromFavorite:(News *)news;

@end

