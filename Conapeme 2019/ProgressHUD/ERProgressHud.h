//
//  ERProgressHud.h
//  Conapeme 2019
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 2/27/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ERProgressHud : NSObject {
    UIView *container;
    UIView *subContainer;
    UILabel *textLabel;
    UIActivityIndicatorView * activityIndicatorView;
    UIVisualEffectView *blurEffectView;
}

+ (ERProgressHud *)sharedInstance;
- (void)show;
- (void)showWithBlurView;
- (void)hide;
- (void)showWithTitle:(NSString *)title;
- (void)showDarkBackgroundViewWithTitle:(NSString *)title;
- (void)showBlurViewWithTitle:(NSString *)title;
- (void)updateProgressTitle:(NSString *)title;

@end
