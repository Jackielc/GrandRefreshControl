//
//  RefreshFooter.m
//  GrandRefreshControl
//
//  Created by jack on 16/11/3.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "RefreshFooter.h"

@interface RefreshFooter()
@end

@implementation RefreshFooter
{
    CGFloat superViewLastContentHeight;
}

+ (RefreshFooter *)footerWithNextStep:(void(^)())next
{
    RefreshFooter *footer = [[self alloc]init];
    footer.footerHandle = next;
    return footer;
}

+ (RefreshFooter *)footerWithTarget:(id)target nextAction:(SEL)action
{
    RefreshFooter *footer = [[self alloc]init];
    footer.refreshTarget = target;
    footer.refreshAction = action;
    return footer;
}

- (void)afterMoveToSuperview
{
    [super afterMoveToSuperview];
    self.frame = CGRectMake(0, self.scrollView.contentSize.height, self.scrollView.frame.size.width, RefreshControlContentHeight);
    self.arrow.transform = CGAffineTransformMakeRotation(M_PI);
}

- (void)refreshControlContentOffsetDidChange:(CGFloat)y isDragging:(BOOL)dragging
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (y >= self.scrollView.contentSize.height - self.scrollView.frame.size.height + RefreshControlContentInset&& y>RefreshControlContentInset)
        {
            [self refreshControlWillEnterRefreshState];
            if (!dragging) {
                [self refreshControlRefreshing];
            }
            return;
        }
        [self refreshControlWillQuitRefreshState];
    });
}

- (void)refreshControlContentSizeDidChange:(CGFloat)height
{
    if (superViewLastContentHeight == height) {
        return;
    }
    CGRect rect = self.frame;
    rect.origin.y = height;
    self.frame = rect;
    superViewLastContentHeight = height;
}

- (void)refreshControlWillQuitRefreshState
{
    [UIView animateWithDuration:RefreshControlAnimationDuration animations:^{
        self.isRefreshing = NO;
        self.arrow.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}

- (void)refreshControlWillEnterRefreshState
{
   [UIView animateWithDuration:RefreshControlAnimationDuration animations:^{
       self.arrow.transform = CGAffineTransformMakeRotation(0);
   }];
}

- (void)refreshControlRefreshing
{
    [super refreshControlRefreshing];
    [UIView animateWithDuration:RefreshControlTimeIntervalDuration animations:^{
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, RefreshControlContentInset, 0);
    }];
    self.arrow.hidden = YES;
}
@end
