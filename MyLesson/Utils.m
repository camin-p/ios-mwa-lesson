//
//  Utils.m
//  MWA onMobile
//
//  Created by Camin Puttisopongul on 7/17/17.
//  Copyright © 2017 Watcharapol Sakolchai. All rights reserved.
//

#import "Utils.h"
#import "BundleLanguage.h"
#import "AppDelegate.h"
@implementation Utils
+ (NSString*) getStatusMessageLang{
    NSString* lang = [Utils getCurrentLanguage];
    if ([lang isEqualToString:ENGLISH_LANG])
    {
        return @"STATUSMESSAGEEN";
    }
    else
    {
        return @"STATUSMESSAGETH";
    }
}
+(NSString*) getCurrentLanguage{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSString *currentLanguageKey = @"currentLanguage";
    NSString * language = nil;
    if ([preferences objectForKey:currentLanguageKey] == nil)
    {
        NSLocale *locale = NSLocale.currentLocale;
        NSString *langCode = [locale objectForKey:NSLocaleLanguageCode];
        
        return langCode;
    }
    else
    {
        language = [preferences stringForKey:currentLanguageKey];
    }
    return language;
}
+(void) setCurrentLanguage:(NSString*) language{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSString *currentLanguageKey = @"currentLanguage";
    [preferences setValue:language forKey:currentLanguageKey];
    NSString*_2lang = [language substringWithRange:NSMakeRange(0, 2)];
    
    [preferences setObject:[NSArray arrayWithObjects:_2lang, nil] forKey:@"AppleLanguages"];
    [preferences synchronize];
    [NSBundle setLanguage:language];
    dispatch_async(dispatch_get_main_queue(), ^(void){
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSString *storyboardName = @"Main";
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
        delegate.window.rootViewController = [storyboard instantiateInitialViewController];
    });
    
}

@end
