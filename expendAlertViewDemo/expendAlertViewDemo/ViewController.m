//
//  ViewController.m
//  expendAlertViewDemo
//
//  Created by broy denty on 14-8-4.
//  Copyright (c) 2014年 denty. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton *alertButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 120, 50)];
    [alertButton setBackgroundColor:[UIColor orangeColor]];
    [alertButton addTarget:self action:@selector(alertAction) forControlEvents:UIControlEventTouchUpInside];
    [alertButton setTitle:@"alertAction" forState:UIControlStateNormal];
    [self.view addSubview:alertButton];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertAction
{
    NSLog(@"buttonAction");
    AlartViewController *aAlartViewController = [[AlartViewController alloc] init];
    aAlartViewController.expendAbleAlartViewDelegate = self;
    aAlartViewController.expendAbleAlartViewDataSource = self;
    __weak UIViewController *weakVC = self;
    [aAlartViewController showView:weakVC];
}

- (void)negativeButtonAction
{
    NSLog(@"negative Action");
}

- (void)positiveButtonAction
{
    NSLog(@"positive Action");
}

- (void)closeButtonAction
{
    NSLog(@"close Action");
}

- (NSString *)loadTextWithNegativeTitle
{
//    return nil;
    return @"取消";
}

- (NSString *)loadTextWithTitle
{
//    return nil;
    return @"注意，真的要这样么";
}

- (NSString *)loadTextWithPositiveTitle
{
//    return nil;
    return @"确定";
}

- (NSString *)loadTextWithEnsureTitle
{
//    return nil;
    return @"确定么？";
}

- (NSString *)loadTextWithConfirmTitle
{
//    return nil;
    return @"操作成功";
}

//- (UIColor *)loadTitleViewColor
//{
//    return [UIColor greenColor];
//}
@end
