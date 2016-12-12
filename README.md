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

###tableView
```objective-c
    self.tableView.header = [RefreshHeader headerWithTarget:self nextAction:@selector(request)];
    self.tableView.footer = [RefreshFooter footerWithTarget:self nextAction:@selector(request)];
    
    - (void)request
    {
     [self.tableView.header endRefresh];
     [self.tableView.footer endRefresh];
    }
```
###collectionView
```objective-c
    self.collectionView.header = [RefreshHeader headerWithTarget:self nextAction:@selector(request)];
    self.collectionView.footer = [RefreshFooter footerWithTarget:self nextAction:@selector(request)];
    
    - (void)request
    {
     [self.collectionView.header endRefresh];
     [self.collectionView.footer endRefresh];
    }
```
闭包
---

### tableView
```objective-c
    self.tableView.header = [RefreshHeader headerWithNextStep:^{
          [self request];
    }];
    self.tableView.footer = [RefreshFooter footerWithNextStep:^{
          [self request];
    }];
    
    - (void)request
    {
     [self.collectionView.header endRefresh];
     [self.collectionView.footer endRefresh];
    }
```
###collectionView
```objective-c
   self.collectionView.header = [RefreshHeader headerWithNextStep:^{
            [self request];
    }];
    self.collectionView.footer = [RefreshFooter footerWithNextStep:^{
            [self request];
    }];
    
   - (void)request
    {
     [self.collectionView.header endRefresh];
     [self.collectionView.footer endRefresh];
    }
```
