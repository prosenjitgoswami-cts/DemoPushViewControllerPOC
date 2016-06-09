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

- (void)createViewControllers {
    
    
    DaysViewController *listViewController = [[DaysViewController alloc]init];
    listViewController.pageIndex = 0;
    
    ListViewController *daysViewController = [[ListViewController alloc]init];
    daysViewController.pageIndex = 1;

    if(!self.activeViewControllers)
    {
        self.activeViewControllers = [[NSMutableArray alloc]init];
        
    }
    else
    {
        [self.activeViewControllers removeAllObjects];
    }
    
    
    if(listViewController)
    {
        [self.activeViewControllers addObject:listViewController];
    }
    if(daysViewController)
    {
        [self.activeViewControllers addObject:daysViewController];
    }
   
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createViewControllers];
    
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    
    if(self.pageViewController) {
        
        self.pageViewController.dataSource = self;
        
        if(self.activeViewControllers && self.activeViewControllers.count) {
            
            [self.pageViewController setViewControllers:@[self.activeViewControllers[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
        }
    }
        // Change the size of page view controller
        self.pageViewController.view.frame = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height - 30.0f);
        self.pageViewController.doubleSided = YES;
        [self addChildViewController:_pageViewController];
        [self.view addSubview:_pageViewController.view];
        [self.pageViewController didMoveToParentViewController:self];
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startWalkThrough:(id)sender {

    UIViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.activeViewControllers count] == 0) || (index >= [self.activeViewControllers count])) {
        return nil;
    }
    
    UIViewController *activeViewController = nil;
    
    if(self.activeViewControllers && index < self.activeViewControllers.count)
    {
        
        activeViewController = [self.activeViewControllers objectAtIndex:index];
        
        if(!activeViewController)
            return nil;
    }
    
    return activeViewController;
}

@end
