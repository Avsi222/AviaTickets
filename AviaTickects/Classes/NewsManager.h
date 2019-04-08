//
//  NewsManager.h
//  AviaTickects
//
//  Created by Арсений Дорогин on 08/04/2019.
//  Copyright © 2019 Арсений Дорогин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataManager.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsManager : NSObject

+ (instancetype)sharedInstance;
- (void)cityForCurrentIP:(void (^)(News *city))completion;

@end

NS_ASSUME_NONNULL_END
