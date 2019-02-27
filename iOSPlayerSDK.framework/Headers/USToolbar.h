//
// © Copyright IBM Corp. 2018
//
// All Rights Reserved.
//
// This software is the confidential and proprietary information
// of the IBM Corporation. (‘Confidential Information’). Redistribution
// of the source code or binary form is not permitted without prior authorization
// from the IBM Corporation.
//

#import <UIKit/UIKit.h>
#import "USToolbarItem.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, USToolbarLayoutAnimationType) {
    USToolbarLayoutAnimationTypeNone,
    USToolbarLayoutAnimationTypeLinear,
};

@interface USToolbar : UIView

@property(nonatomic, strong, readonly) UIImageView *backgroundImageView;
@property(nullable, nonatomic, strong, readonly) NSArray *toolbarItems;
@property(nonatomic, assign) CGFloat toolbarItemPadding;
@property(nonatomic, assign) USToolbarLayoutAnimationType layoutAnimationType;
@property(nonatomic, assign) CGFloat layoutAnimationDuration;
@property(nonatomic, assign) UIEdgeInsets contentInsets;

- (void)setToolbarItems:(nullable NSArray<USToolbarItem *> *)toolbarItems animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
