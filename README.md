# GrandRefreshControl
刷新控件,主要是实现一个思路，没什么技术难点
---

导入
---

```objective-c
#import "GrandRefreshControl.h"
```
实现了两种刷新响应方式
===

方法选择器
---
```objective-c
//case tableView
    self.tableView.header = [RefreshHeader headerWithTarget:self NextAction:@selector(nslog)];
    self.tableView.footer = [RefreshFooter footerWithTarget:self NextAction:@selector(nslog)];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          [self.tableView.header endRefresh];
          [self.tableView.footer endRefresh];
    });
//case collectionView
    self.collectionView.header = [RefreshHeader headerWithTarget:self NextAction:@selector(nslog)];
    self.collectionView.footer = [RefreshFooter footerWithTarget:self NextAction:@selector(nslog)];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          [self.collectionView.header endRefresh];
          [self.collectionView.footer endRefresh];
    });
```
闭包
---
```objective-c
//case tableView
    self.tableView.header = [RefreshHeader headerWithNextStep:^{
            [self request];
    }];
    self.tableView.footer = [RefreshFooter footerWithNextStep:^{
            [self request];
    }];
//case collectionView
   self.collectionView.header = [RefreshHeader headerWithNextStep:^{
            [self request];
    }];
    self.collectionView.footer = [RefreshFooter footerWithNextStep:^{
            [self request];
    }];
```
