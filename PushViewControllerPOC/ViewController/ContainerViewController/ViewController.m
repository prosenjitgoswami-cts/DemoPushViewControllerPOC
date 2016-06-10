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
#import "CustomizeScrollView.h"

@interface ViewController ()

@property (strong,nonatomic) NSMutableArray *activeViewControllers;
@property (strong,nonatomic) CustomizeScrollView *customScroll;
@end

@implementation ViewController


#pragma mark - ViewController Life Cycle


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self pagesDataSource];
    
    [self configureUI];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private method

- (void)configureUI {
    
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    [self.view addSubview:self.customScroll];
    
    // Add LayoutConstraint
    [self addConstrains];
}

- (void)addConstrains {
    
    if(!_pageViewController || !_customScroll) return;
    
    NSDictionary *views = @{@"pageViewController": self.pageViewController.view,
                            @"customScroll": self.customScroll};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[pageViewController]|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[customScroll]-|" options:0 metrics:nil views:views]];
    
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[customScroll(100)][pageViewController]-30-|" options:0 metrics:nil views:views]];
}

- (void)pagesDataSource {
    
    ListViewController *listViewController = [[ListViewController alloc]init];
    listViewController.pageIndex = 0;
    listViewController.pageTitle = @"I am ListViewController";
    
    DaysViewController *daysViewController = [[DaysViewController alloc]init];
    daysViewController.pageIndex = 1;
    daysViewController.pageTitle = @"I am daysViewController";
    
    PageContentViewController *pageContentViewController = [[PageContentViewController alloc]init];
    pageContentViewController.pageIndex = 2;
    pageContentViewController.pageTitle = @"I am pageContentViewController";
    
    
    if(listViewController) {
        
        [self.activeViewControllers addObject:listViewController];
    }
    
    if(daysViewController) {
        
        [self.activeViewControllers addObject:daysViewController];
    }
    
    if(pageContentViewController) {
        
        [self.activeViewControllers addObject:pageContentViewController];
        
    }
    
    //UIScrollView *customScroll = [UIScrollView alloc];
    
    
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

// MARK: Getter Method
- (NSMutableArray *)activeViewControllers {
    
    if(!_activeViewControllers) {
        
        _activeViewControllers = [[NSMutableArray alloc]init];
    }
    
    return _activeViewControllers;
}

- (CustomizeScrollView *)customScroll {
    
    if(!_customScroll) {
        
        _customScroll = [[CustomizeScrollView alloc]initWithItem:_activeViewControllers.count];
        _customScroll.translatesAutoresizingMaskIntoConstraints = NO;
        _customScroll.backgroundColor = [UIColor redColor];
    }
    
    return _customScroll;
    
}

- (UIPageViewController *)pageViewController {
    
    if(!_pageViewController) {
        
        _pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
        
        if(_pageViewController) {
            
            _pageViewController.dataSource = self;
            
            if(_activeViewControllers && self.activeViewControllers.count) {
                
                [_pageViewController setViewControllers:@[self.activeViewControllers[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
            }
        }
        // TranslatesAutoresizingMaskIntoConstraints must be No when use NSLayoutConstraint
        [_pageViewController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
        _pageViewController.doubleSided = YES;
        
    }
    
    return _pageViewController;
}



#pragma mark - IB Action

- (IBAction)startWalkThrough:(id)sender {
    
    [self moveToFirstPage];
    
    
}


#pragma mark - UIPageViewController Delegate

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = 0;
    
    if([viewController respondsToSelector:@selector(pageIndex)])
    {
        index = [viewController pageIndex];
    }
    
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
