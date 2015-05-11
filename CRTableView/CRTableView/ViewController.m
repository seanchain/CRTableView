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
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat barh = statusBarFrame.size.height;
    ASFTableView *mytableview = [[ASFTableView alloc] initWithFrame:CGRectMake(0, barh, self.view.frame.size.width, self.view.frame.size.height)];
    mytableview.backgroundColor = [UIColor blueColor];
    [self.view addSubview:mytableview];
    NSArray *cols = @[@"Person ID",@"Person Name",@"Phone Number",@"Sex"];
    NSArray *weights = @[@(0.15f),@(0.4f),@(0.25f),@(0.2f)];
    NSDictionary *options = @{kASF_OPTION_CELL_TEXT_FONT_SIZE : @(14),
                              kASF_OPTION_CELL_TEXT_FONT_BOLD : @(true),
                              kASF_OPTION_CELL_BORDER_COLOR : [UIColor lightGrayColor],
                              kASF_OPTION_CELL_BORDER_SIZE : @(0.0),
                              kASF_OPTION_BACKGROUND : [UIColor colorWithRed:239/255.0 green:244/255.0 blue:254/255.0 alpha:1.0]};
    
    [mytableview setDelegate:self];
    [mytableview setBounces:NO];
    [mytableview setSelectionColor:[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0f]];
    [mytableview setTitles:cols
                  WithWeights:weights
                  WithOptions:options
                    WitHeight:32 Floating:YES];
    
    [_rowsArray removeAllObjects];
    for (int i=0; i<10; i++) {
        [_rowsArray addObject:@{
                                kASF_ROW_ID :
                                    @(i),
                                
                                kASF_ROW_CELLS :
                                    @[@{kASF_CELL_TITLE : @"Sample ID", kASF_OPTION_CELL_TEXT_ALIGNMENT : @(NSTextAlignmentCenter)},
                                      @{kASF_CELL_TITLE : @"Sample Name", kASF_OPTION_CELL_TEXT_ALIGNMENT : @(NSTextAlignmentLeft)},
                                      @{kASF_CELL_TITLE : @"Sample Phone No.", kASF_OPTION_CELL_TEXT_ALIGNMENT : @(NSTextAlignmentCenter)},
                                      @{kASF_CELL_TITLE : @"Sample Gender", kASF_OPTION_CELL_TEXT_ALIGNMENT : @(NSTextAlignmentCenter)}],
                                
                                kASF_ROW_OPTIONS :
                                    @{kASF_OPTION_BACKGROUND : [UIColor whiteColor],
                                      kASF_OPTION_CELL_PADDING : @(5),
                                      kASF_OPTION_CELL_BORDER_COLOR : [UIColor whiteColor]},
                                
                                @"some_other_data" : @(123)}];
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
