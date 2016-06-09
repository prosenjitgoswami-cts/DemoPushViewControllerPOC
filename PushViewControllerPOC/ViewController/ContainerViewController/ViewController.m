//
//  ViewController.m
//  PushViewControllerPOC
//
//  Created by Prsenjit Goswami on 6/7/16.
//  Copyright © 2016 Manu's Sena's. All rights reserved.
//

#import "ViewController.h"
#import "PageContentViewController.h"
#import "DaysViewController.h"
#import "ListViewController.h"

@interface ViewController ()

@property (strong,nonatomic) NSMutableArray *activeViewControllers;

@end

@implementation ViewController


#pragma mark - ViewController Life Cycle


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createViewControllers];
    
    [self initialisedPageViewController];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private method

- (void)initialisedPageViewController {
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    
    if(self.pageViewController) {
        
        self.pageViewController.dataSource = self;
        
        if(self.activeViewControllers && self.activeViewControllers.count) {
            
            [self.pageViewController setViewControllers:@[self.activeViewControllers[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
        }
    }
    
    // TranslatesAutoresizingMaskIntoConstraints must be No when use NSLayoutConstraint
    [self.pageViewController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.pageViewController.doubleSided = YES;
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    // Add LayoutConstraint
    [self addConstrains];
}

- (void)addConstrains {
    
    if(!_pageViewController) return;
    
    NSDictionary *views = @{@"pageViewController": self.pageViewController.view};
  
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[pageViewController]|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[pageViewController]-30-|" options:0 metrics:nil views:views]];
}

- (void)createViewControllers {
    
    DaysViewController *listViewController = [[DaysViewController alloc]init];
    listViewController.pageIndex = 0;
    
    ListViewController *daysViewController = [[ListViewController alloc]init];
    daysViewController.pageIndex = 1;
    
   
    
    if(listViewController) {
        
        [self.activeViewControllers addObject:listViewController];
    }
    
    if(daysViewController) {
        
        [self.activeViewControllers addObject:daysViewController];
    }
}



- (void)moveToFirstPage {
    
    UIViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    if (([self.activeViewControllers count] == 0) || (index >= [self.activeViewControllers count])) {
        return nil;
    }
    
    UIViewController *activeViewController = nil;
    
    if(self.activeViewControllers && index < self.activeViewControllers.count) {
        
        activeViewController = [self.activeViewControllers objectAtIndex:index];
        
        if(!activeViewController)
            return nil;
    }
    
    return activeViewController;
}

// MARK: Setter Method
- (NSMutableArray *)activeViewControllers {
    
    if(!_activeViewControllers) {
        
        _activeViewControllers = [[NSMutableArray alloc]init];
    }
   
    return _activeViewControllers;
}

#pragma mark - IB Action

- (IBAction)startWalkThrough:(id)sender {
    
    [self moveToFirstPage];
    
}


#pragma mark - UIPageViewController Delegate

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    
    return [self viewControllerAtIndex:index];
}

@end
