//
//  RefreshControlElement.h
//  GrandRefreshControl
//
//  Created by jack on 16/11/3.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RefreshMsgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define RefreshMsgTarget(target) (__bridge void *)(target)

UIKIT_EXTERN const CGFloat RefreshControlContentHeight;
UIKIT_EXTERN const CGFloat RefreshControlContentInset;
UIKIT_EXTERN const CGFloat RefreshAnimationDuration;
UIKIT_EXTERN const CGFloat RefreshArrowImageWidth;
UIKIT_EXTERN const CGFloat RefreshTimeIntervalDuration;

typedef void (^NextStepHandle)();

typedef enum : NSUInteger {
    
    RefreshControlStateWillBeRefeshing,
    RefreshControlStateRefreshing,
    RefreshControlStateWillBeFree,
    RefreshControlStateFree
} RefreshState;

@interface RefreshControlElement : UIView
@property (nonatomic,weak)   UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *arrow;
@property (nonatomic,strong) UIActivityIndicatorView *activity;

@property (nonatomic,assign)BOOL isRefreshing;

@property (nonatomic,copy)NextStepHandle headerHandle;
@property (nonatomic,copy)NextStepHandle footerHandle;

@property (nonatomic,weak)id refreshTarget;
@property (nonatomic,assign)SEL refreshAction;

@property (nonatomic,assign)RefreshState refreshStyle;

- (void)refreshControlWillEnterRefreshState;//即将进入刷新状态
- (void)refreshControlRefreshing;//正在刷新
- (void)canRefreshAndNotDragging;//松手并达到刷新状态
- (void)refreshControlWillQuitRefreshState;//不满足刷新状态／退出刷新状态
- (void)refreshControlContentOffsetChange:(CGFloat)y isDragging:(BOOL)dragging;
- (void)endRefresh;

- (void)afterMoveToSuperview;
@end
