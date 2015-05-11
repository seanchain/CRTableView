//
//  ViewController.m
//  CRTableView
//
//  Created by Sean Chain on 3/12/15.
//  Copyright (c) 2015 Sean Chain. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, retain) NSMutableArray *rowsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *stunumber = @"2013141463163";
    NSString *passwd = @"******";
    NSString *info = @"allsem";
    NSString *urlstr = [NSString stringWithFormat:@"http://www.chensihang.com/iostest/iosjwc.php?zjh=%@&mm=%@&scorechecktype=%@", stunumber, passwd, info];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSString *response = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@", response);
    NSData *jsonData = [response dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@", jsonObject);
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat barh = statusBarFrame.size.height;
    ASFTableView *mytableview = [[ASFTableView alloc] initWithFrame:CGRectMake(0, barh, self.view.frame.size.width, self.view.frame.size.height - barh)];
    mytableview.backgroundColor = [UIColor colorWithRed:0.0f green:91.0f/255 blue:171.0f/255 alpha:1.0];
    [self.view addSubview:mytableview];
    NSArray *cols = @[@"课程号",@"课程名",@"学分",@"成绩"];
    NSArray *weights = @[@(0.30f),@(0.42f),@(0.13f),@(0.15f)];
    NSDictionary *options = @{kASF_OPTION_CELL_TEXT_FONT_SIZE : @(13),
                              kASF_OPTION_CELL_TEXT_COLOR:[UIColor whiteColor],
                              kASF_OPTION_CELL_TEXT_FONT_BOLD : @(true),
                              kASF_OPTION_CELL_BORDER_COLOR : [UIColor whiteColor],
                              kASF_OPTION_CELL_BORDER_SIZE : @(0.5),
                              kASF_OPTION_BACKGROUND : [UIColor colorWithRed:18/255.0 green:62/255.0 blue:120/255.0 alpha:1.0]};
    
    // [mytableview setDelegate:self];
    [mytableview setBounces:NO];
    [mytableview setSelectionColor:nil];
    // [mytableview setSelectionColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0f]];
    [mytableview setTitles:cols
                  WithWeights:weights
                  WithOptions:options
                    WitHeight:32 Floating:YES];
    
    [_rowsArray removeAllObjects];
    for (int i=0; i < [jsonObject count] - 1; i++) {
        [_rowsArray addObject:@{
                                kASF_ROW_ID :
                                    @(i),
                                
                                kASF_ROW_CELLS :
                                    @[@{kASF_CELL_TITLE : jsonObject[i][0], kASF_OPTION_CELL_TEXT_ALIGNMENT : @(NSTextAlignmentCenter)},
                                      @{kASF_CELL_TITLE : jsonObject[i][1],kASF_OPTION_CELL_TEXT_ALIGNMENT : @(NSTextAlignmentCenter)},
                                      @{kASF_CELL_TITLE : jsonObject[i][2], kASF_OPTION_CELL_TEXT_ALIGNMENT : @(NSTextAlignmentCenter)},
                                      @{kASF_CELL_TITLE : [jsonObject[i][4] stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""], kASF_OPTION_CELL_TEXT_ALIGNMENT : @(NSTextAlignmentCenter)}],
                                
                                kASF_ROW_OPTIONS :
                                    @{kASF_OPTION_BACKGROUND : (i % 2 == 0 ? [UIColor whiteColor]:[UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1]),
                                      kASF_OPTION_CELL_TEXT_FONT_SIZE: @(12),
                                      kASF_OPTION_CELL_PADDING : @(4),
                                      kASF_OPTION_CELL_BORDER_SIZE: @(0.5),
                                      kASF_OPTION_CELL_BORDER_COLOR : [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1]}}];
    }
    
    [mytableview setRows:_rowsArray];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        _rowsArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
