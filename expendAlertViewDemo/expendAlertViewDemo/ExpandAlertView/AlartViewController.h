//
//  AlartViewController.h
//  MyReader
//
//  Created by broy denty on 14-8-4.
//  Copyright (c) 2014年 denty. All rights reserved.
//

#import <UIKit/UIKit.h>
#define DEVICE_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define DEVICE_WIDTH  ([[UIScreen mainScreen] bounds].size.width)
@protocol ExpendableAlartViewDelegate <NSObject>

- (void)positiveButtonAction;
- (void)negativeButtonAction;
- (void)closeButtonAction;
@end

@protocol ExpendableAlartViewDataSource <NSObject>

@optional
- (NSString *)loadTextWithTitle;
- (NSString *)loadTextWithPositiveTitle;
- (NSString *)loadTextWithNegativeTitle;
- (NSString *)loadTextWithConfirmTitle;
- (NSString *)loadTextWithEnsureTitle;

- (UIColor *)loadTitleViewColor;
- (UIColor *)loadPositiveViewColor;
- (UIColor *)loadNegativeViewColor;
@end

@interface AlartViewController : UIViewController
@property (nonatomic,strong) UIView *titleView;

@property (nonatomic,weak) id<ExpendableAlartViewDelegate> expendAbleAlartViewDelegate;
@property (nonatomic,weak) id<ExpendableAlartViewDataSource> expendAbleAlartViewDataSource;
- (void)showView:(UIViewController *)VC;
CA_EXTERN CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ);


CA_EXTERN CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ);

@end
