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
    CALayer *OKlayer;
    CALayer *editLayer;
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
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    OKlayer = [[CALayer alloc] init];
    [OKlayer setFrame:CGRectMake(0, 90, 140, 50)];
    [OKlayer setAnchorPoint:CGPointMake(0.5, 1)];
    [OKlayer setBackgroundColor:[UIColor blueColor].CGColor];
    [OKlayer setZPosition:-1];
    [self.titleView.layer addSublayer:OKlayer];
    editLayer = [[CALayer alloc] init];
    [editLayer setFrame:CGRectMake(140, 90, 140, 50)];
    [editLayer setAnchorPoint:CGPointMake(0.5, 1)];
    [editLayer setBackgroundColor:[UIColor orangeColor].CGColor];
    [editLayer setZPosition:-1];
    [self.titleView.layer addSublayer:editLayer];
    
    UIView* titleHolder = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.titleView.frame.size.width, self.titleView.frame.size.height)];
    [titleHolder setBackgroundColor:[UIColor whiteColor]];
    [self.titleView addSubview:titleHolder];
    [self.titleView.layer setZPosition:1];
    [UIView animateWithDuration:0.25 animations:^{
        [self.titleView setFrame:CGRectMake(self.titleView.frame.origin.x, 160, self.titleView.frame.size.width, self.titleView.frame.size.height)];
    }];
    CAKeyframeAnimation *animation = [[CAKeyframeAnimation alloc] init];
    [animation setDelegate:self];
    animation.values = @[@(M_PI/64),@(-M_PI/64),@(M_PI/64),@(-M_PI/64),@(M_PI/64),@(0)];
    animation.duration = 0.25;
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
            [OKlayer addAnimation:animation forKey:@"rotate"];
            [animation setDelegate:self];
        }
        else if([anim isEqual:[OKlayer animationForKey:@"rotate"]])
        {
            CATransform3D trans2 = CATransform3DPerspect(CATransform3DMakeRotation(-M_PI-0.0001, 1, 0, 0), CGPointMake(0, 0), 200) ;
            CABasicAnimation *animation2 = [[CABasicAnimation alloc] init];
            animation2.keyPath = @"transform";
            animation2.toValue = [NSValue valueWithCATransform3D:trans2];
            animation2.duration = 0.25;
            animation2.removedOnCompletion = NO;
            animation2.fillMode = kCAFillModeForwards;
            [editLayer addAnimation:animation2 forKey:@"rotate2"];
            [animation2 setDelegate:self];
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

@end
