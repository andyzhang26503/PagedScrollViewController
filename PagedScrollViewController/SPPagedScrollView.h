//
//  SPPagedScrollView.h
//  PagedScrollViewController
//
//  Created by andyzhang on 13-10-31.
//  Copyright (c) 2013年 sporttery.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPPagedScrollView : UIView

@property (nonatomic,strong)NSArray *pageImages;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end
