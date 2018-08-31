//
//  cardView.m
//  MyLesson
//
//  Created by Maxile on 29/8/2561 BE.
//  Copyright © 2561 Maxile. All rights reserved.
//

#import "cardView.h"
#import <QuartzCore/QuartzCore.h>

@implementation cardView
-(instancetype)init{
    self = [super init];
    if (self) {
        UIView* v = [self loadFromNib];
        v.frame = self.bounds;
        [self addSubview:v];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        UIView* v = [self loadFromNib];
        v.frame = self.bounds;
        [self addSubview:v];
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView* v = [self loadFromNib];
        v.frame = self.bounds;
        [self addSubview:v];
        
    }
    return self;
}
-(UIView*) loadFromNib{
    NSBundle* bundle = [NSBundle bundleForClass:[self class]];
    UINib *nib = [UINib nibWithNibName:@"cardView" bundle:bundle];
    return [nib instantiateWithOwner:self options:nil].firstObject;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

*/
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self setClipsToBounds:NO];
    [[self layer] setShadowColor:[UIColor blackColor].CGColor];
    [[self layer] setShadowOpacity:0.24];
    [[self layer]setShadowRadius:2];
    [[self layer] setShadowOffset:CGSizeMake(0, 2)];
    
    [[self imageView] setContentMode:UIViewContentModeScaleAspectFit];
    [[self imageView] setClipsToBounds:YES];
}
@end
