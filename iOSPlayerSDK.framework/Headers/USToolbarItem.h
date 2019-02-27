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

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, USToolbarItemAutoresizing) {
	USToolbarAutoresizingFixedWidth = 0,
	USToolbarAutoresizingFlexibleWidth = 1 << 0,
};

@class USToolbar;

@interface USToolbarItem : UIView

@property(nullable, nonatomic, weak) USToolbar *toolbar;
@property(nonatomic, assign) USToolbarItemAutoresizing toolbarAutoresizingMask;

+ (instancetype)flexibleSpaceItem;
+ (instancetype)fixedSpaceItemWithWidth:(CGFloat)width;
+ (instancetype)itemWithCustomView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
