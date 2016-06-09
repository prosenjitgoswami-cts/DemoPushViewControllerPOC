//
//  ListViewController.m
//  PushViewControllerPOC
//
//  Created by Prsenjit Goswami on 6/8/16.
//  Copyright © 2016 Manu's Sena's. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@end

#pragma mark - ViewController Life Cycle

@implementation ListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self designPage];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private method

-(void)designPage
{
    self.view.backgroundColor = [UIColor yellowColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 30, 300, 50)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor redColor];
    label.numberOfLines = 0;
    label.text = self.pageTitle;
    [self.view addSubview:label];
    
}




@end
