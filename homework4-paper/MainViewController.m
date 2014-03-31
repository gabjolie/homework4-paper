//
//  MainViewController.m
//  homework4-paper
//
//  Created by Gabriele Angeline on 3/29/14.
//  Copyright (c) 2014 Gabriele Angeline. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *headlineImageView;
@property (weak, nonatomic) IBOutlet UIView *headlineView;
@property (weak, nonatomic) IBOutlet UIImageView *newsView;

- (IBAction)onPanGesture:(UIPanGestureRecognizer *)sender;
- (IBAction)onPanNews:(UIPanGestureRecognizer *)sender;

@end

@implementation MainViewController

{
    CGPoint startTouch;
    CGPoint startPosition;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPanGesture:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint location = [panGestureRecognizer locationInView:self.view];
    CGPoint velocity = [panGestureRecognizer velocityInView:self.view];
    //CGPoint translation = [panGestureRecognizer translationInView:self.view];
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        startTouch = location;
        startPosition = self.headlineView.frame.origin;
        NSLog(@"Gesture began at: %@", NSStringFromCGPoint(location));
        NSLog(@"Start position at: %@", NSStringFromCGPoint(startPosition));
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        NSLog(@"Gesture changed: %@", NSStringFromCGPoint(location));
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGRect frame = self.headlineView.frame;
            frame.origin.y = startPosition.y + location.y - startTouch.y;
            self.headlineView.frame = frame;
            NSLog(@"Translation at: %f", location.y - startTouch.y); //how much you move after the begin touch
        } completion:nil];
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"Gesture ended: %@", NSStringFromCGPoint(location));
        if (velocity.y > 0) { //down
            //CGPoint location = CGPointMake(160, 810);
            [UIView animateWithDuration:1 animations:^{
                CGPoint location = CGPointMake(160, 810);
                self.headlineView.center = location;
            }];
        } else if (velocity.y < 0) { //up
            
            [UIView animateWithDuration:1 animations:^{
                CGPoint location = CGPointMake(160, 284);
                self.headlineView.center = location;
            }];
        }
    }
    
}


- (IBAction)onPanNews:(UIPanGestureRecognizer *)panGestureRecognizerNews {
    CGPoint location = [panGestureRecognizerNews locationInView:self.view];
    //CGPoint velocity = [panGestureRecognizer velocityInView:self.view];
    
    [self.newsView addGestureRecognizer:panGestureRecognizerNews];

    //self.headlineImageView.center = point;
    
    if (panGestureRecognizerNews.state == UIGestureRecognizerStateBegan) {
        NSLog(@"News Gesture began at: %@", NSStringFromCGPoint(location));
    } else if (panGestureRecognizerNews.state == UIGestureRecognizerStateChanged) {
        NSLog(@"News Gesture changed: %@", NSStringFromCGPoint(location));
    } else if (panGestureRecognizerNews.state == UIGestureRecognizerStateEnded) {
        NSLog(@"News Gesture ended: %@", NSStringFromCGPoint(location));
            }
}

@end
