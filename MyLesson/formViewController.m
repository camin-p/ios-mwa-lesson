//
//  formViewController.m
//  MyLesson
//
//  Created by Maxile on 31/8/2561 BE.
//  Copyright © 2561 Maxile. All rights reserved.
//

#import "formViewController.h"

@interface formViewController ()
@property (weak, nonatomic) IBOutlet UITextField *locationTxt;
@property (weak, nonatomic) IBOutlet UITextField *telTxt;
@property (weak, nonatomic) IBOutlet UITextField *detailTxt;

@property (nonatomic,strong) UITapGestureRecognizer *tap;
- (IBAction)submit:(id)sender;

@end

@implementation formViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboardAction)];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}
-(void) hideKeyboardAction{
    [[self view]endEditing:YES];
}
- (void)keyboardDidShow: (NSNotification *) notif{
    
    [[self view] addGestureRecognizer:_tap];
}
- (void)keyboardDidHide: (NSNotification *) notif{
    
    [[self view] removeGestureRecognizer:_tap];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submit:(id)sender {
    NSString* tel = _telTxt.text;
    NSString* location = _locationTxt.text;
    NSString* detail = _detailTxt.text;
    ;
}
@end
