//
//  LineChart.m
//  LineGraphicTest
//
//  Created by yehengjia on 2015/3/27.
//  Copyright (c) 2015年 mitake. All rights reserved.
//

#import "LineChart.h"
#import "ChartCommon.h"

//! 外框與內圖位移差距
/*
#define kOffsetTop      10
#define kOffsetBottom   40
#define kOffsetLeft     40
#define kOffsetRight    10
*/
#define kOffsetTop      0
#define kOffsetBottom   0
#define kOffsetLeft     0
#define kOffsetRight    0

@interface LineChart()

@property (nonatomic, strong) LineChartView *lineChartContent;

@end

@implementation LineChart

#if !__has_feature(objc_arc)

-(void) dealloc
{
    OBJC_RELEASE(self.lineChartContent);
    OBJC_RELEASE(self.sXAxis);
    OBJC_RELEASE(self.sYAxis);
    OBJC_RELEASE(self.dataSourceAry);

    [super dealloc];
}

#endif

-(id) initWithFrame:(CGRect)frame dataSource:(NSMutableArray *)dataSourceAry
{
    if ( (self = [super initWithFrame:frame]) ) {
        
        [self setBackgroundColor:[UIColor redColor]];
        
        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(kOffsetTop, kOffsetLeft, kOffsetBottom, kOffsetRight);
        
        self.dataSourceAry = dataSourceAry;
        
        CGFloat xPos = edgeInsets.left;
        CGFloat yPos = edgeInsets.top;
        CGFloat width = frame.size.width - edgeInsets.left - edgeInsets.right;
        CGFloat height = frame.size.height - edgeInsets.top - edgeInsets.bottom;
        
        CGRect contentframe = CGRectMake(xPos, yPos, width, height);
        self.lineChartContent = [[LineChartView alloc] initWithFrame:contentframe dataSource:self.dataSourceAry];
        [self addSubview:self.lineChartContent];
        [self.lineChartContent release];
        

        /*
        UILabel *lbXAxis = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width / 2 - 50 - edgeInsets.right, height + edgeInsets.top, 100, 40)];
        lbXAxis.backgroundColor = [UIColor clearColor];
        lbXAxis.text = @"筆數";
        lbXAxis.numberOfLines = 0;
        lbXAxis.textAlignment = NSTextAlignmentCenter;
        lbXAxis.font = [UIFont fontWithName:@"Helvetica" size:[UIFont systemFontSize]];
        [self addSubview:lbXAxis];
        [lbXAxis release];
        
        UILabel *lbYAxis = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height / 2 - 50, 40, 100)];
        lbYAxis.backgroundColor = [UIColor clearColor];
        lbYAxis.text = @"BMI\n值";
        lbYAxis.numberOfLines = 0;
        lbYAxis.textAlignment = NSTextAlignmentCenter;
        lbYAxis.font = [UIFont fontWithName:@"Helvetica" size:[UIFont systemFontSize]];
        [self addSubview:lbYAxis];
        [lbYAxis release];
         */
    }
    
    return self;
}

//! 設定方向轉向
-(void) setOrienation:(UIInterfaceOrientation)orientation
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(kOffsetTop, kOffsetLeft, kOffsetBottom, kOffsetRight);
    
    CGFloat xPos = edgeInsets.left;
    CGFloat yPos = edgeInsets.top;
    CGFloat width = self.frame.size.width - edgeInsets.left - edgeInsets.right;
    CGFloat height = self.frame.size.height - edgeInsets.top - edgeInsets.bottom;
    
    CGRect contentframe = CGRectMake(xPos, yPos, width, height);

    self.lineChartContent.frame = contentframe;
    
    [self.lineChartContent updateViewByOrientation:orientation];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*
- (void)drawRect:(CGRect)rect {

}
*/

@end
