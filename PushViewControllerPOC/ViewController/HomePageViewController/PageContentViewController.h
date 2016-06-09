//
//  PageContentViewController.h
//  PushViewControllerPOC
//
//  Created by Prsenjit Goswami on 6/7/16.
//  Copyright © 2016 Manu's Sena's. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+CurrentIndex.h"

@interface PageContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property NSString *titleText;
@property NSString *imageFile;


@end
