//
//  RefreshControlElement.m
//  GrandRefreshControl
//
//  Created by jack on 16/11/3.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "RefreshControlElement.h"
const CGFloat RefreshControlContentHeight       = 40;
const CGFloat RefreshControlContentInset        = 60;
const CGFloat RefreshArrowImageWidth            = 15;
const CGFloat RefreshAnimationDuration          = 0.3f;
const CGFloat RefreshTimeIntervalDuration       = 0.1f;

@implementation RefreshControlElement

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if ([newSuperview isKindOfClass:[UICollectionView class]]) {
        ((UICollectionView *)newSuperview).alwaysBounceVertical = YES;
    }
    self.scrollView = (UIScrollView *)newSuperview;
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self afterMoveToSuperview];
    });
}

- (void)afterMoveToSuperview
{
    _arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
    _arrow.frame = CGRectMake((CGRectGetWidth(self.scrollView.frame)-RefreshArrowImageWidth)/2, 0, RefreshArrowImageWidth, RefreshControlContentHeight);
    [self addSubview:_arrow];
}

- (UIActivityIndicatorView *)activity
{
    if (!_activity) {
        _activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activity.frame = self.arrow.frame;
        [_activity setHidesWhenStopped:YES];
        [self addSubview:_activity];
    }
    return _activity;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self refreshControlContentOffsetChange:([change[@"new"] CGPointValue].y) isDragging:self.scrollView.isDragging];
    }
}

- (void)endRefresh
{
    dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.2f animations:^{
                self.scrollView.contentInset = UIEdgeInsetsZero;
                [self.activity stopAnimating];
            }];
    });
    self.arrow.hidden = NO;
}

- (void)refreshControlWillEnterRefreshState
{
    [UIView animateWithDuration:RefreshAnimationDuration animations:^{
        self.arrow.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}

- (void)refreshControlWillQuitRefreshState
{
    [UIView animateWithDuration:RefreshAnimationDuration animations:^{
        self.isRefreshing = NO;
        self.arrow.transform = CGAffineTransformMakeRotation(0);
    }];
}

- (void)refreshControlContentOffsetChange:(CGFloat)y isDragging:(BOOL)dragging{}
- (void)refreshControlRefreshing
{
    if (self.isRefreshing) {
        return;
    }
    self.isRefreshing = YES;

    if (self.refreshAction && self.refreshTarget){
        [self.refreshTarget performSelector:self.refreshAction];
    }
    else{
      if (self.headerHandle) self.headerHandle();
      if (self.footerHandle) self.footerHandle();
    }
    [self.activity startAnimating];
}//正在刷新
- (void)canRefreshAndNotDragging{}//松手并达到刷新状态

@end
