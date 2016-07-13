/*
 
 MIT License (MIT)
 
 Copyright (c) 2015 Clement CN Tsang
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */

#import <PureLayout/PureLayout.h>
#import "CTAssetSelectionButton.h"
#import "CTAssetsPickerDefines.h"
#import "CTAssetsGridSelectIconView.h"
#import "CTAssetCheckmark.h"
#import "CTAssetSelectionLabel.h"
#import "NSBundle+CTAssetsPickerController.h"
#import "UIImage+CTAssetsPickerController.h"



@interface CTAssetSelectionButton ()

@property (nonatomic, strong) CTAssetsGridSelectIconView *backgroundView;
@property (nonatomic, strong) CTAssetCheckmark *checkmark;
@property (nonatomic, strong) CTAssetSelectionLabel *selectionIndexLabel;

@property (nonatomic, assign) BOOL didSetupConstraints;

@end





@implementation CTAssetSelectionButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.isAccessibilityElement = YES;
        self.accessibilityTraits = UIAccessibilityTraitButton;
        
        [self setupViews];
        [self localize];
        self.showsSelectionIndex = NO;
    }
    
    return self;
}

#pragma mark - Setup

- (void)setupViews
{
    // Background
    CTAssetsGridSelectIconView *backgroundView = [CTAssetsGridSelectIconView newAutoLayoutView];
    backgroundView.userInteractionEnabled = NO;
    self.backgroundView = backgroundView;
    
    [self addSubview:self.backgroundView];
    
    // Checkmark
    CTAssetCheckmark *checkmark = [CTAssetCheckmark newAutoLayoutView];
    checkmark.userInteractionEnabled = NO;
    checkmark.hidden = YES;
    self.checkmark = checkmark;
    
    [self addSubview:self.checkmark];
    
    // Selection Label
    CTAssetSelectionLabel *selectionIndexLabel = [CTAssetSelectionLabel newAutoLayoutView];
    selectionIndexLabel.userInteractionEnabled = NO;
    selectionIndexLabel.hidden = YES;
    self.selectionIndexLabel = selectionIndexLabel;
    
    [self addSubview:self.selectionIndexLabel];
    
    CTAssetsGridSelectIconView *backgroundViewAppearance = [CTAssetsGridSelectIconView appearanceWhenContainedIn:[self class], nil];
    [backgroundViewAppearance setMargin:0.0];
    
    CTAssetCheckmark *checkmarkAppearance = [CTAssetCheckmark appearanceWhenContainedIn:[self class], nil];
    [checkmarkAppearance setMargin:0.0];
    
    CTAssetSelectionLabel *selectionIndexLabelAppearance = [CTAssetSelectionLabel appearanceWhenContainedIn:[self class], nil];
    [selectionIndexLabelAppearance setMargin:0.0];
}

- (void)localize
{
    self.accessibilityLabel = CTAssetsPickerLocalizedString(@"Select", nil);
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints)
    {
        [NSLayoutConstraint autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self autoSetDimensionsToSize:CTAssetLabelSize];
        }];
        
//        [self.backgroundView autoCenterInSuperview];
//        [self.checkmark autoCenterInSuperview];
//        [self.selectionIndexLabel autoCenterInSuperview];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

#pragma mark - Accessors

- (void)setShowsSelectionIndex:(BOOL)showsSelectionIndex
{
    _showsSelectionIndex = showsSelectionIndex;
    
    if (showsSelectionIndex)
    {
        self.checkmark.hidden = YES;
        self.selectionIndexLabel.hidden = NO;
    }
    else
    {
        self.checkmark.hidden = NO;
        self.selectionIndexLabel.hidden = YES;
    }
}

- (void)setSelectionIndex:(NSUInteger)selectionIndex
{
    _selectionIndex = selectionIndex;
    self.selectionIndexLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)(selectionIndex + 1)];
}

#pragma mark - States

- (void)setSelected:(BOOL)selected
{
    super.selected = selected;
    
    if (self.showsSelectionIndex)
    {
        self.selectionIndexLabel.hidden = !selected;
        
        self.accessibilityLabel = (selected) ? CTAssetsPickerLocalizedString(@"Deselect", nil) : self.selectionIndexLabel.text;
    }
    else
    {
        self.checkmark.hidden = !selected;
        
        self.accessibilityLabel = (selected) ? CTAssetsPickerLocalizedString(@"Deselect", nil) : CTAssetsPickerLocalizedString(@"Select", nil);
    }
}

@end
