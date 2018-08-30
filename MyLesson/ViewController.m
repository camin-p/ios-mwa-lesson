//
//  ViewController.m
//  MyLesson
//
//  Created by Maxile on 29/8/2561 BE.
//  Copyright © 2561 Maxile. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "cardView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *cardView1;
@property (weak, nonatomic) IBOutlet UIButton *mainBtn;
@property (weak, nonatomic) IBOutlet cardView *cardView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_mainBtn layer].cornerRadius=10;
    [_mainBtn setClipsToBounds:NO];
    [[_mainBtn layer] setShadowColor:[UIColor blackColor].CGColor];
    [[_mainBtn layer] setShadowOpacity:0.24];
    [[_mainBtn layer]setShadowRadius:2];
    [[_mainBtn layer] setShadowOffset:CGSizeMake(0, 2)];
    
    [_cardView1 setClipsToBounds:NO];
    [[_cardView1 layer] setShadowColor:[UIColor blackColor].CGColor];
    [[_cardView1 layer] setShadowOpacity:0.24];
    [[_cardView1 layer]setShadowRadius:2];
    [[_cardView1 layer] setShadowOffset:CGSizeMake(0, 2)];
    
    [_cardView2 titleLbl].text = @"Hello World";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
