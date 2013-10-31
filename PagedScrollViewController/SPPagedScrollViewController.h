//
//  SPViewController.h
//  PagedScrollViewController
//
//  Created by andyzhang on 13-10-30.
//  Copyright (c) 2013年 sporttery.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPPagedScrollViewController : UIViewController

@property (nonatomic,strong)NSArray *pageImages;
@property (nonatomic,strong)IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong)IBOutlet UIPageControl *pageControl;

@end
