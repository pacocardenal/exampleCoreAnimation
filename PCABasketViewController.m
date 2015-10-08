//
//  PCABasketViewController.m
//  Basket
//
//  Created by Paco Cardenal on 8/10/15.
//  Copyright © 2015 Paco Cardenal. All rights reserved.
//

#import "PCABasketViewController.h"

@interface PCABasketViewController ()

@end

@implementation PCABasketViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // To create the tap
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(userDidTap:)];
    // To add the tap
    [self.view addGestureRecognizer:tap];
    // To create the swipe
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(userDidSwipe:)];
    // To add the swipe
    [self.view addGestureRecognizer:swipe];
    
}

- (void) userDidSwipe: (UISwipeGestureRecognizer *) swipe {

    if (swipe.state == UIGestureRecognizerStateRecognized) {
        
        static CGFloat angle = 0;
        // To rotate with spring and dumping
        [UIView animateWithDuration:3
                              delay:0
             usingSpringWithDamping:0.2
              initialSpringVelocity:0.8
                            options:0
                         animations:^{
                             angle = angle + M_PI_2;
                             self.basketBallView.transform = CGAffineTransformMakeRotation(angle);
                         } completion:nil];
        
    }
    
}

- (void) userDidTap: (UIGestureRecognizer *) tap {
    
    if (tap.state == UIGestureRecognizerStateRecognized) {
        
        CGPoint newCenter = [tap locationInView:self.basketCourtView];
        // Default + EaseInOut animation options
        UIViewAnimationOptions options = UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut;
        
        // Translation (1 sec)
        [UIView animateWithDuration:1
                              delay:0
                            options:options
                         animations:^{
                             self.basketBallView.center = newCenter;
                         } completion:nil];
        
        // Rotation (0.5 sec)
        [UIView animateWithDuration:0.5
                              delay:0
                            options:options
                         animations:^{
                             self.basketBallView.transform = CGAffineTransformMakeRotation(M_PI);
                         } completion:^(BOOL finished) {
                             // Return to initial rotation
                             [UIView animateWithDuration:0.5
                                                   delay:0
                                                 options:options
                                              animations:^{
                                                  self.basketBallView.transform = CGAffineTransformIdentity;
                                              } completion:nil];
                         }];
        
    }
    
}

@end
