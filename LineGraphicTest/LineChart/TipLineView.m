//
//  TipLineView.m
//  LineGraphicTest
//
//  Created by yehengjia on 2015/8/10.
//  Copyright (c) 2015年 mitake. All rights reserved.
//

#import "TipLineView.h"
#import "AnchorView.h"
#import "Constants.h"
#import "ChartCommon.h"
#import "MarkerView.h"
#import "CommentView.h"

@interface TipLineView()

@property (nonatomic, strong) MarkerView *markerView;

//! 顯示提示線
@property(assign) BOOL isShowTipLine;

//! 是否已畫提示線(避免迴圈跑太多次)
@property(assign) BOOL hadDrawTipLine;

//! 目前點擊點
@property(assign) CGPoint tapLocation;

@end

@implementation TipLineView

-(void) dealloc
{
    OBJC_RELEASE(self.dataSourceAry);
    OBJC_RELEASE(self.xArray);
    OBJC_RELEASE(self.y1Array);
    OBJC_RELEASE(self.y2Array);
    OBJC_RELEASE(self.markerView);
    
    OBJC_RELEASE(self.tipLineColor);
    OBJC_RELEASE(self.tipTextColor);
    
    [super dealloc];
}
-(instancetype) init
{
    if ( self = [super init]) {
        
        self.isShowTipLine = YES;
        self.hadDrawTipLine = NO;
        
        self.tipLineColor = [UIColor grayColor];
        self.tipTextColor = [UIColor blackColor];
        
        self.originPoint = CGPointMake(0, 0);
        
        self.dataSourceAry = [NSArray array];
        self.xPerStepWidth = 0.0f;
        self.yPerStepHeight = 0.0f;
        
        self.xArray = [NSMutableArray array];
        self.y1Array = [NSMutableArray array];
        self.y2Array = [NSMutableArray array];

        self.markerView = [[[MarkerView alloc] initWithImage:[UIImage imageNamed:@"marker"]] autorelease];
        [self.markerView setFrame:CGRectMake(0, 0, 80, 40)];
        self.markerView.tipTextColor = self.tipTextColor;
        self.markerView.hidden = YES;
        [self addSubview:self.markerView];
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}
-(instancetype) initWithFrame:(CGRect)frame
{
    if ( self = [super initWithFrame:frame]) {

        self.isShowTipLine = YES;
        self.hadDrawTipLine = NO;
        
        self.tipLineColor = [UIColor grayColor];
        self.tipTextColor = [UIColor blackColor];
        
        self.originPoint = CGPointMake(0, 0);

        self.dataSourceAry = [NSArray array];
        self.xPerStepWidth = 0.0f;
        self.yPerStepHeight = 0.0f;
        
        self.xArray = [NSMutableArray array];
        self.y1Array = [NSMutableArray array];
        self.y2Array = [NSMutableArray array];

        self.markerView = [[[MarkerView alloc] initWithImage:[UIImage imageNamed:@"marker"]] autorelease];
        [self.markerView setFrame:CGRectMake(0, 0, 60, 40)];
        self.markerView.tipTextColor = self.tipTextColor;
        self.markerView.hidden = YES;
        [self addSubview:self.markerView];

        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext();
    
#pragma mark 畫點, 連接線, 指示線
    
    if (self.isShowTipLine == YES) {
        
        CGPoint startAnchorPoint1 = self.originPoint;
        CGPoint endAnchorPoint1 = self.originPoint;
        
        CGPoint startAnchorPoint2 = self.originPoint;
        CGPoint endAnchorPoint2 = self.originPoint;
        
        for (int i = 0; i != [self.dataSourceAry count]; i++) {
        
            if (self.hadDrawTipLine == NO) {
                
                AnchorItem *startItem = [self.dataSourceAry objectAtIndex:i];
                
                float xPerStepVal = [[self.xArray objectAtIndex:0] floatValue];
                float y1PerStepVal = [[self.y1Array objectAtIndex:0] floatValue];
                
                startAnchorPoint1.x = self.originPoint.x + ((self.xPerStepWidth * startItem.xValue) / xPerStepVal) + self.contentScroll.x;
                
//                startAnchorPoint1.x = (_rightBottomPoint.x - _originPoint.x) / (self.xMax - self.xMin) * (startItem.xValue - self.xMin) + self.originPoint.x + self.contentScroll.x;
                
                startAnchorPoint1.y = self.originPoint.y + fabs(((self.yPerStepHeight * startItem.y1Value) / y1PerStepVal)) + self.contentScroll.y;
                
                
                float y2PerStepVal = [[self.y2Array objectAtIndex:0] floatValue];
                
                
//                startAnchorPoint2.x = (_rightBottomPoint.x - _originPoint.x) / (self.xMax - self.xMin) * (startItem.xValue - self.xMin) + self.originPoint.x + self.contentScroll.x;
                
                startAnchorPoint2.y = self.originPoint.y + fabs(((self.yPerStepHeight * startItem.y2Value) / y2PerStepVal)) + self.contentScroll.y;
                
                //! 畫點對點連接線及指示線
                if (i + 1 < [self.dataSourceAry count]) {
                    
                    AnchorItem *endItem = [self.dataSourceAry objectAtIndex:i + 1];
                    
                    float xPerStepVal = [[self.xArray objectAtIndex:0] floatValue];
                    float xPosition = self.originPoint.x + ((self.xPerStepWidth * endItem.xValue) / xPerStepVal) + self.contentScroll.x;
                    
                    float y1PerStepVal = [[self.y1Array objectAtIndex:0] floatValue];
                    float y1Position = self.originPoint.y + fabs(((self.yPerStepHeight * endItem.y1Value) / y1PerStepVal)) + self.contentScroll.y;
                    
                    float y2PerStepVal = [[self.y2Array objectAtIndex:0] floatValue];
                    float y2Position = self.originPoint.y + fabs(((self.yPerStepHeight * endItem.y2Value) / y2PerStepVal)) + self.contentScroll.y;
                    
                    endAnchorPoint1.x = xPosition;
                    endAnchorPoint1.y = y1Position;
                    
                    endAnchorPoint2.x = xPosition;
                    endAnchorPoint2.y = y2Position;
                    
                    CGFloat yPattern[1]= {1};
                    CGContextSetLineDash(context, 0.0, yPattern, 0);
                   
                    CGPoint tipPoint = CGPointMake(0, 0);
                    
                    //! 指示線
                    if (startAnchorPoint1.x <= self.tapLocation.x && endAnchorPoint1.x >= self.tapLocation.x) {
                        
                        if (![startItem.sLabel isEqualToString:@""]) {
                            
                            self.markerView.title = startItem.sLabel;
                        }
                        else {
                            
                            self.markerView.title = [NSString stringWithFormat:@"%.2f", startItem.xValue];
                        }

                        //! 判斷上半部或下半部
                        if (fabs(startAnchorPoint1.x - self.tapLocation.x) <= fabs(endAnchorPoint1.x - self.tapLocation.x) ) {
                            
                            if (fabs(self.tapLocation.y - startAnchorPoint1.y) <= fabs(self.tapLocation.y - startAnchorPoint2.y)) {
                                
                                tipPoint = startAnchorPoint1;
                            }
                            else {
                                
                                tipPoint = startAnchorPoint2;
                            }
                            
                            self.markerView.message1 = [NSString stringWithFormat:@"賣出:%.4f", startItem.y1Value];
                            self.markerView.message2 = [NSString stringWithFormat:@"買入:%.4f", startItem.y2Value];

                        }
                        else {
                            
                            if (![endItem.sLabel isEqualToString:@""]) {
                                
                                self.markerView.title = endItem.sLabel;
                            }
                            else {
                                
                                self.markerView.title = [NSString stringWithFormat:@"%.2f", endItem.xValue];
                            }

                            
                            if (fabs(self.tapLocation.y - endAnchorPoint1.y) <= fabs(self.tapLocation.y - endAnchorPoint2.y)) {
                                
                                tipPoint = endAnchorPoint1;
                            }
                            else {
                                
                                tipPoint = endAnchorPoint2;
                            }
                            
                            self.markerView.message1 = [NSString stringWithFormat:@"賣出:%.4f", endItem.y1Value];
                            self.markerView.message2 = [NSString stringWithFormat:@"買入:%.4f", endItem.y2Value];
                        }
                        
                        CGFloat yPattern[1]= {1};
                        CGContextSetLineDash(context, 0.0, yPattern, 0);
                        
                        self.markerView.center = CGPointMake(tipPoint.x, tipPoint.y + (self.markerView.frame.size.height / 2));
                        
                        if ((self.markerView.center.x + self.markerView.frame.size.width / 2) > self.frame.size.width) {
                        
                            self.markerView.center = CGPointMake(self.frame.size.width - (self.markerView.frame.size.width / 2), self.markerView.center.y);
                        }
                        else if((self.markerView.center.x - self.markerView.frame.size.width / 2) < self.originPoint.x) {
                            
                            self.markerView.center = CGPointMake(self.originPoint.x + (self.markerView.frame.size.width / 2), self.markerView.center.y);
                        }
                        
                        self.markerView.tipTextColor = self.tipTextColor;
                        
                        //! 橫線
                        [ChartCommon drawLine:context
                                   startPoint:CGPointMake(self.originPoint.x, tipPoint.y)
                                     endPoint:CGPointMake(self.frame.size.width, tipPoint.y)
                                    lineColor:self.tipLineColor width:1.0f];
                        
                        //! 豎線
                        [ChartCommon drawLine:context
                                   startPoint:CGPointMake(tipPoint.x, self.self.frame.size.height)
                                     endPoint:CGPointMake(tipPoint.x, self.originPoint.y)
                                    lineColor:self.tipLineColor width:1.0f];
                        
                        self.hadDrawTipLine = YES;
                    }
                }
            }
        }
    }
}

#pragma mark - UIGestureRecognizer event
-(void) handleLongTap:(UIGestureRecognizer *) recongizer
{
    self.tapLocation = [recongizer locationInView:self];
    
    self.isShowTipLine = YES;
    self.hadDrawTipLine = NO;
    
    self.markerView.hidden = NO;
    
    if(recongizer.state == UIGestureRecognizerStateEnded) {
        
        self.isShowTipLine = NO;

        self.markerView.hidden = YES;
    }

    [self setNeedsDisplay];
}

-(void) handlePan:(UIPanGestureRecognizer *)recognizer
{
    
}

- (void) handlePinch:(UIPinchGestureRecognizer*) recognizer
{
    
}
@end
