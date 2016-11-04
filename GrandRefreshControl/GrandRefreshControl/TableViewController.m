//
//  TableViewController.m
//  GrandRefreshControl
//
//  Created by jack on 16/11/4.
//  Copyright © 2016年 jack. All rights reserved.
//

#import "TableViewController.h"
#import "RefreshControl.h"

@interface TableViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    //    self.tableView.header = [RefreshHeader headerWithNetStep:^{
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            [self.tableView.header endRefresh];
    //        });
    //    }];
    //    self.tableView.footer = [RefreshFooter footerWithNetStep:^{
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            [self.tableView.footer endRefresh];
    //        });
    //    }];
    
    self.tableView.header = [RefreshHeader headerWithTarget:self NextAction:@selector(nslog)];
    self.tableView.footer = [RefreshFooter footerWithTarget:self NextAction:@selector(nslog)];}

- (void)nslog
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.header endRefresh];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.footer endRefresh];
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"push" sender:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
