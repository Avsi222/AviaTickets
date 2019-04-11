//
//  ProgressView.h
//  AviaTickects
//
//  Created by Арсений Дорогин on 11/04/2019.
//  Copyright © 2019 Арсений Дорогин. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView

+ (instancetype)sharedInstance;

- (void)show:(void (^)(void))completion;
- (void)dismiss:(void (^)(void))completion;

@end
