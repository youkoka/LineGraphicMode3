//
//  CommentView.m
//  LineGraphicTest
//
//  Created by yehengjia on 2015/8/19.
//  Copyright (c) 2015年 mitake. All rights reserved.
//

#import "CommentView.h"
#import "Constants.h"

#define FONT_SIZE [UIFont fontWithName:@"Helvetica" size:14]

@interface CommentView()

@property (nonatomic, strong) UILabel *label1;

@property (nonatomic, strong) UILabel *label2;

@end

@implementation CommentView

-(void) dealloc
{
    OBJC_RELEASE(self.label1);
    OBJC_RELEASE(self.label2);
    
    [super dealloc];
}
-(instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
 
        //! 將圓點設為左下角
        [self setTransform:CGAffineTransformMakeScale(1, -1)];

        float xOffset = 10;
        float yOffset = 0;
        float lbWidth = 50;
        float lbHeight = 40;
        
        self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, yOffset, lbWidth, lbHeight)];
        [self.label1 setText:@"ㄧ賣出"];
        [self.label1 setFont:FONT_SIZE];
        [self.label1 setTextColor:[UIColor redColor]];
        [self addSubview:self.label1];
        
        self.label2 = [[UILabel alloc] initWithFrame:CGRectMake(xOffset + lbWidth, yOffset, lbWidth, lbHeight)];
        [self.label2 setText:@"ㄧ買入"];
        [self.label2 setFont:FONT_SIZE];
        [self.label2 setTextColor:[UIColor orangeColor]];
        [self addSubview:self.label2];
    }
    
    return self;
}

-(void) setComment1:(NSString *)comment1
{
    _comment1 = comment1;
    
    if (self.label1) {
        
        [self.label1 setText:[NSString stringWithFormat:@"ㄧ%@", comment1]];
    }
}

-(void) setComment1Color:(UIColor *)comment1Color
{
    _comment1Color = comment1Color;
    
    if (self.label1) {
    
        [self.label1 setTextColor:comment1Color];
    }
}

-(void) setComment2:(NSString *)comment2
{
    _comment2 = comment2;
    
    if (self.label2) {
    
        [self.label2 setText:[NSString stringWithFormat:@"ㄧ%@", comment2]];
    }
}

-(void) setComment2Color:(UIColor *)comment2Color
{
    _comment2Color = comment2Color;
    
    if (self.label2) {
    
        [self.label2 setTextColor:comment2Color];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
