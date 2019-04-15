//
//  CoreDataHElper.m
//  AviaTickects
//
//  Created by Арсений Дорогин on 11/04/2019.
//  Copyright © 2019 Арсений Дорогин. All rights reserved.
//

#import "CoreDataHelper.h"

@interface CoreDataHelper ()
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@end

@implementation CoreDataHelper

+ (instancetype)sharedInstance
{
    static CoreDataHelper *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CoreDataHelper alloc] init];
        [instance setup];
    });
    return instance;
}

- (void)setup {
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"AviaTickects" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    NSURL *docsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [docsURL URLByAppendingPathComponent:@"base.sqlite"];
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
    
    NSPersistentStore* store = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:nil];
    if (!store) {
        abort();
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _managedObjectContext.persistentStoreCoordinator = _persistentStoreCoordinator;
}

- (void)save {
    NSError *error;
    [_managedObjectContext save: &error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
}

- (NewsFavourite *)favoriteFromTicket:(News *)news {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"NewsFavourite"];
    request.predicate = [NSPredicate predicateWithFormat:@"title == %@ AND descriptionNews == %@ AND image == %@", news.title, news.descriptionNews, news.urlImage];
    return [[_managedObjectContext executeFetchRequest:request error:nil] firstObject];
}

- (BOOL)isFavorite:(News *)news{
    return [self favoriteFromTicket:news] != nil;
}

- (void)addToFavorite:(News *)news {
    NewsFavourite *favorite = [NSEntityDescription insertNewObjectForEntityForName:@"NewsFavourite" inManagedObjectContext:_managedObjectContext];
    favorite.title = news.title;
    favorite.descriptionNews = news.descriptionNews;
    favorite.image = news.urlImage;
    [self save];
}

- (void)removeFromFavorite:(News *)news{
    NewsFavourite *favorite = [self favoriteFromTicket:news];
    if (favorite) {
        [_managedObjectContext deleteObject:favorite];
        [self save];
    }
}

- (NSArray *)favorites {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"NewsFavourite"];
    //request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"created" ascending:NO]];
    NSLog(@"%@",_managedObjectContext);
    return [_managedObjectContext executeFetchRequest:request error:nil];
}

@end
