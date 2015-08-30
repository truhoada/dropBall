//
//  ViewController.m
//  DropBall
//
//  Created by BMXStudio03 on 8/28/15.
//  Copyright (c) 2015 Trung Hoang Dang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    UIImageView *ball;
    NSTimer *timer;
    CGFloat ballRadius;
    CGFloat x, y, accellerateY, maxHeight;
    CGSize mainViewSize;
    float vellocityY, j, a, index; //index: count Timer to Rolling ball
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    index = 0;
//    self.edgesForExtendedLayout = UIRectEdgeNone;

//    NSLog(@"main %f",self.view.bounds.size.height);

    
    [self addBall];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(dropBall) userInfo:nil repeats:YES];
}

- (void) addBall {
    mainViewSize = self.view.bounds.size;
    ball = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 130, 112)];
    NSMutableArray *image = [[NSMutableArray alloc] initWithCapacity:15];
    for (int i=0; i<14; i++) {
        NSString *fileName = [NSString stringWithFormat:@"o_009976bf50ac6152-%d",i];
        [image addObject:[UIImage imageNamed:fileName]];
    }
    ball.animationImages = image;
    ball.animationDuration = 2;
    ball.animationRepeatCount = 0;
    [self.view addSubview:ball];
    [ball startAnimating];
    
    ballRadius = 112/2;
    x = mainViewSize.width/2.0;
    y = ballRadius;
    vellocityY = 0.0;
    accellerateY = 10.0;
//    CGFloat statusNavigationBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height;
//    NSLog(@"%f",statusNavigationBarHeight);
    maxHeight = mainViewSize.height - ballRadius;// - statusNavigationBarHeight;
    ball.center = CGPointMake(x, y);
    [self.view addSubview:ball];
    
}

- (void) dropBall {
    index += 1;
    vellocityY += accellerateY;
    y += vellocityY;
    NSLog(@"v1 %f",vellocityY);
    NSLog(@"y1 %f",y);
    if (y>maxHeight) {
        vellocityY = -vellocityY*0.8;
        y = maxHeight;
        NSLog(@"v %f",vellocityY);
        NSLog(@"y %f",y);
        
    }
    if (y == maxHeight && index >70) {
        [timer invalidate];
        [self rollingBall];
        
    }
    ball.center = CGPointMake(x, y);
}
                       
- (void) rollingBall {
    [UIView animateWithDuration:4 animations:^{
        ball.center = CGPointMake(x, y);
    } completion:^(BOOL finished) {
        [self stopBall];
    }];
    
//    x += mainViewSize.width/30;
//    [UIView animateWithDuration:3 animations:^{
//        NSLog(@"%f",x);
//        NSLog(@"%f b", self.view.bounds.size.width);
//        ball.center = CGPointMake(x, y);
//        if (x == mainViewSize.width - mainViewSize.width/30 ) {
//            NSLog(@"x = %f",x);
//            [timer invalidate];
//            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(stopBall) userInfo:nil repeats:1];
//            
//          
//        }
//    }];
}

- (void) stopBall {
//    [timer invalidate];
    [UIView animateWithDuration:5 animations:^{
        ball.center = CGPointMake(130/2 - 15, y);
        NSLog(@"%f",ball.center.x);

    } completion:^(BOOL finished) {
//      ball.animationDuration = 10;
        [ball stopAnimating];
        ball.image = [UIImage imageNamed:@"o_009976bf50ac6152-0"];
        
    }];
}



@end























