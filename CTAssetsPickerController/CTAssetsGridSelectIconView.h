//
//  CTAssetsGridSelectIconView.h
//  CTAssetsPickerDemo
//
//  Created by ZacharyChen on 2016/7/6.
//  Copyright © 2016年 Clement T. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTAssetsGridSelectIconView : UIView

#pragma mark Customizing Appearance

/**
 *  @name Customizing Appearance
 */

/**
 *  Determines whether the label is circular or not. *Deprecated*.
 */
@property (nonatomic, assign, getter=isCircular) BOOL circular UI_APPEARANCE_SELECTOR DEPRECATED_MSG_ATTRIBUTE("Use setCornerRadius: instead.");

/**
 *  The width of the label's border.
 */
@property (nonatomic, assign) CGFloat borderWidth UI_APPEARANCE_SELECTOR;

/**
 *  The color of the label's border.
 */
@property (nonatomic, weak) UIColor *borderColor UI_APPEARANCE_SELECTOR;

/**
 *  To set the size of label.
 *
 *  @param size The size of the label.
 */
- (void)setSize:(CGSize)size UI_APPEARANCE_SELECTOR;

/**
 *  To set margin of the label from the edges.
 *
 *  @param margin The margin from the edges.
 *
 *  @see setMargin:forVerticalEdge:horizontalEdge:
 */
- (void)setMargin:(CGFloat)margin UI_APPEARANCE_SELECTOR;

/**
 *  To set margin of the label from specific edges.
 *
 *  @param margin The margin from the edges.
 *  @param edgeX  The layout attribute respresents vertical edge that the label pins to. Either `NSLayoutAttributeLeft` or `NSLayoutAttributeRight`.
 *  @param edgeY  The layout attribute respresents horizontal edge that the label pins to. Either `NSLayoutAttributeTop` or `NSLayoutAttributeBottom`.
 *
 *  @see setMargin:
 */
- (void)setMargin:(CGFloat)margin forVerticalEdge:(NSLayoutAttribute)edgeX horizontalEdge:(NSLayoutAttribute)edgeY UI_APPEARANCE_SELECTOR;

@end
