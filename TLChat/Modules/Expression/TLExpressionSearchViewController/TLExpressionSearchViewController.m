//
//  TLExpressionSearchViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/4.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionSearchViewController.h"
#import "TLExpressionDetailViewController.h"
#import "TLExpressionHelper.h"
#import "TLExpressionCell.h"
#import "TLExpressionGroupModel+SearchRequest.h"

#define         HEGIHT_EXPCELL      80

@interface TLExpressionSearchViewController ()

@property (nonatomic, strong) NSArray *data;

@end

@implementation TLExpressionSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.tableView registerClass:[TLExpressionCell class] forCellReuseIdentifier:@"TLExpressionCell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    
    [self.tableView setFrame:CGRectMake(0, NAVBAR_HEIGHT + STATUSBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - STATUSBAR_HEIGHT - NAVBAR_HEIGHT)];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

#pragma mark - # Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
//    TLExpressionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLExpressionCell"];
//    TLExpressionGroupModel *group = self.data[indexPath.row];
//    [cell setGroup:group];
//    [cell setDelegate:self];
//    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLExpressionGroupModel *group = [self.data objectAtIndex:indexPath.row];
    TLExpressionDetailViewController *detailVC = [[TLExpressionDetailViewController alloc] initWithGroupModel:group];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:detailVC];
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain actionBlick:^{
       [navC dismissViewControllerAnimated:YES completion:^{
           [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
       }];
    }];
    [detailVC.navigationItem setLeftBarButtonItem:closeButton];
    [self presentViewController:navC animated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEGIHT_EXPCELL;
}

//MARK: UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *keyword = searchBar.text;
    if (keyword.length > 0) {
        [TLUIUtility showLoading:nil];
        [TLExpressionGroupModel requestExpressionSearchByKeyword:keyword success:^(NSArray *data) {
            self.data = data;
            [self.tableView reloadData];
            [TLUIUtility hiddenLoading];
        } failure:^(NSString *error) {
            self.data = nil;
            [self.tableView reloadData];
            [TLUIUtility showErrorHint:error];
        }];
    }
}

//MARK: TLExpressionCellDelegate
- (void)expressionCellDownloadButtonDown:(TLExpressionGroupModel *)group
{
    group.status = TLExpressionGroupStatusDownloading;
//    TLExpressionProxy *proxy = [[TLExpressionProxy alloc] init];
//    [TLExpressionGroupModel requestExpressionGroupDetailByGroupID:group.gId pageIndex:1 success:^(id data) {
//        group.data = data;
//        [[TLExpressionHelper sharedHelper] downloadExpressionsWithGroupInfo:group progress:^(CGFloat progress) {
//
//        } success:^(TLExpressionGroupModel *group) {
//            group.status = TLExpressionGroupStatusLocal;
//            NSInteger index = [self.data indexOfObject:group];
//            if (index < self.data.count) {
//                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//            }
//            BOOL ok = [[TLExpressionHelper sharedHelper] addExpressionGroup:group];
//            if (!ok) {
//                [TLUIUtility showErrorHint:[NSString stringWithFormat:@"表情 %@ 存储失败！", group.name]];
//            }
//        } failure:^(TLExpressionGroupModel *group, NSString *error) {
//
//        }];
//    } failure:^(NSString *error) {
//        [TLUIUtility showErrorHint:[NSString stringWithFormat:@"\"%@\" 下载失败: %@", group.name, error]];
//    }];
}


//MARK: UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {

}

@end
