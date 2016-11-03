//  UIScrollView+RefreshControl.m
//  GrandRefreshControl
//
//  Created by jack on 16/11/3.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "UIScrollView+RefreshControl.h"
#import <objc/runtime.h>

@implementation UIScrollView (RefreshControl)

- (void)setHeader:(RefreshHeader *)header
{
    [self addSubview:header];
    objc_setAssociatedObject(self, @selector(header), header, OBJC_ASSOCIATION_ASSIGN);
}

- (RefreshHeader *)header
{
    return objc_getAssociatedObject(self, @selector(header));
}

- (void)setFooter:(RefreshFooter *)footer
{
    [self addSubview:footer];
    objc_setAssociatedObject(self, @selector(footer), footer, OBJC_ASSOCIATION_ASSIGN);
}

- (RefreshFooter *)footer
{
    return objc_getAssociatedObject(self, @selector(footer));
}

@end
