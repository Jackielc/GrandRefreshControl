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

+ (RefreshHeader *)HeaderWithNetStep:(void(^)())next
{
    RefreshHeader *header = [[self alloc]init];
    header.refreshStyle = RefreshHeaderStyle;
    header.headerHandle = next;
    return header;
}

- (void)refreshControlContentOffsetChange:(CGFloat)y isDragging:(BOOL)dragging
{
    if (y<-RefreshControlContentInset)
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
    [UIView animateWithDuration:0.1f animations:^{
        self.scrollView.contentInset = UIEdgeInsetsMake(RefreshControlContentInset, 0, 0, 0);
    }];
    self.arrow.hidden = YES;
}

@end
