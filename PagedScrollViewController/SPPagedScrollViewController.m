//
//  SPViewController.m
//  PagedScrollViewController
//
//  Created by andyzhang on 13-10-30.
//  Copyright (c) 2013年 sporttery.cn. All rights reserved.
//

#import "SPPagedScrollViewController.h"

@interface SPPagedScrollViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)NSMutableArray *pageViews;

- (void)loadVisiblePages;
- (void)loadPage:(NSInteger)page;
- (void)purgePage:(NSInteger)page;

@end

@implementation SPPagedScrollViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.scrollView.delegate =self;
    
    self.pageImages = @[[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"],[UIImage imageNamed:@"5"]];
    
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = self.pageImages.count;
    
    self.pageViews = [@[] mutableCopy];
    
    for (int i=0; i<self.pageImages.count; i++) {
        [self.pageViews addObject:[NSNull null]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CGSize scrollSize = self.scrollView.frame.size;
    self.scrollView.contentSize = CGSizeMake(scrollSize.width*self.pageImages.count, scrollSize.height);
    
    [self loadVisiblePages];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadVisiblePages
{
    CGFloat offsetX =  self.scrollView.contentOffset.x;
    CGFloat numberIndex = floorf(offsetX/self.scrollView.frame.size.width);
    self.pageControl.currentPage = numberIndex;
    
    for (int i=0; i<self.pageImages.count; i++) {
        if (i<=numberIndex+1 && i>=numberIndex-1) {
            [self loadPage:i];
        }else{
            [self purgePage:i];
        }
    }
}

- (void)loadPage:(NSInteger)page
{
    if (page <0 || page>=self.pageImages.count) {
        return;
    }
    
    CGRect imageRect = self.scrollView.bounds;

    UIView *imageView = self.pageViews[page];
    if ((NSNull *)imageView == [NSNull null]) {
        imageView = [[UIImageView alloc] initWithImage:self.pageImages[page]];
        imageView.frame = CGRectMake(imageRect.size.width*page, 0, imageRect.size.width, imageRect.size.height );
        [self.scrollView addSubview:imageView];
        
        [self.pageViews replaceObjectAtIndex:page withObject:imageView];
    }
}

- (void)purgePage:(NSInteger)page
{
    if (page <0 || page>=self.pageImages.count) {
        return;
    }
    UIView *imageView = self.pageViews[page];
    if ((NSNull *)imageView != [NSNull null]) {

        [self.pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self loadVisiblePages];
}

@end
