//
//  News_Image_ViewController.m
//  AviaTickects
//
//  Created by Арсений Дорогин on 08/04/2019.
//  Copyright © 2019 Арсений Дорогин. All rights reserved.
//

#import "News_Image_ViewController.h"

@interface News_Image_ViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation News_Image_ViewController

- (instancetype)initWithTickets:(NSString *)image {
    self = [super init];
    if (self)
    {
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: image]];
        UIImage *loadedImage = [UIImage imageWithData: imageData];
        if (loadedImage.size.width > self.view.frame.size.width){
            UIImageView *someImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-loadedImage.size.width/8, self.view.frame.size.height/2-loadedImage.size.height/8, loadedImage.size.width/4, loadedImage.size.height/4)];
            someImageView.image = loadedImage;
            [self.view addSubview:someImageView];
        }else{
            UIImageView *someImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-loadedImage.size.width/4, self.view.frame.size.height/2-loadedImage.size.height/4, loadedImage.size.width/2, loadedImage.size.height/2)];
            someImageView.image = loadedImage;
            [self.view addSubview:someImageView];
        }
        
    }
    return self;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
