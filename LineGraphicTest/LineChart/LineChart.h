//
//  LineChart.h
//  LineGraphicTest
//
//  Created by yehengjia on 2015/3/27.
//  Copyright (c) 2015年 mitake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineChartView.h"
#import "Constants.h"

@interface LineChart : UIView

@property (nonatomic, strong) NSString *sXAxis;
@property (nonatomic, strong) NSString *sYAxis;

@property (nonatomic, strong) NSMutableArray *dataSourceAry;

-(id) initWithFrame:(CGRect)frame dataSource:(NSMutableArray *)dataSourceAry;

//! 設定方向轉向
-(void) setOrienation:(UIInterfaceOrientation)orientation;

@end
