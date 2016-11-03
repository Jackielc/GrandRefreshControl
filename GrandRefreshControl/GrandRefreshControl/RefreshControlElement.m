//
//  RefreshControlElement.m
//  GrandRefreshControl
//
//  Created by jack on 16/11/3.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "RefreshControlElement.h"
const CGFloat RefreshControlContentHeight       = 40;
const CGFloat RefreshControlContentInset        = 80;
const CGFloat RefreshArrowImageWidth            = 15;
const CGFloat RefreshAnimationDuration          = 0.3f;

@implementation RefreshControlElement

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    self.scrollView = (UIScrollView *)newSuperview;
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    _arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
    _arrow.frame = CGRectMake((CGRectGetWidth(self.scrollView.frame)-RefreshArrowImageWidth)/2, 0, RefreshArrowImageWidth, RefreshControlContentHeight);
    [self addSubview:_arrow];
    switch (self.refreshStyle) {
        case RefreshFooterStyle:{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.frame = CGRectMake(0, self.scrollView.contentSize.height+RefreshControlContentHeight, self.scrollView.frame.size.width, RefreshControlContentHeight);
            });
        }
            break;
        default:
            self.frame = CGRectMake(0, -RefreshControlContentHeight, self.scrollView.frame.size.width, RefreshControlContentHeight);
            break;
    }
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
                self.arrow.hidden = NO;
            }];
    });
}

- (void)refreshControlWillEnterRefreshState
{
    [UIView animateWithDuration:RefreshAnimationDuration animations:^{
        self.arrow.transform = CGAffineTransformMakeRotation(M_PI);
    }];}

- (void)refreshControlWillQuitRefreshState
{
    [UIView animateWithDuration:RefreshAnimationDuration animations:^{
        self.arrow.transform = CGAffineTransformMakeRotation(0);
    }];
}

- (void)refreshControlContentOffsetChange:(CGFloat)y isDragging:(BOOL)dragging{}
- (void)refreshControlRefreshing
{
    if (self.headerHandle) self.headerHandle();
    if (self.footerHandle) self.footerHandle();
    [self.activity startAnimating];
}//正在刷新
- (void)canRefreshAndNotDragging{}//松手并达到刷新状态

@end
