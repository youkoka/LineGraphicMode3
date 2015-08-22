//
//  MarkerView.m
//  LineGraphicTest
//
//  Created by yehengjia on 2015/7/31.
//  Copyright (c) 2015年 mitake. All rights reserved.
//

#import "MarkerView.h"
#import "Constants.h"

#define XOffset 5.0

#define FONT_SIZE [UIFont fontWithName:@"Helvetica" size:14]

@interface MarkerView()

@property (nonatomic, strong) UILabel *lbTitle;

@property (nonatomic, strong) UILabel *lbMessage1;
@property (nonatomic, strong) UILabel *lbMessage2;

@end

@implementation MarkerView

-(void) dealloc
{
    OBJC_RELEASE(self.title);
    OBJC_RELEASE(self.message1);

    OBJC_RELEASE(self.lbTitle);
    OBJC_RELEASE(self.lbMessage1);
    OBJC_RELEASE(self.lbMessage2);
    
    OBJC_RELEASE(self.tipTextColor);
    [super dealloc];
}

-(instancetype) init {

    if ( self = [super init]) {
        
        //! 將圓點設為左下角
        [self setTransform:CGAffineTransformMakeScale(1, -1)];

        self.lbTitle = [[UILabel alloc] init];
        self.lbTitle.font = FONT_SIZE;
        self.lbTitle.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.lbTitle];
        [self.lbTitle release];
        
        self.lbMessage1 = [[UILabel alloc] init];
        self.lbMessage1.font = FONT_SIZE;
        self.lbMessage1.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.lbMessage1];
        [self.lbMessage1 release];
        
        self.lbMessage2 = [[UILabel alloc] init];
        self.lbMessage2.font = FONT_SIZE;
        self.lbMessage2.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.lbMessage2];
        [self.lbMessage2 release];

        self.lbTitle.textColor = self.lbMessage1.textColor = self.lbMessage2.textColor = [UIColor blackColor];
    }
    
    return self;
}

-(instancetype) initWithFrame:(CGRect)frame
{
    if ( self = [super initWithFrame:frame]) {
        
        //! 將圓點設為左下角
        [self setTransform:CGAffineTransformMakeScale(1, -1)];

        self.lbTitle = [[UILabel alloc] init];
        self.lbTitle.font = FONT_SIZE;
        self.lbTitle.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.lbTitle];
        [self.lbTitle release];
        
        self.lbMessage1 = [[UILabel alloc] init];
        self.lbMessage1.font = FONT_SIZE;
        self.lbMessage1.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.lbMessage1];
        [self.lbMessage1 release];
        
        self.lbMessage2 = [[UILabel alloc] init];
        self.lbMessage2.font = FONT_SIZE;
        self.lbMessage2.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.lbMessage2];
        [self.lbMessage2 release];
        
        self.lbTitle.textColor = self.lbMessage1.textColor = self.lbMessage2.textColor = [UIColor blackColor];
    }
    
    return self;
}

-(instancetype) initWithImage:(UIImage *)image
{
    if ( self = [super initWithImage:image]) {
    
        //! 將圓點設為左下角
        [self setTransform:CGAffineTransformMakeScale(1, -1)];
        
        self.lbTitle = [[UILabel alloc] init];
        self.lbTitle.font = FONT_SIZE;
        self.lbTitle.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.lbTitle];
        [self.lbTitle release];
        
        self.lbMessage1 = [[UILabel alloc] init];
        self.lbMessage1.font = FONT_SIZE;
        self.lbMessage1.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.lbMessage1];
        [self.lbMessage1 release];
        
        self.lbMessage2 = [[UILabel alloc] init];
        self.lbMessage2.font = FONT_SIZE;
        self.lbMessage2.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.lbMessage2];
        [self.lbMessage2 release];
        
        self.lbTitle.textColor = self.lbMessage1.textColor = self.lbMessage2.textColor = [UIColor blackColor];
    }
    
    return self;
}

-(instancetype) initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    if ( self = [super initWithImage:image highlightedImage:highlightedImage]) {
        
        //! 將圓點設為左下角
        [self setTransform:CGAffineTransformMakeScale(1, -1)];
        
        self.lbTitle = [[UILabel alloc] init];
        self.lbTitle.font = FONT_SIZE;
        self.lbTitle.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.lbTitle];
        [self.lbTitle release];
        
        self.lbMessage1 = [[UILabel alloc] init];
        self.lbMessage1.font = FONT_SIZE;
        self.lbMessage1.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.lbMessage1];
        [self.lbMessage1 release];
        
        self.lbMessage2 = [[UILabel alloc] init];
        self.lbMessage2.font = FONT_SIZE;
        self.lbMessage2.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.lbMessage2];
        [self.lbMessage2 release];
        
        self.lbTitle.textColor = self.lbMessage1.textColor = self.lbMessage2.textColor = [UIColor blackColor];
    }
    
    return self;
}

-(void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    if (self.lbTitle != nil) {
        
        self.lbTitle.frame = CGRectMake(XOffset, 0, frame.size.width - XOffset, (frame.size.height / 3));
    }
    
    if (self.lbMessage1 != nil) {
        
        self.lbMessage1.frame = CGRectMake(XOffset, (frame.size.height / 3), frame.size.width - XOffset, (frame.size.height / 3));
    }
    
    if (self.lbMessage2 != nil) {
        
        self.lbMessage2.frame = CGRectMake(XOffset, (frame.size.height / 3) * 2, frame.size.width - XOffset, (frame.size.height / 3));
    }
}

-(void) setTitle:(NSString *)title
{
    _title = title;
    
    if (self.lbTitle != nil) {
        
        self.lbTitle.text = title;
    }
}

-(void) setMessage1:(NSString *)message
{
    _message1 = message;
    
    if (self.lbMessage1 != nil) {
        
        self.lbMessage1.text = message;
    }
}

-(void) setMessage2:(NSString *)message
{
    _message2 = message;
    
    if (self.lbMessage2 != nil) {
        
        self.lbMessage2.text = message;
    }
}

-(void) setTipTextColor:(UIColor *)tipTextColor
{
    _tipTextColor = tipTextColor;
    
    if (self.lbTitle != nil) {
        
        self.lbTitle.textColor = tipTextColor;
    }
    
    if (self.lbMessage1 != nil) {
        
        self.lbMessage1.textColor = tipTextColor;
    }

    if (self.lbMessage2 != nil) {
        
        self.lbMessage2.textColor = tipTextColor;
    }

}
@end
