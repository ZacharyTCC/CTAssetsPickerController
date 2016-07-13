//
//  CTAssetSelectionView.m
//  CTAssetsPickerDemo
//
//  Created by ZacharyChen on 2016/7/13.
//  Copyright © 2016年 Clement T. All rights reserved.
//

#import <PureLayout/PureLayout.h>
#import "CTAssetSelectionView.h"
#import "CTAssetsPickerDefines.h"

@interface CTAssetSelectionView ()

@property (nonatomic, strong) CTAssetSelectionButton *selectionButton;

@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation CTAssetSelectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.allowsSelection = NO;
        
        [self setupViews];
    }
    
    return self;
}

#pragma mark - Setup

- (void)setupViews
{
    self.backgroundColor = CTAssetsSelectionViewBackgroundColor;
    
    CTAssetSelectionButton *selectionButton = [CTAssetSelectionButton newAutoLayoutView];
    self.selectionButton = selectionButton;
    [self addSubview:self.selectionButton];
}

#pragma mark - Update auto layout constraints

- (void)updateConstraints
{
    if (!self.didSetupConstraints)
    {
        [NSLayoutConstraint autoSetPriority:UILayoutPriorityRequired forConstraints:^{
            [self autoSetDimension:ALDimensionHeight toSize:46.0];
        }];
        
        [self autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
        [self autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
        [self autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
        
        [self.selectionButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.selectionButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:12.0];
        
        self.didSetupConstraints = YES;
    }
    
    [super updateConstraints];
}

#pragma mark - Start/stop loading animation

- (void)startActivityAnimating
{
    [self.selectionButton setHidden:YES];
}

- (void)stopActivityAnimating
{
    [self.selectionButton setHidden:NO];
}

@end
