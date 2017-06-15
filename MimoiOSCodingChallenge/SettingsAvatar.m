//
//  Created by Mimohello GmbH on 16.02.17.
//  Copyright (c) 2017 Mimohello GmbH. All rights reserved.
//

#import "SettingsAvatar.h"

@interface SettingsAvatar()
@property BOOL premium;
@end

@implementation SettingsAvatar

#pragma mark - INIT

- (instancetype)initWithPremium:(BOOL)premium{
    self = [super init];
    if (self) {
        self.premium = premium;
        self.backgroundColor = [UIColor clearColor];
        [self addWidthAndHeightConstraintsToSelf];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.premium = NO;
        self.backgroundColor = [UIColor clearColor];
        [self addWidthAndHeightConstraintsToSelf];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.premium = NO;
        self.backgroundColor = [UIColor clearColor];
        [self addWidthAndHeightConstraintsToSelf];
    }
    return self;
}

#pragma mark UPDATE PREMIUM STATUS -

- (void)updatePremium:(BOOL)premium {
    self.premium = premium;
    [self setNeedsDisplay];
}

#pragma mark CONSTRAINTS -

- (void)addWidthAndHeightConstraintsToSelf {
    self.translatesAutoresizingMaskIntoConstraints  = NO;
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:79.f];
    [self addConstraint:width];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:59.f];
    [self addConstraint:height];
}

#pragma mark DRAWING -

- (void)drawRect:(CGRect)rect {
    [self drawAvatarWithFrame:rect];
}

- (void)drawAvatarWithFrame: (CGRect)frame {
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* strokeColor = [UIColor grayColor];
    UIColor* starBG = [UIColor yellowColor];
    UIColor* starInner = [UIColor orangeColor];
    
    
    //// Subframes
    CGRect avatarDrawings = CGRectMake(CGRectGetMinX(frame) + 12, CGRectGetMinY(frame) + CGRectGetHeight(frame) - 55, 55, 55);
    CGRect star = CGRectMake(CGRectGetMinX(frame) + CGRectGetWidth(frame) - 28, CGRectGetMinY(frame), 27, 27);
    
    
    //// avatarDrawings
    {
        //// Group 3
        {
            CGContextSaveGState(context);
            CGContextBeginTransparencyLayer(context, NULL);
            
            //// Clip Clip
            UIBezierPath* clipPath = [UIBezierPath bezierPath];
            [clipPath moveToPoint: CGPointMake(CGRectGetMinX(avatarDrawings) + 27.5, CGRectGetMinY(avatarDrawings) + 55)];
            [clipPath addCurveToPoint: CGPointMake(CGRectGetMinX(avatarDrawings) + 55, CGRectGetMinY(avatarDrawings) + 27.5) controlPoint1: CGPointMake(CGRectGetMinX(avatarDrawings) + 42.69, CGRectGetMinY(avatarDrawings) + 55) controlPoint2: CGPointMake(CGRectGetMinX(avatarDrawings) + 55, CGRectGetMinY(avatarDrawings) + 42.69)];
            [clipPath addCurveToPoint: CGPointMake(CGRectGetMinX(avatarDrawings) + 27.5, CGRectGetMinY(avatarDrawings)) controlPoint1: CGPointMake(CGRectGetMinX(avatarDrawings) + 55, CGRectGetMinY(avatarDrawings) + 12.31) controlPoint2: CGPointMake(CGRectGetMinX(avatarDrawings) + 42.69, CGRectGetMinY(avatarDrawings))];
            [clipPath addCurveToPoint: CGPointMake(CGRectGetMinX(avatarDrawings), CGRectGetMinY(avatarDrawings) + 27.5) controlPoint1: CGPointMake(CGRectGetMinX(avatarDrawings) + 12.31, CGRectGetMinY(avatarDrawings)) controlPoint2: CGPointMake(CGRectGetMinX(avatarDrawings), CGRectGetMinY(avatarDrawings) + 12.31)];
            [clipPath addCurveToPoint: CGPointMake(CGRectGetMinX(avatarDrawings) + 27.5, CGRectGetMinY(avatarDrawings) + 55) controlPoint1: CGPointMake(CGRectGetMinX(avatarDrawings), CGRectGetMinY(avatarDrawings) + 42.69) controlPoint2: CGPointMake(CGRectGetMinX(avatarDrawings) + 12.31, CGRectGetMinY(avatarDrawings) + 55)];
            [clipPath closePath];
            clipPath.usesEvenOddFillRule = YES;
            
            [clipPath addClip];
            
            
            CGContextEndTransparencyLayer(context);
            CGContextRestoreGState(context);
        }
        
        
        //// Group 4
        {
            CGContextSaveGState(context);
            CGContextBeginTransparencyLayer(context, NULL);
            
            //// Clip Clip 4
            UIBezierPath* clip4Path = [UIBezierPath bezierPath];
            [clip4Path moveToPoint: CGPointMake(CGRectGetMinX(avatarDrawings) + 27.5, CGRectGetMinY(avatarDrawings) + 55)];
            [clip4Path addCurveToPoint: CGPointMake(CGRectGetMinX(avatarDrawings) + 55, CGRectGetMinY(avatarDrawings) + 27.5) controlPoint1: CGPointMake(CGRectGetMinX(avatarDrawings) + 42.69, CGRectGetMinY(avatarDrawings) + 55) controlPoint2: CGPointMake(CGRectGetMinX(avatarDrawings) + 55, CGRectGetMinY(avatarDrawings) + 42.69)];
            [clip4Path addCurveToPoint: CGPointMake(CGRectGetMinX(avatarDrawings) + 27.5, CGRectGetMinY(avatarDrawings)) controlPoint1: CGPointMake(CGRectGetMinX(avatarDrawings) + 55, CGRectGetMinY(avatarDrawings) + 12.31) controlPoint2: CGPointMake(CGRectGetMinX(avatarDrawings) + 42.69, CGRectGetMinY(avatarDrawings))];
            [clip4Path addCurveToPoint: CGPointMake(CGRectGetMinX(avatarDrawings), CGRectGetMinY(avatarDrawings) + 27.5) controlPoint1: CGPointMake(CGRectGetMinX(avatarDrawings) + 12.31, CGRectGetMinY(avatarDrawings)) controlPoint2: CGPointMake(CGRectGetMinX(avatarDrawings), CGRectGetMinY(avatarDrawings) + 12.31)];
            [clip4Path addCurveToPoint: CGPointMake(CGRectGetMinX(avatarDrawings) + 27.5, CGRectGetMinY(avatarDrawings) + 55) controlPoint1: CGPointMake(CGRectGetMinX(avatarDrawings), CGRectGetMinY(avatarDrawings) + 42.69) controlPoint2: CGPointMake(CGRectGetMinX(avatarDrawings) + 12.31, CGRectGetMinY(avatarDrawings) + 55)];
            [clip4Path closePath];
            clip4Path.usesEvenOddFillRule = YES;
            
            [clip4Path addClip];
            
            
            //// Group 5
            {
                CGContextSaveGState(context);
                CGContextBeginTransparencyLayer(context, NULL);
                
                //// Clip Clip 2
                UIBezierPath* clip2Path = [UIBezierPath bezierPath];
                [clip2Path moveToPoint: CGPointMake(CGRectGetMinX(avatarDrawings) + 27.5, CGRectGetMinY(avatarDrawings) + 55)];
                [clip2Path addCurveToPoint: CGPointMake(CGRectGetMinX(avatarDrawings) + 55, CGRectGetMinY(avatarDrawings) + 27.5) controlPoint1: CGPointMake(CGRectGetMinX(avatarDrawings) + 42.69, CGRectGetMinY(avatarDrawings) + 55) controlPoint2: CGPointMake(CGRectGetMinX(avatarDrawings) + 55, CGRectGetMinY(avatarDrawings) + 42.69)];
                [clip2Path addCurveToPoint: CGPointMake(CGRectGetMinX(avatarDrawings) + 27.5, CGRectGetMinY(avatarDrawings)) controlPoint1: CGPointMake(CGRectGetMinX(avatarDrawings) + 55, CGRectGetMinY(avatarDrawings) + 12.31) controlPoint2: CGPointMake(CGRectGetMinX(avatarDrawings) + 42.69, CGRectGetMinY(avatarDrawings))];
                [clip2Path addCurveToPoint: CGPointMake(CGRectGetMinX(avatarDrawings), CGRectGetMinY(avatarDrawings) + 27.5) controlPoint1: CGPointMake(CGRectGetMinX(avatarDrawings) + 12.31, CGRectGetMinY(avatarDrawings)) controlPoint2: CGPointMake(CGRectGetMinX(avatarDrawings), CGRectGetMinY(avatarDrawings) + 12.31)];
                [clip2Path addCurveToPoint: CGPointMake(CGRectGetMinX(avatarDrawings) + 27.5, CGRectGetMinY(avatarDrawings) + 55) controlPoint1: CGPointMake(CGRectGetMinX(avatarDrawings), CGRectGetMinY(avatarDrawings) + 42.69) controlPoint2: CGPointMake(CGRectGetMinX(avatarDrawings) + 12.31, CGRectGetMinY(avatarDrawings) + 55)];
                [clip2Path closePath];
                clip2Path.usesEvenOddFillRule = YES;
                
                [clip2Path addClip];
                
                
                //// Bezier 3 Drawing
                UIBezierPath* bezier3Path = [UIBezierPath bezierPath];
                [bezier3Path moveToPoint: CGPointMake(CGRectGetMinX(avatarDrawings) + 27.5, CGRectGetMinY(avatarDrawings) + 55)];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(avatarDrawings) + 55, CGRectGetMinY(avatarDrawings) + 27.5) controlPoint1: CGPointMake(CGRectGetMinX(avatarDrawings) + 42.69, CGRectGetMinY(avatarDrawings) + 55) controlPoint2: CGPointMake(CGRectGetMinX(avatarDrawings) + 55, CGRectGetMinY(avatarDrawings) + 42.69)];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(avatarDrawings) + 27.5, CGRectGetMinY(avatarDrawings)) controlPoint1: CGPointMake(CGRectGetMinX(avatarDrawings) + 55, CGRectGetMinY(avatarDrawings) + 12.31) controlPoint2: CGPointMake(CGRectGetMinX(avatarDrawings) + 42.69, CGRectGetMinY(avatarDrawings))];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(avatarDrawings), CGRectGetMinY(avatarDrawings) + 27.5) controlPoint1: CGPointMake(CGRectGetMinX(avatarDrawings) + 12.31, CGRectGetMinY(avatarDrawings)) controlPoint2: CGPointMake(CGRectGetMinX(avatarDrawings), CGRectGetMinY(avatarDrawings) + 12.31)];
                [bezier3Path addCurveToPoint: CGPointMake(CGRectGetMinX(avatarDrawings) + 27.5, CGRectGetMinY(avatarDrawings) + 55) controlPoint1: CGPointMake(CGRectGetMinX(avatarDrawings), CGRectGetMinY(avatarDrawings) + 42.69) controlPoint2: CGPointMake(CGRectGetMinX(avatarDrawings) + 12.31, CGRectGetMinY(avatarDrawings) + 55)];
                [bezier3Path closePath];
                [strokeColor setStroke];
                bezier3Path.lineWidth = 5.08;
                [bezier3Path stroke];
                
                
                CGContextEndTransparencyLayer(context);
                CGContextRestoreGState(context);
            }
            
            
            //// Group 6
            {
                CGContextSaveGState(context);
                CGContextBeginTransparencyLayer(context, NULL);
                
                //// Clip Clip 3
                UIBezierPath* clip3Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(avatarDrawings) + 11.85, CGRectGetMinY(avatarDrawings) + 33.45, 31.3, 33) cornerRadius: 12];
                [clip3Path addClip];
                
                
                //// Rectangle Drawing
                UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(CGRectGetMinX(avatarDrawings) + 11.85, CGRectGetMinY(avatarDrawings) + 33.45, 31.3, 33) cornerRadius: 11];
                [strokeColor setStroke];
                rectanglePath.lineWidth = 6;
                [rectanglePath stroke];
                
                
                CGContextEndTransparencyLayer(context);
                CGContextRestoreGState(context);
            }
            
            
            CGContextEndTransparencyLayer(context);
            CGContextRestoreGState(context);
        }
        
        
        //// Group 7
        {
            CGContextSaveGState(context);
            CGContextBeginTransparencyLayer(context, NULL);
            
            //// Clip Clip 5
            UIBezierPath* clip5Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(avatarDrawings) + 18, CGRectGetMinY(avatarDrawings) + 10, 20, 20)];
            [clip5Path addClip];
            
            
            //// Oval Drawing
            UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(CGRectGetMinX(avatarDrawings) + 18, CGRectGetMinY(avatarDrawings) + 10, 20, 20)];
            [strokeColor setStroke];
            ovalPath.lineWidth = 6;
            [ovalPath stroke];
            
            
            CGContextEndTransparencyLayer(context);
            CGContextRestoreGState(context);
        }
    }
    
    
    //// star
    if (self.premium) {
        //// Bezier Drawing
        UIBezierPath* bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(star) + 13.5, CGRectGetMinY(star) + 27)];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(star) + 27, CGRectGetMinY(star) + 13.5) controlPoint1: CGPointMake(CGRectGetMinX(star) + 20.96, CGRectGetMinY(star) + 27) controlPoint2: CGPointMake(CGRectGetMinX(star) + 27, CGRectGetMinY(star) + 20.96)];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(star) + 13.5, CGRectGetMinY(star)) controlPoint1: CGPointMake(CGRectGetMinX(star) + 27, CGRectGetMinY(star) + 6.04) controlPoint2: CGPointMake(CGRectGetMinX(star) + 20.96, CGRectGetMinY(star))];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(star), CGRectGetMinY(star) + 13.5) controlPoint1: CGPointMake(CGRectGetMinX(star) + 6.04, CGRectGetMinY(star)) controlPoint2: CGPointMake(CGRectGetMinX(star), CGRectGetMinY(star) + 6.04)];
        [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(star) + 13.5, CGRectGetMinY(star) + 27) controlPoint1: CGPointMake(CGRectGetMinX(star), CGRectGetMinY(star) + 20.96) controlPoint2: CGPointMake(CGRectGetMinX(star) + 6.04, CGRectGetMinY(star) + 27)];
        [bezierPath closePath];
        bezierPath.usesEvenOddFillRule = YES;
        
        [starBG setFill];
        [bezierPath fill];
        
        
        //// Bezier 2 Drawing
        UIBezierPath* bezier2Path = [UIBezierPath bezierPath];
        [bezier2Path moveToPoint: CGPointMake(CGRectGetMinX(star) + 13.56, CGRectGetMinY(star) + 18.45)];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(star) + 10.03, CGRectGetMinY(star) + 20.31)];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(star) + 8.61, CGRectGetMinY(star) + 19.27) controlPoint1: CGPointMake(CGRectGetMinX(star) + 9.06, CGRectGetMinY(star) + 20.82) controlPoint2: CGPointMake(CGRectGetMinX(star) + 8.42, CGRectGetMinY(star) + 20.35)];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(star) + 9.28, CGRectGetMinY(star) + 15.34)];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(star) + 6.43, CGRectGetMinY(star) + 12.56)];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(star) + 6.97, CGRectGetMinY(star) + 10.89) controlPoint1: CGPointMake(CGRectGetMinX(star) + 5.64, CGRectGetMinY(star) + 11.79) controlPoint2: CGPointMake(CGRectGetMinX(star) + 5.89, CGRectGetMinY(star) + 11.04)];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(star) + 10.91, CGRectGetMinY(star) + 10.31)];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(star) + 12.68, CGRectGetMinY(star) + 6.74)];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(star) + 14.44, CGRectGetMinY(star) + 6.74) controlPoint1: CGPointMake(CGRectGetMinX(star) + 13.17, CGRectGetMinY(star) + 5.75) controlPoint2: CGPointMake(CGRectGetMinX(star) + 13.96, CGRectGetMinY(star) + 5.76)];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(star) + 16.2, CGRectGetMinY(star) + 10.31)];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(star) + 20.15, CGRectGetMinY(star) + 10.89)];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(star) + 20.69, CGRectGetMinY(star) + 12.56) controlPoint1: CGPointMake(CGRectGetMinX(star) + 21.24, CGRectGetMinY(star) + 11.04) controlPoint2: CGPointMake(CGRectGetMinX(star) + 21.48, CGRectGetMinY(star) + 11.8)];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(star) + 17.84, CGRectGetMinY(star) + 15.34)];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(star) + 18.51, CGRectGetMinY(star) + 19.27)];
        [bezier2Path addCurveToPoint: CGPointMake(CGRectGetMinX(star) + 17.09, CGRectGetMinY(star) + 20.31) controlPoint1: CGPointMake(CGRectGetMinX(star) + 18.7, CGRectGetMinY(star) + 20.36) controlPoint2: CGPointMake(CGRectGetMinX(star) + 18.06, CGRectGetMinY(star) + 20.82)];
        [bezier2Path addLineToPoint: CGPointMake(CGRectGetMinX(star) + 13.56, CGRectGetMinY(star) + 18.45)];
        [bezier2Path closePath];
        bezier2Path.usesEvenOddFillRule = YES;
        
        [starInner setFill];
        [bezier2Path fill];
    }
}

@end
