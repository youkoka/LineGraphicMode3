//
//  ChartBaseView.h
//  LineGraphicTest
//
//  Created by yehengjia on 2015/7/23.
//  Copyright (c) 2015年 mitake. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "MarkerView.h"

typedef NS_ENUM(NSInteger, LineDrawType)
{
    //! 無線條
    LineDrawTypeNone = 0,
    
    //! 實線
    LineDrawTypeDashLine,
    
    //! 虛線
    LineDrawTypeDottedLine,
    
};

@interface ChartBaseView : UIView<UIGestureRecognizerDelegate>

@property (readonly) UIEdgeInsets edgeInset;

//! 2個 Y 軸
//! default value : NO
@property BOOL isMultipleY;

//! X 軸虛線
//! default value : LineDrawTypeNone
@property LineDrawType drawLineTypeOfX;

//! Y 軸虛線
//! default value : LineDrawTypeNone
@property LineDrawType drawLineTypeOfY;

//! X 軸刻度間距值
@property CGFloat xPreStepValue;

//! Y1/2 軸刻度間距值
@property CGFloat y1PreStepValue;
@property CGFloat y2PreStepValue;

//! 線圖繪圖區塊原始寬度
@property CGFloat drawOriginContentWidth;

//! 線圖繪圖區塊原始高度
@property CGFloat drawOriginContentHeight;

//! 線圖繪圖區塊寬度
@property CGFloat drawContentWidth;

//! 線圖繪圖區塊高度
@property CGFloat drawContentHeight;

//! 原點
@property(readonly) CGPoint originPoint;

//! X軸最遠點
@property(readonly) CGPoint rightBottomPoint;

//! 左Y軸最遠點
@property(readonly) CGPoint leftTopPoint;

//! 右Y軸最遠點
@property(readonly) CGPoint rightTopPoint;

//! 畫面位移值
@property(readonly) CGPoint contentScroll;

//! 上一次點擊點
@property(readonly) CGPoint previousLocation;

//! 目前點擊點
@property(readonly) CGPoint tapLocation;

//! 資料
@property (nonatomic, strong) NSArray *dataSourceAry;

//! x軸顯示文字
@property (nonatomic, strong) NSArray *lineLabelAry;

@property (nonatomic, strong) UIColor *tipTextColor;
@property (nonatomic, strong) UIColor *tipLineColor;

//! 是否顯示提示框
@property BOOL isShowTipLine;

//! 縮放至螢幕大小
@property BOOL isScaleToView;

//! 是否使用者操作動作(移動, 縮放)
@property BOOL isEnableUserAction;

//! Y 軸上 X 軸(虛)線數量(不含軸線)
@property (readonly) NSInteger xLineCount;
@property NSInteger yLineCount;

@property NSInteger xDrawLineCount;
@property NSInteger yDrawLineCount;

//! 軸線間隔大小
@property(readonly) CGFloat xPerStepWidth;
@property(readonly) CGFloat yPerStepHeight;

//! 是否顯示座標點
@property BOOL isShowAnchorPoint;

//! 縮放比例大小(預設值:1)
@property CGFloat zoomScale;

//! 折線間隔值
@property (nonatomic, strong) NSMutableArray *xArray;
@property (nonatomic, strong) NSMutableArray *y1Array;

//! 依據畫面大小更新相關點的資訊
-(void) updateViewWithFrame:(CGRect)frame;

//! 依據畫面大小重設相關點的資訊
-(void) resetViewWithFrame:(CGRect)frame;

@end
