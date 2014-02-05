//
//  OutletSegue.m
//  SlidingContollers
//
//  Created by Peter Gulyas on 2/5/2014.
//  Copyright (c) 2014 Peter Gulyas. All rights reserved.
//

#import "DATOutletSegue.h"
#import<objc/runtime.h>

@implementation DATOutletSegue

-(id) initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination{
    self = [super initWithIdentifier:identifier source:source destination:destination];
    if (self){
       
    }
    return self;
}


-(void) perform{
    id value = [self.sourceViewController valueForKey:self.identifier];
    if (value == nil){
        [self.sourceViewController setValue:self.destinationViewController forKey:self.identifier];
    }else{
        NSLog(@"%@ is already loaded", self.identifier);
    }
}


@end

@implementation UIViewController (OutletSegue)

-(void) loadSegueControllers{
    
    unsigned int propertiesCount;
    objc_property_t *classPropertiesArray = class_copyPropertyList([self class], &propertiesCount);
    
    NSSet* excludePropertiesFromLoadSegueControllers = [[self class] excludePropertiesFromLoadSegueControllers];
    
    for (unsigned int ii = 0; ii < propertiesCount; ii++){
        objc_property_t property = classPropertiesArray[ii];
        NSArray *attrPairs = [[NSString stringWithUTF8String: property_getAttributes(property)] componentsSeparatedByString: @","];
        NSString* name = [NSString stringWithUTF8String: property_getName(property)];
        if ([excludePropertiesFromLoadSegueControllers containsObject:name]){
            continue;
        }
        
        NSString* type = [attrPairs firstObject];
        if ([type hasPrefix:@"T@"]){
            type = [type substringWithRange:NSMakeRange(3, type.length - 4)];
            id cls = NSClassFromString(type);
            if ([cls isSubclassOfClass:[UIViewController class]]){
                
                @try {
                    [self performSegueWithIdentifier:name sender:self];
                    NSLog(@"Loaded %@", name);
                }
                @catch (NSException *exception) {
                    
                }
                @finally {
                    
                }
            }
        }
    }
    free(classPropertiesArray);
}

+(NSSet*) excludePropertiesFromLoadSegueControllers{
    return nil;
}

@end