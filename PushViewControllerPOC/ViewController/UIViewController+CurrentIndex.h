//
//  UIViewController+CurrentIndex.h
//  PushViewControllerPOC
//
//  Created by Prsenjit Goswami on 6/9/16.
//  Copyright © 2016 Manu's Sena's. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CurrentIndex)

@property (assign, nonatomic) NSUInteger pageIndex;
@property (strong, nonatomic) NSString *pageTitle;

@end
