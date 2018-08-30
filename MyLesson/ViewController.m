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
#import "Utils.h"
#import "customTableViewCell.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *cardView1;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *mainBtn;
@property (weak, nonatomic) IBOutlet cardView *cardView2;
- (IBAction)switchLanguage:(id)sender;
@end

@implementation ViewController
-(instancetype)init{
    self =[super init];
    if (self) {
        
    }
    return self;
}
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
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    
}
- (void)viewDidDisappear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)switchLanguage:(id)sender {
    [Utils setCurrentLanguage:@"en"];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    customTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[customTableViewCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.cardView.titleLbl.text = @"Table View";
    return cell;
}
@end
