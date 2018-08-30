//
//  Utils.h
//  MWA onMobile
//
//  Created by Camin Puttisopongul on 7/17/17.
//  Copyright © 2017 Watcharapol Sakolchai. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ENGLISH_LANG @"en-US"
#define THAI_LANG @"th-TH"

@interface Utils : NSObject
+(NSString*) getCurrentLanguage;
+(void) setCurrentLanguage:(NSString*) language;
+ (NSString*) getStatusMessageLang;
@end
