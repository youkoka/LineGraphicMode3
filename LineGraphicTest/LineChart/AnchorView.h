//
//  Ancher.h
//  LineGraphicTest
//
//  Created by yehengjia on 2015/3/30.
//  Copyright (c) 2015年 mitake. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AnchorDelefate <NSObject>

//! 回傳資料
-(void) didSelectAnchorPoint:(NSDictionary *) dicDataSource;

@end

@interface AnchorItem : NSObject

@property CGFloat xValue;
@property CGFloat y1Value;
@property CGFloat y2Value;
@property(nonatomic, strong) NSString *sLabel;

//! 存放資料
@property (nonatomic, strong) NSDictionary *dicDataSource;

@end

@interface AnchorView : UIView

@property (nonatomic, assign) id<AnchorDelefate> anchorDelegate;

@property (nonatomic, assign) UIColor *anchorColor;

//! 存放資料
@property (nonatomic, strong) NSDictionary *dicDataSource;

@end
