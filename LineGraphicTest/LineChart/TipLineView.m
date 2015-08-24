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
    OBJC_RELEASE(self.markerView);
    
    OBJC_RELEASE(self.tipLineColor);
    OBJC_RELEASE(self.tipTextColor);
    
    [super dealloc];
}
-(instancetype) init
{
    if ( self = [super init]) {
        
        self.isShowTipLine = YES;
        self.hadDrawTipLine = YES;
        
        self.tipLineColor = [UIColor grayColor];
        self.tipTextColor = [UIColor blackColor];
        
        self.originPoint = CGPointMake(0, 0);
        
        self.dataSourceAry = [NSArray array];
        self.xPerStepWidth = 0.0f;
        self.yPerStepHeight = 0.0f;

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
                
                CGFloat startPos = self.xPerStepWidth * i + self.contentScroll.x;
                
                startAnchorPoint1.x = startPos;
                
                startAnchorPoint1.y = self.drawContentHeight * ( (startItem.y1Value - self.yMin) / (self.yMax - self.yMin)) + self.contentScroll.y;
                
                startAnchorPoint2.x = startPos;
                
                startAnchorPoint2.y = self.drawContentHeight * ( (startItem.y2Value - self.yMin) / (self.yMax - self.yMin)) + self.contentScroll.y;
                
                //! 畫點對點連接線及指示線
                if (i + 1 < [self.dataSourceAry count]) {
                    
                    AnchorItem *endItem = [self.dataSourceAry objectAtIndex:i + 1];
                    
                    CGFloat endPos = self.xPerStepWidth * (i + 1) + self.contentScroll.x;
                    
                    float y1Position =  self.drawContentHeight * ( (endItem.y1Value - self.yMin) / (self.yMax - self.yMin)) + self.contentScroll.y;
                    
                    float y2Position =  self.drawContentHeight * ( (endItem.y2Value - self.yMin) / (self.yMax - self.yMin)) + self.contentScroll.y;
                    
                    endAnchorPoint1.x = endPos;
                    endAnchorPoint1.y = y1Position;
                    
                    endAnchorPoint2.x = endPos;
                    endAnchorPoint2.y = y2Position;
                    
                    CGFloat yPattern[1]= {1};
                    CGContextSetLineDash(context, 0.0, yPattern, 0);
                   
                    CGPoint tipPoint = CGPointMake(0, 0);
                    
                    //! 指示線
                    if (startAnchorPoint1.x <= self.tapLocation.x && endAnchorPoint1.x >= self.tapLocation.x) {
                        
                        self.markerView.title = startItem.xValue;
                      
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
                            
                            self.markerView.title = endItem.xValue;
                            
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
                        else if((self.markerView.center.x - self.markerView.frame.size.width / 2) <= 0) {
                            
                            self.markerView.center = CGPointMake((self.markerView.frame.size.width / 2), self.markerView.center.y);
                        }
                        
                        self.markerView.tipTextColor = self.tipTextColor;
                        
                        //! 橫線
                        [ChartCommon drawLine:context
                                   startPoint:CGPointMake(0, tipPoint.y)
                                     endPoint:CGPointMake(self.frame.size.width, tipPoint.y)
                                    lineColor:self.tipLineColor width:1.0f];
                        
                        //! 豎線
                        [ChartCommon drawLine:context
                                   startPoint:CGPointMake(tipPoint.x, self.self.frame.size.height)
                                     endPoint:CGPointMake(tipPoint.x, 0)
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
