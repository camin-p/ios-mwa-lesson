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
#import <SDWebImage/UIImageView+WebCache.h>
#include "progressTableViewCell.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "detailViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *cardView1;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *mainBtn;
@property (weak, nonatomic) IBOutlet cardView *cardView2;
@property (strong, nonatomic) MBProgressHUD* hud;
@property (nonatomic, strong) NSArray* newsItem;
@property (assign) bool isLoading;
@property(nonatomic, strong) NSString* lastDateTime;
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
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.labelText = @"Loading";
    
    
    
    _newsItem = @[];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]];
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
    [_tableView setBackgroundColor:[UIColor clearColor]];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_hud show:YES];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    
    NSString *string = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)year, (long)month, (long)day];
    [self loadNews:string];
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
    if ([[Utils getCurrentLanguage] isEqualToString:@"en"]) {
        [Utils setCurrentLanguage:@"th"];
    }else{
        [Utils setCurrentLanguage:@"en"];
    }
    
    
}

-(void) loadNews:(NSString*) requestDate{
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"https://www.mwa.co.th/eServiceNews.php?requestDateTime=%@",requestDate]] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:300];
    [request setHTTPMethod:@"GET"];
    NSURLSessionConfiguration* conf = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:conf];
    NSURLSessionDataTask * task = [session dataTaskWithRequest:request completionHandler:^(NSData* data,NSURLResponse*response, NSError*error){
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *NewsList = [jsonObject objectForKey:@"new_list"];
        NSMutableArray*arr = [NSMutableArray arrayWithArray:self->_newsItem];
        long index = [self->_newsItem count]-1;
        if ([self->_newsItem count]>0)
        {
            if ([[self->_newsItem objectAtIndex:index] objectForKey:@"isLoading"]) {
                [arr removeObjectAtIndex:index];
            }
        }
        
        for (NSDictionary*dict in NewsList) {
            [arr addObject:dict];
        }
        self->_newsItem = arr;
        NSDictionary *lastNews = [NewsList objectAtIndex:[NewsList count]-1];
        self->_lastDateTime = [NSString stringWithFormat:@"%@%@%@",
                        lastNews[@"pubDate"],
                        @"%20",
                        lastNews[@"pubTime"]]; dispatch_async(dispatch_get_main_queue(), ^(void){
            [self->_tableView reloadData];
            [self->_hud hide:YES];
            _isLoading=false;
        });
        
        
        
    }];
    [task resume];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_newsItem count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary* data = [_newsItem objectAtIndex:indexPath.row];
    if ([data objectForKey:@"isLoading"]) {
        return 30;
    }else{
        return 120;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary* data = [_newsItem objectAtIndex:indexPath.row];
    
    if ([data objectForKey:@"isLoading"]) {
    }else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        detailViewController* detail = [storyboard instantiateViewControllerWithIdentifier:@"detailVCId"];
        [detail setTitleTxt:data[@"title"]];
        [detail setNewsTxt:data[@"news"]];
        [detail setCover_picture:data[@"cover_picture"]];
        
        [self.navigationController pushViewController:detail animated:YES];
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary* data = [_newsItem objectAtIndex:indexPath.row];
    if ([data objectForKey:@"isLoading"]) {
        progressTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"progressCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[progressTableViewCell alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }else{
        customTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
        
        if (!cell) {
            cell = [[customTableViewCell alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        //cell.imageView.image = nil;
        //[cell.imageView sd_setImageWithURL:[NSURL URLWithString:data[@"cover_picture"]]];
        [cell.cardView.imageView sd_setImageWithURL:[NSURL URLWithString:data[@"cover_picture"]]];
        
        
        cell.cardView.titleLbl.text = data[@"title"];
        cell.cardView.detailLbl.text = data[@"news"];
        return cell;
    }
    
}
-(void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    if (!_isLoading) {
        CGPoint offset = aScrollView.contentOffset;
        CGRect bounds = aScrollView.bounds;
        CGSize size = aScrollView.contentSize;
        UIEdgeInsets inset = aScrollView.contentInset;
        float y = offset.y + bounds.size.height - inset.bottom;
        float h = size.height;
        float reload_distance = 50;
        if(y > h - reload_distance) {
            _isLoading = true;
            NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:_newsItem];
            [arr addObject:@{@"isLoading":@"1"}];
            _newsItem = arr;
            [_tableView reloadData];
            [_hud show:YES];
            [self loadNews:_lastDateTime];
        }
    }
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"MainBtnOpen"]) {
        detailViewController*detailVC = [segue destinationViewController];
    }
}
@end
