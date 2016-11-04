//
//  RefreshHeader.h
//  GrandRefreshControl
//
//  Created by jack on 16/11/3.
//  Copyright © 2016年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshControlElement.h"

@interface RefreshHeader : RefreshControlElement
+ (RefreshHeader *)headerWithNetStep:(void(^)())next;
+ (RefreshHeader *)headerWithTarget:(id)target NextAction:(SEL)action;
@end
