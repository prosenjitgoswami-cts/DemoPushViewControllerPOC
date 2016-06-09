//
//  ViewController.m
//  PushViewControllerPOC
//
//  Created by Prsenjit Goswami on 6/7/16.
//  Copyright © 2016 Manu's Sena's. All rights reserved.
//

#import "ViewController.h"
#import "PageContentViewController.h"


@interface ViewController ()

@property (strong,nonatomic) NSMutableArray *activeViewControllers;

@end

@implementation ViewController

- (void)createViewControllers {
    
    UIViewController *listViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListViewController"];

    UIViewController *daysViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DaysViewController"];
    UIViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
//    UIViewController *listViewController = [[UIViewController alloc]init];
//    UIViewController *daysViewController = [[UIViewController alloc]init];
 
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
    if(pageContentViewController)
    {
        [self.activeViewControllers addObject:pageContentViewController];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    
//    
//    _pageTitles = @[@"Over 200 Tips and Tricks", @"Discover Hidden Features", @"Bookmark Favorite Tip", @"Free Regular Update"];
//    _pageImages = @[@"page1.jpg", @"page2.jpeg", @"page3.png", @"page4.png"];
    
    [self createViewControllers];
    
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
 // UIViewController *startingViewController = [self viewControllerAtIndex:0];
    UIViewController *startingViewController = [self.activeViewControllers objectAtIndex:0];
//    NSArray *viewControllers = @[startingViewController];
    
    if(self.activeViewControllers.count)
    {
    [self.pageViewController setViewControllers:self.activeViewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)startWalkThrough:(id)sender {
//    
//    UIViewController *startingViewController = [self viewControllerAtIndex:0];
//    NSArray *viewControllers = @[startingViewController];
//    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
//}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
return [self.activeViewControllers objectAtIndex:index];}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;

    return [self.activeViewControllers objectAtIndex:index];//[self viewControllerAtIndex:index];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
//    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];

    //pageContentViewController.imageFile = self.pageImages[index];
    
    
    
//    if (self.pageImages && index < self.pageImages.count) {
//        
//        NSString *imageName = self.pageImages[index];
//        
//        if(imageName.length) {
//
    //            pageContentViewController.imageFile = imageName;
//
//        }
//        
//        pageContentViewController.titleText = self.pageTitles[index];
//        pageContentViewController.pageIndex = index;
//        
//        
//    }
    UIViewController *activeViewController;
    if(self.activeViewControllers && index < self.activeViewControllers.count)
    {
        
    activeViewController = [self.activeViewControllers objectAtIndex:index];
        
        //activeViewController   = [self.storyboard instantiateViewControllerWithIdentifier:viewControllerName];
        if(!activeViewController)
            return nil;
    }
    
    return activeViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}
@end
