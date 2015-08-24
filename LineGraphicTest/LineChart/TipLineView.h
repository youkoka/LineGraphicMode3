//
//  TipLineView.h
//  LineGraphicTest
//
//  Created by yehengjia on 2015/8/10.
//  Copyright (c) 2015年 mitake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TipLineView : UIView

//! 原點
@property(assign) CGPoint originPoint;

//! X軸最遠點
@property(assign) CGPoint rightBottomPoint;

//! 左Y軸最遠點
@property(assign) CGPoint leftTopPoint;

//! 右Y軸最遠點
@property(assign) CGPoint rightTopPoint;

//! 軸線間隔大小
@property(assign) CGFloat xPerStepWidth;
@property(assign) CGFloat yPerStepHeight;

//! 線圖繪圖區塊寬度
@property CGFloat drawContentWidth;

//! 線圖繪圖區塊高度
@property CGFloat drawContentHeight;

//! y軸最大/小值
@property (nonatomic, assign) CGFloat yMax;
@property (nonatomic, assign) CGFloat yMin;

//! 畫面位移值
@property(assign) CGPoint contentScroll;

@property (assign) UIEdgeInsets edgeInset;

//! 提示線顏色
@property (nonatomic, strong) UIColor *tipLineColor;
//! 提示框文字顏色
@property (nonatomic, strong) UIColor *tipTextColor;

//! 資料
@property (nonatomic, strong) NSArray *dataSourceAry;

//! 壓住不放事件
-(void) handleLongTap:(UIGestureRecognizer *) recongizer;

//! 移動事件
-(void) handlePan:(UIPanGestureRecognizer *)recognizer;

//! 縮放事件
-(void) handlePinch:(UIPinchGestureRecognizer*) recognizer;


@end
