//
//  LineChartContentView.m
//  LineGraphicTest
//
//  Created by yehengjia on 2015/3/27.
//  Copyright (c) 2015年 mitake. All rights reserved.
//

#import "LineChartView.h"
#import "ChartCommon.h"
#import "Constants.h"
#import "CommentView.h"

@interface LineChartView()

@property (nonatomic, strong) NSMutableArray *anchorAry;

@property (nonatomic, strong) CommentView *commentView;
//! 產生 X/Y軸刻度
-(void) buildAxisStepByDataSource;

@end

@implementation LineChartView

#if !__has_feature(objc_arc)
-(void) dealloc
{
    OBJC_RELEASE(self.xLineColor);
    OBJC_RELEASE(self.yLineColor);
    
    OBJC_RELEASE(self.xTextColor);
    OBJC_RELEASE(self.yTextColor);
    
    OBJC_RELEASE(self.xAxisLineColor);
    OBJC_RELEASE(self.yAxisLineColor);
    
    OBJC_RELEASE(self.commentView);
    
    OBJC_RELEASE(self.anchorAry);
    
    [super dealloc];
}
#endif

-(id) initWithFrame:(CGRect)frame
{
    if ( (self = [super initWithFrame:frame]) ) {
        
        self.xLineColor = self.xAxisLineColor = [UIColor blackColor];
        self.yLineColor = self.yAxisLineColor = [UIColor blackColor];
        
        self.xTextColor = self.yTextColor = [UIColor blackColor];
        
        self.dataSourceLine1Color = [UIColor redColor];
        self.dataSourceLine2Color = [UIColor orangeColor];
        
        self.anchorAry = [NSMutableArray array];
        
        self.commentView = [[CommentView alloc] initWithFrame:CGRectMake(0, frame.size.height - 30, frame.size.width, 30)];
        self.commentView.comment1Color = self.dataSourceLine1Color;
        self.commentView.comment2Color = self.dataSourceLine2Color;
        [self addSubview:self.commentView];
        [self.commentView release];
    }
    
    return self;
}

-(void) setDataSource:(NSArray *) dataSource
{
    self.dataSourceAry = dataSource;
    
    [self updateViewWithFrame:self.frame];
    
    [self buildAxisStepByDataSource];
}

-(void) resetViewByOrientationWithFrame:(CGRect) frame
{
    self.frame = frame;
    
    [self resetViewWithFrame:self.frame];
}

-(void) setDataSourceLine1Color:(UIColor *)dataSourceLine1Color
{
    _dataSourceLine1Color = dataSourceLine1Color;
    
    self.commentView.comment1Color = dataSourceLine1Color;
}

-(void) setDataSourceLine2Color:(UIColor *)dataSourceLine2Color
{
    _dataSourceLine2Color = dataSourceLine2Color;
    
    self.commentView.comment2Color = dataSourceLine2Color;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
#pragma mark 畫點, 連接線, 指示線
    
    CGPoint startAnchorPoint1 = self.originPoint;
    CGPoint endAnchorPoint1 = self.originPoint;
    
    CGPoint startAnchorPoint2 = self.originPoint;
    CGPoint endAnchorPoint2 = self.originPoint;
    
    NSInteger anchorRadius = 2;
    
    if (self.anchorAry != nil) {
        
        for (AnchorView *anchor in self.anchorAry) {
            
            if ([anchor isKindOfClass:[UIView class]]) {
                
                [anchor removeFromSuperview];
            }
        }
        
        [self.anchorAry removeAllObjects];
    }

    
    for (int i = 0; i != [self.dataSourceAry count]; i++) {
        
        AnchorItem *startItem = [self.dataSourceAry objectAtIndex:i];
        
        CGFloat startPos = self.xPerStepWidth * i + self.originPoint.x + self.contentScroll.x;
        
        startAnchorPoint1.x = startPos;
        
        startAnchorPoint1.y = self.drawContentHeight * ( (startItem.y1Value - self.yMin) / (self.yMax - self.yMin)) + self.originPoint.y + self.contentScroll.y;
        
        //! 畫點, 範圍區塊內才畫
        if ((startAnchorPoint1.x >= self.originPoint.x && startAnchorPoint1.x <= (self.rightBottomPoint.x + self.edgeInset.right)) &&
            (startAnchorPoint1.y >= self.originPoint.y && startAnchorPoint1.y <= (self.rightTopPoint.y + self.edgeInset.top)) &&
            self.isShowAnchorPoint == YES ) {
        
            AnchorView *anchor = nil;
            
#if !__has_feature(objc_arc)
            anchor = [[[AnchorView alloc] initWithFrame:CGRectMake(0, 0, anchorRadius * 2, anchorRadius * 2)] autorelease];
#else
            anchor = [[AnchorView alloc] initWithFrame:CGRectMake(0, 0, anchorRadius * 2, anchorRadius * 2)];
#endif
            if (anchor != nil) {
            
                anchor.center = CGPointMake(startAnchorPoint1.x, startAnchorPoint1.y);
                anchor.anchorDelegate = self;
                anchor.anchorDataAry = [NSArray arrayWithObjects:startItem.xValue,
                                        [NSString stringWithFormat:@"%f", startItem.y1Value],
                                        [NSString stringWithFormat:@"%f", startItem.y2Value], nil];
                anchor.anchorColor = [UIColor redColor];
                [self.anchorAry addObject:anchor];
                
                [self addSubview:anchor];
            }
        }
        
        startAnchorPoint2.x = startPos;
        
        startAnchorPoint2.y = self.drawContentHeight * ( (startItem.y2Value - self.yMin) / (self.yMax - self.yMin)) + self.originPoint.y + self.contentScroll.y;

        //! 畫點, 範圍區塊內才畫
        if ((startAnchorPoint2.x >= self.originPoint.x && startAnchorPoint2.x <= (self.rightBottomPoint.x + self.edgeInset.right)) &&
            (startAnchorPoint2.y >= self.originPoint.y && startAnchorPoint2.y <= (self.rightTopPoint.y + self.edgeInset.top)) &&
            self.isShowAnchorPoint == YES ) {
            
            AnchorView *anchor = nil;
            
#if !__has_feature(objc_arc)
            anchor = [[[AnchorView alloc] initWithFrame:CGRectMake(0, 0, anchorRadius * 2, anchorRadius * 2)] autorelease];
#else
            anchor = [[AnchorView alloc] initWithFrame:CGRectMake(0, 0, anchorRadius * 2, anchorRadius * 2)];
#endif
            if (anchor != nil) {
                
                anchor.center = CGPointMake(startAnchorPoint2.x, startAnchorPoint2.y);
                anchor.anchorDelegate = self;
                anchor.anchorDataAry = [NSArray arrayWithObjects:startItem.xValue,
                                        [NSString stringWithFormat:@"%f", startItem.y1Value],
                                        [NSString stringWithFormat:@"%f", startItem.y2Value], nil];
                anchor.anchorColor = [UIColor orangeColor];
                [self.anchorAry addObject:anchor];
                
                [self addSubview:anchor];
            }
        }
        
        //! 畫點對點連接線及指示線
        if (i + 1 < [self.dataSourceAry count]) {
            
            AnchorItem *endItem = [self.dataSourceAry objectAtIndex:i + 1];
            
            CGFloat endPos = self.xPerStepWidth * (i + 1) + self.originPoint.x + self.contentScroll.x;
            
            float y1Position =  self.drawContentHeight * ( (endItem.y1Value - self.yMin) / (self.yMax - self.yMin)) + self.originPoint.y + self.contentScroll.y;
            
            float y2Position =  self.drawContentHeight * ( (endItem.y2Value - self.yMin) / (self.yMax - self.yMin)) + self.originPoint.y + self.contentScroll.y;
            
            endAnchorPoint1.x = endPos;
            endAnchorPoint1.y = y1Position;
            
            endAnchorPoint2.x = endPos;
            endAnchorPoint2.y = y2Position;
            
            CGFloat yPattern[1]= {1};
            CGContextSetLineDash(context, 0.0, yPattern, 0);
            
            //! 範圍區塊內才畫
            if ((endAnchorPoint1.x >= self.originPoint.x && endAnchorPoint1.x <= self.rightBottomPoint.x) &&
                (endAnchorPoint1.y >= self.originPoint.y && endAnchorPoint1.y <= self.rightTopPoint.y)) {

                [ChartCommon drawLine:context
                           startPoint:startAnchorPoint1
                             endPoint:endAnchorPoint1
                            lineColor:self.dataSourceLine1Color width:1.0f];
            }
            
            //! 範圍區塊內才畫
            if ((endAnchorPoint2.x >= self.originPoint.x && endAnchorPoint2.x <= self.rightBottomPoint.x) &&
                (endAnchorPoint2.y >= self.originPoint.y && endAnchorPoint2.y <= self.rightTopPoint.y)) {
                
                [ChartCommon drawLine:context
                           startPoint:startAnchorPoint2
                             endPoint:endAnchorPoint2
                            lineColor:self.dataSourceLine2Color width:1.0f];
            }
        }
    }

#pragma mark rectangle(超出軸線部分用方塊蓋掉)
    
    [ChartCommon drawRect:context rect:CGRectMake(0, 0, self.leftTopPoint.x, self.frame.size.height) lineColor:[UIColor clearColor] fillColor:self.backgroundColor];
    
    [ChartCommon drawRect:context rect:CGRectMake(0, 0, self.frame.size.width, self.rightBottomPoint.y) lineColor:[UIColor clearColor] fillColor:self.backgroundColor];
    
    //! 畫虛線
#pragma mark 畫 Y 軸上 X 軸(虛)線
    
    
    if (self.drawLineTypeOfX == LineDrawTypeDashLine ||
        self.drawLineTypeOfX == LineDrawTypeNone) {
        
        CGFloat xPattern[1]= {1};
        CGContextSetLineDash(context, 0.0, xPattern, 0);
    }
    else if(self.drawLineTypeOfX == LineDrawTypeDottedLine) {
        
        CGFloat xPattern[2]= {6, 5};
        CGContextSetLineDash(context, 0.0, xPattern, 2);
    }
    
    for (NSInteger i = 0; i < self.yDrawLineCount; i++) {
        
        CGFloat yPosition = self.drawContentHeight * ( ([[self.yArray objectAtIndex:i] floatValue] - self.yMin) / (self.yMax - self.yMin)) + self.originPoint.y + self.contentScroll.y;;
        
        //! 範圍區塊內才畫
        if (yPosition >= self.originPoint.y && fabs(yPosition - self.originPoint.y) <= self.frame.size.height) {
            
            if (self.drawLineTypeOfX == LineDrawTypeNone) {
            
                //! 劃線
                [ChartCommon drawLine:context
                           startPoint:CGPointMake(self.originPoint.x, yPosition)
                             endPoint:CGPointMake(self.originPoint.x + 5, yPosition)
                            lineColor:self.xLineColor width:0.5f];
                
            }
            
            else {
                //! 劃線
                [ChartCommon drawLine:context
                           startPoint:CGPointMake(self.originPoint.x, yPosition)
                             endPoint:CGPointMake(self.rightBottomPoint.x, yPosition)
                            lineColor:self.xLineColor width:0.5f];
            }
            
            //! 顯示文字
            NSString *valStr = [NSString stringWithFormat:@"%.2lf", [self.yArray[i] floatValue]];
            CGSize size = [valStr sizeWithFont:[UIFont fontWithName:@"Helvetica" size:12]];
            [[UIColor colorWithCGColor:self.xTextColor.CGColor] set];
            CGContextSelectFont(context, "Helvetica", 12, kCGEncodingMacRoman);
            const char *str = [valStr cStringUsingEncoding:NSUTF8StringEncoding];
            CGContextShowTextAtPoint(context, 5, yPosition - (size.height / 2 - size.height / 4), str, strlen(str));
        }
    }
    
#pragma mark 畫 X 軸上 Y 軸(虛)線

    for (NSInteger i = 0; i < self.xDrawLineCount; i++) {
        
        //! 顯示文字
        NSString *valStr = @"";
        
        CGFloat xPosition = 0.0f;
        
        BOOL isShowYAxisLine = YES;
        
        if ([self.lineLabelAry count] > 0) {
            
            if (([self.lineLabelAry count] - 1) <= 0) {
                
                xPosition = self.originPoint.x + self.contentScroll.x;
            }
            else {
                
                xPosition = self.xPerStepWidth * i + self.originPoint.x + self.contentScroll.x;
            }
        }
        else {
            
            if (i < [self.dataSourceAry count]) {
                
                AnchorItem *anchorItem = [self.dataSourceAry objectAtIndex:i];
                
                xPosition = self.xPerStepWidth * i + self.originPoint.x + self.contentScroll.x;
                valStr = anchorItem.xValue;
                
                isShowYAxisLine = anchorItem.isShowYAxisLine;
            }
        }
        
        //! 範圍區塊內才畫
        if (xPosition >= self.originPoint.x && fabs(xPosition - self.originPoint.x) <= self.frame.size.width && isShowYAxisLine == YES) {
            
            if (self.drawLineTypeOfY == LineDrawTypeNone) {
                
                [ChartCommon drawLine:context
                           startPoint:CGPointMake(xPosition, self.originPoint.y)
                             endPoint:CGPointMake(xPosition, self.originPoint.y + 5)
                            lineColor:self.yLineColor width:0.5f];
            }
            else {
                
                [ChartCommon drawLine:context
                           startPoint:CGPointMake(xPosition, self.originPoint.y)
                             endPoint:CGPointMake(xPosition, self.leftTopPoint.y)
                            lineColor:self.yLineColor width:0.5f];
            }
            
            
            
            if ([self.lineLabelAry count] > 0 && i < [self.lineLabelAry count]) {

                valStr = self.lineLabelAry[i];                
            }
           
            CGSize size = [valStr sizeWithFont:[UIFont fontWithName:@"Helvetica" size:12]];
            [[UIColor colorWithCGColor:self.yTextColor.CGColor] set];
            CGContextSelectFont(context, "Helvetica", 12, kCGEncodingMacRoman);
            const char *str = [valStr cStringUsingEncoding:NSUTF8StringEncoding];
            CGContextShowTextAtPoint(context, xPosition - (size.width / 2 + size.width / 4), self.originPoint.y - 15, str, strlen(str));
        }
    }
    
#pragma mark 畫 X, Y軸
    
    CGFloat normal[1]={2};
    CGContextSetLineDash(context,0,normal,0); //! 畫實線

    //! X軸
    [ChartCommon drawLine:context startPoint:self.originPoint endPoint:self.rightBottomPoint lineColor:self.xAxisLineColor width:1.0f];

    //! 左Y軸
    [ChartCommon drawLine:context startPoint:self.originPoint endPoint:self.leftTopPoint lineColor:self.yAxisLineColor width:1.0f];
}

#pragma mark - Custom methods

//! 產生 X/Y軸刻度
-(void) buildAxisStepByDataSource
{
    if (self.dataSourceAry.count >= 2) {
 
        float y1Min, y2Min;
        
        AnchorItem *item = [self.dataSourceAry objectAtIndex:0];
        y1Min = item.y1Value; self.yMax = item.y1Value;
        y2Min = item.y2Value; self.yMax = item.y2Value;
        
        for (NSInteger i = 1; i < self.dataSourceAry.count; i++) {
            
            AnchorItem *item = [self.dataSourceAry objectAtIndex:i];
            
            if (item.y1Value < y1Min) {
            
                y1Min = item.y1Value;
            }
            else if (item.y1Value > self.yMax) {
            
                self.yMax = item.y1Value;
            }
            
            if (item.y2Value < y2Min) {
            
                y2Min = item.y2Value;
            }
            else if (item.y2Value > self.yMax) {
            
                self.yMax = item.y2Value;
            }
        }
        
        //! x 軸刻度值
        if (!self.xArray) {
        
            self.xArray = [NSMutableArray array];
        }
        else {
        
            [self.xArray removeAllObjects];
        }
        
        if ([self.lineLabelAry count] > 0) {
            
            self.xArray = [NSMutableArray arrayWithArray:self.lineLabelAry];
        }
        else {
            
            self.xArray = [NSMutableArray arrayWithArray:self.dataSourceAry];
        }
        
        //! y軸刻度值
        if (!self.yArray) {
        
            self.yArray = [NSMutableArray array];
        }
        else {
        
            [self.yArray removeAllObjects];
        }
        
        if (y1Min >= y2Min) {
            
            self.yMin = y2Min;
        }
        else {
            
            self.yMin = y1Min;
        }
        
        CGFloat temp = (self.yMax - self.yMin) / self.yLineCount;
        
        self.yMax += temp;
        self.yMin = (self.yMin - temp) >= 0 ? (self.yMin - temp) : 0;
        
        self.yPreStepValue = (self.yMax - self.yMin) / self.yLineCount;
        
        for (int i = 0; i != self.yDrawLineCount; i++) {
            
            [self.yArray addObject:[NSNumber numberWithFloat: (self.yMin + i * self.yPreStepValue)]];
        }
    }
    else if([self.dataSourceAry count] == 1) {
        
        
        AnchorItem *anchorItem = [self.dataSourceAry objectAtIndex:0];
        
        //! x 軸刻度
        if (!self.xArray) {
            
            self.xArray = [NSMutableArray array];
        }
        else {
            
            [self.xArray removeAllObjects];
        }
        
        if ([self.lineLabelAry count] > 0) {
            
            self.xArray = [NSMutableArray arrayWithArray:self.lineLabelAry];
        }
        else {
            
            self.xArray = [NSMutableArray arrayWithArray:self.dataSourceAry];
        }

        
        //! y軸刻度
        if (!self.yArray) {
            
            self.yArray = [NSMutableArray array];
        }
        else {
            
            [self.yArray removeAllObjects];
        }
        
        [self.yArray addObject:[NSNumber numberWithFloat:anchorItem.y1Value]];
    }
}


#pragma mark - anchor event

-(void) didSelectAnchorPoint:(NSArray *)anchorDataAry
{
    NSLog(@"%@", anchorDataAry);
}

@end
