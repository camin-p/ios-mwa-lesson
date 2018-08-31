//
//  detailViewController.m
//  MyLesson
//
//  Created by Maxile on 31/8/2561 BE.
//  Copyright © 2561 Maxile. All rights reserved.
//

#import "detailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface detailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;

@end

@implementation detailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_titleLbl setText:_titleTxt];
    [_titleLbl sizeToFit];
    [_mainImage setContentMode:UIViewContentModeScaleAspectFit];
    [_mainImage sd_setImageWithURL:_cover_picture];
    [[_webView scrollView] setBounces:false];
    [_webView setDelegate:self];
    [_webView loadHTMLString:_newsTxt baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    webView.frame = frame;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
