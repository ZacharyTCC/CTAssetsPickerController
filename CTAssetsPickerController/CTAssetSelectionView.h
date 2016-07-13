//
//  CTAssetSelectionView.h
//  CTAssetsPickerDemo
//
//  Created by ZacharyChen on 2016/7/13.
//  Copyright © 2016年 Clement T. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTAssetSelectionButton.h"

@interface CTAssetSelectionView : UIView

@property (nonatomic, assign) BOOL allowsSelection;

@property (nonatomic, strong, readonly) CTAssetSelectionButton *selectionButton;

- (void)startActivityAnimating;
- (void)stopActivityAnimating;

@end
