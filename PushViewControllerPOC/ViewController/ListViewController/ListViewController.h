//
//  ListViewController.h
//  PushViewControllerPOC
//
//  Created by Prsenjit Goswami on 6/8/16.
//  Copyright © 2016 Manu's Sena's. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property NSUInteger pageIndex;

@end
