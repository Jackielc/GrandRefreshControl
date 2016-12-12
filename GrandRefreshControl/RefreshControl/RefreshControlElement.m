//
//  RefreshControlElement.m
//  GrandRefreshControl
//
//  Created by jack on 16/11/3.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "RefreshControlElement.h"
#import "RefreshControlConst.h"
#import <objc/message.h>

const CGFloat RefreshControlContentHeight       = 40;
const CGFloat RefreshControlContentInset        = 80;
const CGFloat RefreshControlArrowImageWidth            = 15;
const CGFloat RefreshControlAnimationDuration          = 0.3f;
const CGFloat RefreshControlTimeIntervalDuration       = 0.1f;


@implementation RefreshControlElement

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if ([newSuperview isKindOfClass:[UICollectionView class]]) {
        ((UICollectionView *)newSuperview).alwaysBounceVertical = YES;
    }
    self.scrollView = (UIScrollView *)newSuperview;
    [self removeObservers];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self afterMoveToSuperview];
    });
    [self addObservers];
}


- (void)afterMoveToSuperview
{
    _arrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow"]];
#warning console will input 'error Two-stage rotation animation is deprecated' when rotate arrow. Because this application should use the smoother single-stage animation.that I was simply using the Tab Bar Controller wrong: the tab bar should only be used as a root controller, however I inserted a navigation controller before it.
    _arrow.frame = CGRectMake((CGRectGetWidth(self.scrollView.frame)-RefreshControlArrowImageWidth)/2, 0, RefreshControlArrowImageWidth, RefreshControlContentHeight);
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
    if (!self.isUserInteractionEnabled) return;
    if (self.hidden) return;
    if ([keyPath isEqualToString:RefreshControlObserverKeyPathContentOffset]) {
        [self refreshControlContentOffsetDidChange:([change[@"new"] CGPointValue].y) isDragging:self.scrollView.isDragging];
    }
    if ([keyPath isEqualToString:RefreshControlObserverKeyPathContentSize]) {
        [self refreshControlContentSizeDidChange:([change[@"new"] CGSizeValue].height)];
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
    [UIView animateWithDuration:RefreshControlAnimationDuration animations:^{
        self.arrow.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}

- (void)refreshControlWillQuitRefreshState
{
    [UIView animateWithDuration:RefreshControlAnimationDuration animations:^{
        self.isRefreshing = NO;
        self.arrow.transform = CGAffineTransformMakeRotation(0);
    }];
}

- (void)addObservers
{
    [self.scrollView addObserver:self forKeyPath:RefreshControlObserverKeyPathContentOffset options:NSKeyValueObservingOptionNew context:nil];
    [self.scrollView addObserver:self forKeyPath:RefreshControlObserverKeyPathContentSize options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObservers
{
    [self.superview removeObserver:self forKeyPath:RefreshControlObserverKeyPathContentSize];
    [self.superview removeObserver:self forKeyPath:RefreshControlObserverKeyPathContentOffset];
}

- (void)refreshControlContentOffsetDidChange:(CGFloat)y isDragging:(BOOL)dragging{}
- (void)refreshControlContentSizeDidChange:(CGFloat)height{}
- (void)refreshControlRefreshing
{
    if (self.isRefreshing) {
        return;
    }
    self.isRefreshing = YES;

    if (self.refreshAction && self.refreshTarget&&[self.refreshTarget respondsToSelector:self.refreshAction]){
        [self.refreshTarget performSelector:self.refreshAction];
        RefreshMsgSend(RefreshMsgTarget(self.refreshTarget), self.refreshAction, self);
    }
    else{
      if (self.headerHandle) self.headerHandle();
      if (self.footerHandle) self.footerHandle();
    }
    [self.activity startAnimating];
}//正在刷新
- (void)canRefreshAndNotDragging{}//松手并达到刷新状态

@end
