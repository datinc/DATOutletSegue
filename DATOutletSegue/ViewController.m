//
//  ViewController.m
//  DATOutletSegue
//
//  Created by Peter Gulyas on 2/5/2014.
//  Copyright (c) 2014 Peter Gulyas. All rights reserved.
//

#import "ViewController.h"
#import "DATOutletSegue.h"

@interface ViewController ()

@property (nonatomic, strong) UIViewController* topController;
@property (nonatomic, strong) UIViewController* bottomController;
@property (nonatomic, strong) NSArray* viewControllers;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadSegueControllers];
    
    
    [self addChildViewController:self.topController];
    [self addChildViewController:self.bottomController];
    for (UIViewController* viewController in self.viewControllers){
        [self addChildViewController:viewController];
    }
}

-(void) addChildViewController:(UIViewController *)childController{
    if (childController == nil || childController.parentViewController == self || !self.isViewLoaded){
        return;
    }
    
    [super addChildViewController:childController];
    [self.view addSubview:childController.view];
    [childController didMoveToParentViewController:self];
    
    [self.view setNeedsLayout];
}
- (void)viewDidLayoutSubviews
{
    CGFloat barHeight = self.view.bounds.size.width / self.viewControllers.count;
    CGRect bounds = self.view.bounds;
    bounds.size.height -= barHeight;
    
    CGRect topRect = bounds;
    topRect.size.height /=2.0;
    self.topController.view.frame = topRect;
    
    CGRect bottomRect = bounds;
    bottomRect.origin.y = CGRectGetMaxY(topRect) + barHeight;
    bottomRect.size.height /=2.0;
    
    self.bottomController.view.frame = bottomRect;
    
    
    
    CGRect barRect = CGRectMake(0, CGRectGetMaxY(topRect), barHeight, barHeight);
    
    for (UIViewController* viewController in self.viewControllers){
        viewController.view.frame = barRect;
        barRect.origin.x += barRect.size.width;
    }
    
    
}
@end
