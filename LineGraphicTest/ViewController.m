//
//  ViewController.m
//  LineGraphicTest
//
//  Created by yehengjia on 2015/3/27.
//  Copyright (c) 2015年 mitake. All rights reserved.
//

#import "ViewController.h"

#import "LineChartView.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *dataSourceAry;

@property (nonatomic, strong) LineChartView *lineChartView;

@end

@implementation ViewController

#if !__has_feature(objc_arc)

-(void) dealloc
{
    OBJC_RELEASE(self.lineChartView);
    
    [super dealloc];
    
}

#endif
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.dataSourceAry = [NSMutableArray array];
    
    NSMutableArray *labelAry = [NSMutableArray array];
    
    for (int i = 0; i != 10; i++) {
        
        AnchorItem *item = [[[AnchorItem alloc] init] autorelease];
        NSInteger xVal = i * 2 + 1200;
        
        item.xValue = [NSString stringWithFormat:@"%ld", xVal];
        item.y1Value = 10 + (rand() % 100) * 0.01;
        item.y2Value = 8 + (rand() % 100) * 0.01;
//        item.isShowYAxisLine = (xVal % 1200) == 0 ? YES : NO;
        item.dicDataSource = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%@,%f", item.xValue, item.y1Value] forKey:@"value"];
        [self.dataSourceAry addObject:item];
        
        [labelAry addObject:[NSString stringWithFormat:@"%@/%f", item.xValue, item.y1Value]];
    }

    CGRect rect = CGRectMake(5, 40,
                             self.view.frame.size.width - 5 - 5,
                             300);
    
    self.lineChartView = [[[LineChartView alloc] initWithFrame:rect] autorelease];
    self.lineChartView.drawLineTypeOfY = LineDrawTypeNone;
    self.lineChartView.drawLineTypeOfX = LineDrawTypeDottedLine;
    self.lineChartView.isEnableUserAction = YES;
    self.lineChartView.isShowTipLine = YES;
    self.lineChartView.isShowAnchorPoint = YES;
    self.lineChartView.xLineCount = [self.dataSourceAry count];
    self.lineChartView.yLineCount = 10;
    self.lineChartView.zoomScaleMax = 1.5;
    self.lineChartView.backgroundColor = [UIColor blackColor];
    self.lineChartView.tipLineColor = [UIColor whiteColor];
    self.lineChartView.tipTextColor = [UIColor whiteColor];
    self.lineChartView.xAxisLineColor = [UIColor whiteColor];
    self.lineChartView.yAxisLineColor = [UIColor whiteColor];
    self.lineChartView.xLineColor = [UIColor whiteColor];
    self.lineChartView.yLineColor = [UIColor whiteColor];
    self.lineChartView.xTextColor = [UIColor whiteColor];
    self.lineChartView.yTextColor = [UIColor whiteColor];
    
//    self.lineChartView.lineLabelAry = labelAry;
    [self.lineChartView setDataSource:self.dataSourceAry];
    [self.view addSubview:self.lineChartView];
    
}

-(BOOL) shouldAutorotate
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    CGRect rect;
    
    switch (orientation) {
            
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            rect = CGRectMake(5, 40,
                              self.view.frame.size.width - 5 - 5,
                              300);
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
        {
            rect = CGRectMake(5, 10,
                              self.view.frame.size.width - 5 - 5,
                              300);
        }
            break;
        default:
            break;
    }
    
    [self.lineChartView resetViewByOrientationWithFrame:rect];

    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
