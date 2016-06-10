//
//  CustomizeScrollView.m
//  PushViewControllerPOC
//
//  Created by Prsenjit Goswami on 6/9/16.
//  Copyright © 2016 Manu's Sena's. All rights reserved.
//

#import "CustomizeScrollView.h"

@implementation CustomizeScrollView

- (id)initWithItem:(NSInteger)item {
    
    self = [super init];
  
    if(self) {
       
        // create UI
    }
    return self;
}

- (void)createUIWithItem:(NSInteger)item {
    
    NSMutableArray *titlesArray = [[NSMutableArray alloc]initWithObjects:@"list",@"days",@"PageContent",nil];
    
    for (int i = 0; i < item; i ++ )  {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 30, 300, 50)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        label.text = [titlesArray objectAtIndex:i];
        //[self.view addSubview:label];

        
    }
    
}
@end
