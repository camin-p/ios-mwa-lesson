//
//  NSObject+NSDictionaryJsonHelper.m
//  MWA onMobile
//
//  Created by Maxile on 26/4/2561 BE.
//  Copyright © 2561 Watcharapol Sakolchai. All rights reserved.
//

#import "NSObject+NSDictionaryJsonHelper.h"

@implementation NSObject (NSDictionaryJsonHelper)
-(NSString*) bv_jsonStringWithPrettyPrint:(BOOL) prettyPrint {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:(NSJSONWritingOptions)    (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}
@end
