//
//  CTAssetsGridSelectIconView.m
//  CTAssetsPickerDemo
//
//  Created by ZacharyChen on 2016/7/6.
//  Copyright © 2016年 Clement T. All rights reserved.
//

#import <PureLayout/PureLayout.h>
#import "CTAssetsGridSelectIconView.h"
#import "CTAssetsPickerDefines.h"

@interface CTAssetsGridSelectIconView ()

#pragma mark Managing Auto Layout

/**
 *  The constraints of the size of the label.
 */
@property (nonatomic, strong) NSArray *sizeConstraints;

/**
 *  The constraint for pinning the label to vertical edge.
 */
@property (nonatomic, strong) NSLayoutConstraint *verticalConstraint;

/**
 *  The constraint for pinning the label to horizontal edge.
 */
@property (nonatomic, strong) NSLayoutConstraint *horizontalConstraint;

/**
 *  Determines whether or not the constraints have been set up.
 */
@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation CTAssetsGridSelectIconView

/**
 *  Designated Initializer
 *
 *  @return an initialized label object
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = CTAssetLabelBorderColor.CGColor;
        self.layer.borderWidth = 1.0;
        self.layer.cornerRadius = CTAssetLabelSize.height / 2;
        self.layer.masksToBounds = YES;
        self.isAccessibilityElement = NO;
    }
    
    return self;
}

#pragma mark Customizing Appearance

/**
 *  The width of the label's border
 */
- (CGFloat)borderWidth
{
    return self.layer.borderWidth;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = (borderWidth > 0.0) ?  borderWidth : 1.0;
}

/**
 *  The color of the label's border
 */

- (UIColor *)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderColor:(UIColor *)borderColor
{
    UIColor *color = (borderColor) ? borderColor : CTAssetLabelBorderColor;
    self.layer.borderColor = color.CGColor;
}

/**
 *  To set the size of label.
 *
 *  @param size The size of the label.
 */
- (void)setSize:(CGSize)size
{
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        size = CTAssetLabelSize;
    }
    
    [self removeConstraints:self.sizeConstraints];
    [NSLayoutConstraint autoSetPriority:UILayoutPriorityRequired forConstraints:^{
        self.sizeConstraints = [self autoSetDimensionsToSize:size];
    }];
}

/**
 *  To set margin of the label from the edges.
 *
 *  @param margin The margin from the edges.
 *
 *  @see setMargin:forVerticalEdge:horizontalEdge:
 */
- (void)setMargin:(CGFloat)margin
{
    [self setMargin:margin forVerticalEdge:NSLayoutAttributeRight horizontalEdge:NSLayoutAttributeBottom];
}

/**
 *  To set margin of the label from specific edges.
 *
 *  @param margin The margin from the edges.
 *  @param edgeX  The layout attribute respresents vertical edge that the label pins to. Either `NSLayoutAttributeLeft` or `NSLayoutAttributeRight`.
 *  @param edgeY  The layout attribute respresents horizontal edge that the label pins to. Either `NSLayoutAttributeTop` or `NSLayoutAttributeBottom`.
 *
 *  @see setMargin:
 */
- (void)setMargin:(CGFloat)margin forVerticalEdge:(NSLayoutAttribute)edgeX horizontalEdge:(NSLayoutAttribute)edgeY
{
    NSAssert(edgeX == NSLayoutAttributeLeft || edgeX == NSLayoutAttributeRight,
             @"Vertical edge must be NSLayoutAttributeLeft or NSLayoutAttributeRight");
    
    NSAssert(edgeY == NSLayoutAttributeTop || edgeY == NSLayoutAttributeBottom,
             @"Horizontal edge must be NSLayoutAttributeTop or NSLayoutAttributeBottom");
    
    [self.superview removeConstraints:@[self.verticalConstraint, self.horizontalConstraint]];
    self.verticalConstraint   = [self autoPinEdgeToSuperviewEdge:(ALEdge)edgeX withInset:margin];
    self.horizontalConstraint = [self autoPinEdgeToSuperviewEdge:(ALEdge)edgeY withInset:margin];
}

#pragma mark Triggering Auto Layout

/**
 *  Updates constraints of the label.
 */
- (void)updateConstraints
{
    if (!self.didSetupConstraints)
    {
        [NSLayoutConstraint autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            self.sizeConstraints = [self autoSetDimensionsToSize:CTAssetLabelSize];
        }];
        
        self.verticalConstraint   = [self autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
        self.horizontalConstraint = [self autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

@end
