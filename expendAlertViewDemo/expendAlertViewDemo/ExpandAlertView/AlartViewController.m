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
    [self.view setBackgroundColor:[UIColor  colorWithRed:0 green:0 blue:0 alpha:0.5]];
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(20, -70, 280, 120)];
    [self.titleView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.titleView];
    
    positiveView = [[UIView alloc] init];
    [positiveView setFrame:CGRectMake(0, 90, 140, 50)];
    [positiveView.layer setAnchorPoint:CGPointMake(0.5, 1)];
    [positiveView setBackgroundColor:[UIColor colorWithRed:0.20 green:0.28 blue:0.41 alpha:1]];
    [positiveView.layer setZPosition:-1];
    
    UILabel *positiveLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 50)];
    positiveLabel.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    [positiveLabel setText:@"positive"];
    [positiveLabel setTextAlignment:NSTextAlignmentCenter];
    [positiveLabel setTextColor:[UIColor lightTextColor]];
    [positiveView addSubview:positiveLabel];
    
//    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(positiveAction)];
//    [positiveView addGestureRecognizer:recognizer];
//    UIButton *positiveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, positiveView.frame.size.width, positiveView.frame.size.height)];
//    [positiveButton addTarget:self action:@selector(positiveAction) forControlEvents:UIControlEventTouchUpInside];
//    [positiveView addSubview:positiveButton];
    [self.titleView addSubview:positiveView];
    
    negativeView = [[UIView alloc] init];
    [negativeView setFrame:CGRectMake(140, 90, 140, 50)];
    [negativeView.layer setAnchorPoint:CGPointMake(0.5, 1)];
    [negativeView setBackgroundColor:[UIColor colorWithRed:0.26 green:0.33 blue:0.48 alpha:1]];
    [negativeView.layer setZPosition:-1];
    
    UILabel *negativeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 140, 50)];
    negativeLabel.layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    [negativeLabel setText:@"negative"];
    [negativeLabel setTextAlignment:NSTextAlignmentCenter];
    [negativeLabel setTextColor:[UIColor lightTextColor]];
    [negativeView addSubview:negativeLabel];
    
    UIButton *nagetiveButtton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, negativeView.frame.size.width, negativeView.frame.size.height)];
    [nagetiveButtton addTarget:self action:@selector(nagetiveAction) forControlEvents:UIControlEventTouchUpInside];
    [negativeView addSubview:nagetiveButtton];
    [self.titleView addSubview:negativeView];
    
    UIView* titleHolder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.titleView.frame.size.width, self.titleView.frame.size.height)];
    [titleHolder setBackgroundColor:[UIColor colorWithRed:0.20 green:0.25 blue:0.33 alpha:1]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 280, 120)];
    [label setText:@"alertView"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor lightTextColor]];
    [titleHolder addSubview:label];
    [self.titleView addSubview:titleHolder];
    [self.titleView.layer setZPosition:1];
    
    cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(145, 600, 30, 30)];
    [cancelButton.layer setBorderColor:[UIColor lightTextColor].CGColor];
    [cancelButton.layer setBorderWidth:1];
    [cancelButton.layer setCornerRadius:15];
    [cancelButton setTitle:@"x" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [UIView animateWithDuration:0.5 animations:^{
        [self.titleView setFrame:CGRectMake(self.titleView.frame.origin.x, 160, self.titleView.frame.size.width, self.titleView.frame.size.height)];
    }];
    CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc] init];
    [animation setDelegate:self];
    animation.values = @[@(M_PI/64),@(-M_PI/64),@(M_PI/64),@(-M_PI/64),@(M_PI/64),@(M_PI/64),@(-M_PI/64),@(M_PI/64),@(-M_PI/64),@(M_PI/64),@(0)];
    animation.duration = 0.5;
    [animation setKeyPath:@"transform.rotation"];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self.titleView.layer addAnimation:animation forKey:@"shake"];
    [self.titleView.layer animationForKey:@"shake"];
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
            [animation setDelegate:self];
        }
        else if([anim isEqual:[positiveView.layer animationForKey:@"rotate"]])
        {
            CATransform3D trans2 = CATransform3DPerspect(CATransform3DMakeRotation(-M_PI-0.0001, 1, 0, 0), CGPointMake(0, 0), 200) ;
            CABasicAnimation *animation2 = [[CABasicAnimation alloc] init];
            [animation2 setDelegate:self];
            animation2.keyPath = @"transform";
            animation2.toValue = [NSValue valueWithCATransform3D:trans2];
            animation2.duration = 0.25;
            animation2.removedOnCompletion = NO;
            animation2.fillMode = kCAFillModeForwards;
            [negativeView.layer addAnimation:animation2 forKey:@"rotate2"];
            [animation2 setDelegate:self];
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

- (void)cancelAction
{
    [UIView animateWithDuration:0.5 animations:^{
        [cancelButton setFrame:CGRectMake(cancelButton.frame.origin.x, 790, cancelButton.frame.size.width, cancelButton.frame.size.height)];
        [self.titleView setFrame:CGRectMake(self.titleView.frame.origin.x, 600, self.titleView.frame.size.width, self.titleView.frame.size.height)];
        
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}

- (void)positiveAction
{
    
}

- (void)nagetiveAction
{
    
}
@end
