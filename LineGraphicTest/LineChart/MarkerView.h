//
//  MarkerView.h
//  LineGraphicTest
//
//  Created by yehengjia on 2015/7/31.
//  Copyright (c) 2015年 mitake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarkerView : UIImageView

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *message1;

@property (nonatomic, strong) NSString *message2;

//! 提示框文字顏色
@property (nonatomic, strong) UIColor *tipTextColor;

-(void) setTipTextColor:(UIColor *)tipTextColor;

@end
