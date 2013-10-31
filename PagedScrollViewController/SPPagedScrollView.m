//
//  SPPagedScrollView.m
//  PagedScrollViewController
//
//  Created by andyzhang on 13-10-31.
//  Copyright (c) 2013年 sporttery.cn. All rights reserved.
//

#import "SPPagedScrollView.h"

@interface SPPagedScrollView ()<UIScrollViewDelegate>

@property (nonatomic,strong)NSMutableArray *pageViews;

- (void)loadVisiblePages;
- (void)loadPage:(NSInteger)page;
- (void)purgePage:(NSInteger)page;

@end

@implementation SPPagedScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addSubview:[[[NSBundle mainBundle] loadNibNamed:@"SPPagedScroll" owner:self options:nil] objectAtIndex:0]];
        
        self.scrollView.delegate =self;
        
        self.pageImages = @[[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"],[UIImage imageNamed:@"5"]];
        
        self.pageControl.currentPage = 0;
        self.pageControl.numberOfPages = self.pageImages.count;
        
        self.pageViews = [@[] mutableCopy];
        
        for (int i=0; i<self.pageImages.count; i++) {
            [self.pageViews addObject:[NSNull null]];
        }

        
        CGSize scrollSize = self.scrollView.frame.size;
        self.scrollView.contentSize = CGSizeMake(scrollSize.width*self.pageImages.count, scrollSize.height);
        
        [self loadVisiblePages];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

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
