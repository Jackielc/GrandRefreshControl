//
//  CollectionViewController.m
//  GrandRefreshControl
//
//  Created by jack on 16/11/4.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "CollectionViewController.h"
#import "RefreshControl.h"

@interface CollectionViewController ()
@property (nonatomic,weak)IBOutlet UICollectionView *collectionView;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width/4 , [UIScreen mainScreen].bounds.size.width/4);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.header = [RefreshHeader headerWithTarget:self NextAction:@selector(nslog)];
    self.collectionView.footer = [RefreshFooter footerWithTarget:self NextAction:@selector(nslog)];
}

- (void)nslog
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView.header endRefresh];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView.footer endRefresh];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UICollectionViewCell alloc]init];
    }
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
