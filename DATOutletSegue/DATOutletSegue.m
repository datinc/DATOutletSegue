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

-(void) perform{
    
    if ([self.identifier rangeOfString:@"-"].location != NSNotFound){ // array item
        NSString* identifier = [[self.identifier componentsSeparatedByString:@"-"] firstObject];
        NSArray* value = [self.sourceViewController valueForKey:identifier];
        if (value){
            value = [value arrayByAddingObject:self.destinationViewController];
        }else{
            value = [NSArray arrayWithObject:self.destinationViewController];
        }
        [self.sourceViewController setValue:value forKey:identifier];
    }else{
        id value = [self.sourceViewController valueForKey:self.identifier];
        if (value == nil){
            [self.sourceViewController setValue:self.destinationViewController forKey:self.identifier];
        }else{
            NSLog(@"%@ is already loaded", self.identifier);
        }
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
            } else if ([cls isSubclassOfClass:[NSArray class]]){
                
                NSInteger listSize = [[self class] arrayPropertyListLength:name];
                NSInteger ii = 0;
                @try {
                    for (ii = 0; ii < listSize; ii++){
                        NSString* arrayName = [name stringByAppendingFormat:@"-%d", (int)ii];
                        // This will cause an exception if we have loaded all the controllers
                        // This is to be expected.
                        // If you do not want to see this exception anymore then implment the function +arrayPropertyListLength: to return a value other then NSNotFound
                        [self performSegueWithIdentifier:arrayName sender:self];
                    }
                }@catch (NSException *exception) {
                    if (listSize != NSNotFound){
                        @throw exception;
                    }
                }
                if (ii > 0){
                    NSLog(@"Loaded %d for %@", (int)ii , name);
                }
            }
        }
    }
    free(classPropertiesArray);
}

+(NSSet*) excludePropertiesFromLoadSegueControllers{
    return nil;
}

+(NSInteger) arrayPropertyListLength:(NSString*) propertyName{
    return NSNotFound;
}

@end