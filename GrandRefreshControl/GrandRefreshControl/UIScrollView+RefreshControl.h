//
//  UIScrollView+RefreshControl.h
//  GrandRefreshControl
//
//  Created by jack on 16/11/3.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshHeader.h"
#import "RefreshFooter.h"

@interface UIScrollView (RefreshControl)<UIScrollViewDelegate>

@property (nonatomic,strong)RefreshHeader *header;
@property (nonatomic,strong)RefreshFooter *footer;
@end
