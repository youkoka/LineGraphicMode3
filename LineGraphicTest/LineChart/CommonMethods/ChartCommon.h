//
//  ChartCommon.h
//  LineGraphicTest
//
//  Created by yehengjia on 2015/3/27.
//  Copyright (c) 2015年 mitake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface ChartCommon : NSObject

+ (void)drawPoint:(CGContextRef)context point:(CGPoint)point color:(UIColor *)color;
+ (void)drawLine:(CGContextRef)context startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint lineColor:(UIColor *)lineColor width:(CGFloat)width;

+(void)drawRect:(CGContextRef)context rect:(CGRect)rectangle lineColor:(UIColor *)lineColor fillColor:(UIColor *)rectColor;
/*
+ (void)drawText:(CGContextRef)context text:(NSString*)text point:(CGPoint)point color:(UIColor *)color font:(UIFont*)font textAlignment:(NSTextAlignment)textAlignment;
+ (void)drawText2:(CGContextRef)context text:(NSString*)text color:(UIColor *)color fontSize:(CGFloat)fontSize;
*/
@end
