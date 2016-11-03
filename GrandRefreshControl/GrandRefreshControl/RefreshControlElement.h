//
//  RefreshControlElement.h
//  GrandRefreshControl
//
//  Created by jack on 16/11/3.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN const CGFloat RefreshControlContentHeight;
UIKIT_EXTERN const CGFloat RefreshControlContentInset;
UIKIT_EXTERN const CGFloat RefreshAnimationDuration;
UIKIT_EXTERN const CGFloat RefreshArrowImageWidth;


typedef void (^NextStepHandle)();

typedef enum : NSUInteger {
    RefreshHeaderStyle = 0,
    RefreshFooterStyle = 1
} RefreshStyle;

@interface RefreshControlElement : UIView
@property (nonatomic,weak)UIScrollView *scrollView;
@property (nonatomic,strong)UIImageView *arrow;
@property (nonatomic,strong) UIActivityIndicatorView *activity;

@property (nonatomic,assign)BOOL otherIsRefreshing;

@property (nonatomic,copy)NextStepHandle headerHandle;
@property (nonatomic,copy)NextStepHandle footerHandle;

@property (nonatomic,assign)RefreshStyle refreshStyle;

- (void)refreshControlWillEnterRefreshState;//即将进入刷新状态
- (void)refreshControlRefreshing;//正在刷新
- (void)canRefreshAndNotDragging;//松手并达到刷新状态
- (void)refreshControlWillQuitRefreshState;//不满足刷新状态／退出刷新状态
- (void)refreshControlContentOffsetChange:(CGFloat)y isDragging:(BOOL)dragging;
- (void)endRefresh;
@end
