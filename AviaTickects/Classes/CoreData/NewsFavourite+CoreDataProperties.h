//
//  NewsFavourite+CoreDataProperties.h
//  AviaTickects
//
//  Created by Арсений Дорогин on 11/04/2019.
//  Copyright © 2019 Арсений Дорогин. All rights reserved.
//
//

#import "NewsFavourite+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface NewsFavourite (CoreDataProperties)

+ (NSFetchRequest<NewsFavourite *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *descriptionNews;
@property (nullable, nonatomic, copy) NSString *image;

@end

NS_ASSUME_NONNULL_END
