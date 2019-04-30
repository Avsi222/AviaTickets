//
//  NewsFavourite+CoreDataProperties.m
//  AviaTickects
//
//  Created by Арсений Дорогин on 11/04/2019.
//  Copyright © 2019 Арсений Дорогин. All rights reserved.
//
//

#import "NewsFavourite+CoreDataProperties.h"

@implementation NewsFavourite (CoreDataProperties)

+ (NSFetchRequest<NewsFavourite *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"NewsFavourite"];
}

@dynamic title;
@dynamic descriptionNews;
@dynamic image;

@end
