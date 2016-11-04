//
//  RefreshHeader.m
//  GrandRefreshControl
//
//  Created by jack on 16/11/3.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "RefreshHeader.h"

@interface RefreshHeader()
@end

@implementation RefreshHeader

+ (RefreshHeader *)headerWithNetStep:(void(^)())next
{
    RefreshHeader *header = [[self alloc]init];
    header.refreshStyle = RefreshHeaderStyle;
    header.headerHandle = next;
    return header;
}

+ (RefreshHeader *)headerWithTarget:(id)target NextAction:(SEL)action
{
    RefreshHeader *header = [[self alloc]init];
    header.refreshStyle = RefreshHeaderStyle;
    header.refreshTarget = target;
    header.refreshAction = action;
    return header;
}

- (void)refreshControlContentOffsetChange:(CGFloat)y isDragging:(BOOL)dragging
{
    NSLog(@"y==%f",y);
    if (y< -RefreshControlContentInset)
    {
        [self refreshControlWillEnterRefreshState];
        if (!dragging) {
            [self refreshControlRefreshing];
        }
        return;
    }
    [self refreshControlWillQuitRefreshState];

}

- (void)refreshControlRefreshing
{
    [super refreshControlRefreshing];
    [UIView animateWithDuration:RefreshTimeIntervalDuration animations:^{
        self.scrollView.contentInset = UIEdgeInsetsMake(RefreshControlContentInset, 0, 0, 0);
    }];
    self.arrow.hidden = YES;
}

@end
