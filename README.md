# GrandRefreshControl
刷新控件
===

主要是实现一个思路，没什么技术难点
---

UITableView、UICollectionView
---

```objective-c
#import "GrandRefreshControl.h"
```
实现了两种刷新响应方式
---
```objective-c

// 方法选择器

//case tableView
    self.tableView.header = [RefreshHeader headerWithTarget:self NextAction:@selector(nslog)];
    self.tableView.footer = [RefreshFooter footerWithTarget:self NextAction:@selector(nslog)];

//case collectionView
    self.collectionView.header = [RefreshHeader headerWithTarget:self NextAction:@selector(nslog)];
    self.collectionView.footer = [RefreshFooter footerWithTarget:self NextAction:@selector(nslog)];

// 传统的block方式

//case tableView
    self.tableView.header = [RefreshHeader headerWithNetStep:^{
            [self request];
    }];
    self.tableView.footer = [RefreshFooter footerWithNetStep:^{
            [self request];
    }];
//case collectionView
   self.collectionView.header = [RefreshHeader headerWithNetStep:^{
            [self request];
    }];
    self.collectionView.footer = [RefreshFooter footerWithNetStep:^{
            [self request];
    }];
```
