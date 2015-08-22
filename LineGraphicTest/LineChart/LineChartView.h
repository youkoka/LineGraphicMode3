//
//  LineChartContentView.h
//  LineGraphicTest
//
//  Created by yehengjia on 2015/3/27.
//  Copyright (c) 2015年 mitake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnchorView.h"
#import "ChartBaseView.h"

@interface LineChartView : ChartBaseView<AnchorDelefate>

//! x軸虛線/實線顏色
@property (nonatomic, strong) UIColor *xLineColor;
//! x軸標籤顏色
@property (nonatomic, strong) UIColor *xTextColor;
//! x軸顏色
@property (nonatomic, strong) UIColor *xAxisLineColor;

//! y軸虛線/實線顏色
@property (nonatomic, strong) UIColor *yLineColor;
//! y軸標籤顏色
@property (nonatomic, strong) UIColor *yTextColor;
//! y軸顏色
@property (nonatomic, strong) UIColor *yAxisLineColor;

//! 折線顏色
@property (nonatomic, strong) UIColor *dataSourceLine1Color;
@property (nonatomic, strong) UIColor *dataSourceLine2Color;

-(id) initWithFrame:(CGRect)frame;

-(void) setDataSource:(NSArray *) dataSource;

-(void) resetViewByOrientationWithFrame:(CGRect) frame;

@end
