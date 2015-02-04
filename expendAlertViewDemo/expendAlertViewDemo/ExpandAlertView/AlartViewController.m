//
//  AlartViewController.m
//  MyReader
//
//  Created by broy denty on 14-8-4.
//  Copyright (c) 2014年 denty. All rights reserved.
//

#import "AlartViewController.h"

@interface AlartViewController ()

@end

@implementation AlartViewController
{
    UIView *positiveView;
    UIView *negativeView;
    UIButton *cancelButton;
    UILabel *titleLabel;
    
    NSString *titleText;
    NSString *positiveText;
    NSString *negativeText;
    NSString *ensureTitleText;
    NSString *confirmText;
    
    UIColor *titleViewColor;
    UIColor *positiveButtonColor;
    UIColor *negativeButtonColor;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    titleText = [self.expendAbleAlartViewDataSource loadTextWithTitle];
    positiveText = [self.expendAbleAlartViewDataSource loadTextWithPositiveTitle];
    negativeText = [self.expendAbleAlartViewDataSource loadTextWithNegativeTitle];
    ensureTitleText = [self.expendAbleAlartViewDataSource loadTextWithEnsureTitle];
    confirmText = [self.expendAbleAlartViewDataSource loadTextWithConfirmTitle];
    
    [self.view setBackgroundColor:[UIColor  colorWithRed:0 green:0 blue:0 alpha:0.5]];
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(20, -70, DEVICE_WIDTH-40, 120)];
    [self.titleView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.titleView];
    

    positiveView = [[UIView alloc] init];
    [positiveView setFrame:CGRectMake(0, 90, self.titleView.frame.size.width/2, 50)];
    [positiveView.layer setAnchorPoint:CGPointMake(0.5, 1)];
    if (positiveButtonColor == nil) {
        [positiveView setBackgroundColor:[UIColor colorWithRed:0.20 green:0.28 blue:0.41 alpha:1]];
    }else
    {
        [positiveView setBackgroundColor:positiveButtonColor];
    }
    [positiveView.layer setZPosition:-1];
    UILabel *positiveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, positiveView.frame.size.width, 50)];
    positiveLabel.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    if (titleText.length>0) {
        [positiveLabel setText:positiveText];
    }else
    {
        [positiveLabel setText:@"positive"];
    }
    [positiveLabel setTextAlignment:NSTextAlignmentCenter];
    [positiveLabel setTextColor:[UIColor lightTextColor]];
    [positiveView addSubview:positiveLabel];
    [self.titleView addSubview:positiveView];
    

    negativeView = [[UIView alloc] init];
    [negativeView setFrame:CGRectMake(self.titleView.frame.size.width/2, 90, self.titleView.frame.size.width/2, 50)];
    [negativeView.layer setAnchorPoint:CGPointMake(0.5, 1)];
    if (negativeButtonColor == nil) {
        [negativeView setBackgroundColor:[UIColor colorWithRed:0.26 green:0.33 blue:0.48 alpha:1]];
    }else
    {
        [negativeView setBackgroundColor:negativeButtonColor];
    }
    [negativeView.layer setZPosition:-1];
    UILabel *negativeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.titleView.frame.size.width/2, 50)];
    negativeLabel.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    if (negativeText.length>0) {
        [negativeLabel setText:negativeText];
    }else
    {
        [negativeLabel setText:@"negative"];
    }
    [negativeLabel setTextAlignment:NSTextAlignmentCenter];
    [negativeLabel setTextColor:[UIColor lightTextColor]];
    [negativeView addSubview:negativeLabel];
    [self.titleView addSubview:negativeView];

    
    UIView* titleHolder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.titleView.frame.size.width, self.titleView.frame.size.height)];
    
    if (titleViewColor == nil) {
        [titleHolder setBackgroundColor:[UIColor colorWithRed:0.20 green:0.25 blue:0.33 alpha:1]];
    }else
    {
        [titleHolder setBackgroundColor:titleViewColor];
    }
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.titleView.frame.size.width, 120)];
    if (titleText.length>0) {
        [titleLabel setText:titleText];
    }else
    {
        [titleLabel setText:@"alertView"];
    }
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor lightTextColor]];
    [titleHolder addSubview:titleLabel];
    [self.titleView addSubview:titleHolder];
    [self.titleView.layer setZPosition:1];
    
    
    cancelButton = [[UIButton alloc] initWithFrame:CGRectMake((DEVICE_WIDTH-30)/2, DEVICE_HEIGHT, 30, 30)];
    [cancelButton.layer setBorderColor:[UIColor lightTextColor].CGColor];
    [cancelButton.layer setBorderWidth:1];
    [cancelButton.layer setCornerRadius:15];
    [cancelButton setTitle:@"x" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nagetiveAction:)];
    [self.view addGestureRecognizer:gesture];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [UIView animateWithDuration:0.25 animations:^{
        [self.titleView setFrame:CGRectMake(self.titleView.frame.origin.x, 160, self.titleView.frame.size.width, self.titleView.frame.size.height)];
    }];
    CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc] init];
    [animation setDelegate:self];
    animation.values = @[@(M_PI/64),@(-M_PI/64),@(M_PI/64),@(0)];
    animation.duration = 0.5;
    [animation setKeyPath:@"transform.rotation"];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.titleView.layer addAnimation:animation forKey:@"shake"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showView:(UIViewController *)VC
{
    [VC addChildViewController:self];
    self.view.frame = VC.view.bounds;
    [VC.view addSubview:self.view];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag == YES) {
        if ([anim isEqual:[self.titleView.layer animationForKey:@"shake"]])
        {
            CATransform3D trans = CATransform3DPerspect(CATransform3DMakeRotation(-M_PI-0.0001, 1, 0, 0), CGPointMake(0, 0), 200) ;
            CABasicAnimation *animation = [[CABasicAnimation alloc] init];
            [animation setDelegate:self];
            animation.keyPath = @"transform";
            animation.toValue = [NSValue valueWithCATransform3D:trans];
            animation.duration = 0.25;
            animation.removedOnCompletion = NO;
            animation.fillMode = kCAFillModeForwards;
            [positiveView.layer addAnimation:animation forKey:@"rotate"];
        }
        else if([anim isEqual:[positiveView.layer animationForKey:@"rotate"]])
        {
            CATransform3D trans = CATransform3DPerspect(CATransform3DMakeRotation(-M_PI-0.0001, 1, 0, 0), CGPointMake(0, 0), 200) ;
            CABasicAnimation *animation = [[CABasicAnimation alloc] init];
            [animation setDelegate:self];
            animation.keyPath = @"transform";
            animation.toValue = [NSValue valueWithCATransform3D:trans];
            animation.duration = 0.25;
            animation.removedOnCompletion = NO;
            animation.fillMode = kCAFillModeForwards;
            [negativeView.layer addAnimation:animation forKey:@"rotate2"];
        }
        else if ([anim isEqual:[negativeView.layer animationForKey:@"rotate2"]])
        {
            [UIView animateWithDuration:0.5 animations:^{
                [cancelButton setFrame:CGRectMake(cancelButton.frame.origin.x, 350, cancelButton.frame.size.width, cancelButton.frame.size.height)];
            }];
            CABasicAnimation *rotateAnimation  = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
            rotateAnimation.toValue = [NSNumber numberWithFloat:2 * M_PI];
            rotateAnimation.duration = 0.75;
            [cancelButton.layer addAnimation:rotateAnimation forKey:@"rotate3"];
        }
        else if([anim isEqual:[self.titleView.layer animationForKey:@"rotate"]])
        {
            if (ensureTitleText.length>0) {
                [titleLabel setText:ensureTitleText];
            }else
            {
                [titleLabel setText:@"Are you sure  ？"];
            }
        }
        else if ([anim isEqual:[positiveView.layer animationForKey:@"close"]])
        {
            CATransform3D transFrom = CATransform3DPerspect(CATransform3DMakeRotation(-M_PI-0.0001, 1, 0, 0), CGPointMake(0, 0), 200);
            CATransform3D trans = CATransform3DIdentity ;
            CABasicAnimation *animation = [[CABasicAnimation alloc] init];
            [animation setDelegate:self];
            animation.keyPath = @"transform";
            animation.fromValue = [NSValue valueWithCATransform3D:transFrom];
            animation.toValue = [NSValue valueWithCATransform3D:trans];
            animation.duration = 0.25;
            animation.removedOnCompletion = NO;
            animation.fillMode = kCAFillModeForwards;
            [negativeView.layer addAnimation:animation forKey:@"close2"];
        }
        else if ([anim isEqual:[negativeView.layer animationForKey:@"close2"]])
        {
            CATransform3D trans = CATransform3DPerspect(CATransform3DMakeRotation(-M_PI-0.0001, 0, 1, 0), CGPointMake(0, 0), 200) ;
            CABasicAnimation *animation = [[CABasicAnimation alloc] init];
            [animation setDelegate:self];
            animation.keyPath = @"transform";
            animation.toValue = [NSValue valueWithCATransform3D:trans];
            animation.duration = 0.5;
            animation.removedOnCompletion = NO;
            [self.titleView.layer addAnimation:animation forKey:@"surerotate"];
        }
        else if ([anim isEqual:[self.titleView.layer animationForKey:@"surerotate"]])
        {
            if (confirmText.length>0) {
                [titleLabel setText:confirmText];
            }else
            {
                [titleLabel setText:@"success！"];
            }
            [self performSelector:@selector(cancelAction) withObject:self afterDelay:1];
        }
    }
}

CA_EXTERN CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

CA_EXTERN CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
{
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
}

- (void)cancelClick
{
    [self.expendAbleAlartViewDelegate closeButtonAction];
    [self cancelAction];
}

- (void)cancelAction
{
    [UIView animateWithDuration:0.5 animations:^{
        [cancelButton setFrame:CGRectMake(cancelButton.frame.origin.x, DEVICE_HEIGHT+190, cancelButton.frame.size.width, cancelButton.frame.size.height)];
        [self.titleView setFrame:CGRectMake(self.titleView.frame.origin.x, DEVICE_HEIGHT, self.titleView.frame.size.width, self.titleView.frame.size.height)];
        
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}

- (void)nagetiveAction:(UIGestureRecognizer*) gesture
{
    CGPoint touchPoint = [gesture locationInView:self.titleView];
    if ([negativeView.layer.presentationLayer hitTest:touchPoint])
    {
        [self.expendAbleAlartViewDelegate positiveButtonAction];
//        NSLog(@"nagetiveAction");
        [self cancelAction];
    }
    else if([positiveView.layer.presentationLayer hitTest:touchPoint])
    {
        [self.expendAbleAlartViewDelegate positiveButtonAction];
        if (self.titleView.layer.animationKeys.count>1)
        {
            CATransform3D transFrom = CATransform3DPerspect(CATransform3DMakeRotation(-M_PI-0.0001, 1, 0, 0), CGPointMake(0, 0), 200);
            CATransform3D trans = CATransform3DIdentity ;
            CABasicAnimation *animation = [[CABasicAnimation alloc] init];
            [animation setDelegate:self];
            animation.keyPath = @"transform";
            animation.fromValue = [NSValue valueWithCATransform3D:transFrom];
            animation.toValue = [NSValue valueWithCATransform3D:trans];
            animation.duration = 0.25;
            animation.removedOnCompletion = NO;
            animation.fillMode = kCAFillModeForwards;
            [positiveView.layer addAnimation:animation forKey:@"close"];
        }else
        {
            CATransform3D trans = CATransform3DPerspect(CATransform3DMakeRotation(-M_PI-0.0001, 0, 1, 0), CGPointMake(0, 0), 200) ;
            CABasicAnimation *animation = [[CABasicAnimation alloc] init];
            [animation setDelegate:self];
            animation.keyPath = @"transform";
            animation.toValue = [NSValue valueWithCATransform3D:trans];
            animation.duration = 0.5;
            animation.removedOnCompletion = NO;
            [self.titleView.layer addAnimation:animation forKey:@"rotate"];
        }
    }
}
@end
