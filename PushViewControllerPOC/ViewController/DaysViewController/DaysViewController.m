//
//  DaysViewController.m
//  PushViewControllerPOC
//
//  Created by Prsenjit Goswami on 6/8/16.
//  Copyright © 2016 Manu's Sena's. All rights reserved.
//

#import "DaysViewController.h"

@interface DaysViewController ()

@end

@implementation DaysViewController

#pragma mark - View Controller LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self designPage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private Method

-(void)designPage
{
     self.view.backgroundColor = [UIColor purpleColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 30, 300, 50)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.text = self.pageTitle;
    [self.view addSubview:label];
    
}





@end
