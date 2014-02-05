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

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadSegueControllers];
    
    
    [self addChildViewController:self.topController];
    [self addChildViewController:self.bottomController];
    
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
    CGRect bounds = self.view.bounds;
    CGRect topRect = bounds;
    topRect.size.height /=2.0;
    self.topController.view.frame = topRect;
    
    CGRect bottomRect = bounds;
    bottomRect.origin.y = CGRectGetMaxY(topRect);
    bottomRect.size.height /=2.0;
    
    self.bottomController.view.frame = bottomRect;
    
    
    
}

@end
