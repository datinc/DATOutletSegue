//
//  OutletSegue.h
//  SlidingContollers
//
//  Created by Peter Gulyas on 2/5/2014.
//  Copyright (c) 2014 Peter Gulyas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DATOutletSegue : UIStoryboardSegue

@end

@interface UIViewController (OutletSegue)
-(void) loadSegueControllers;
+(NSSet*) excludePropertiesFromLoadSegueControllers;
+(NSInteger) arrayPropertyListLength:(NSString*) propertyName;

@end