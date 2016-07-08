//
//  ViewController.m
//  Test新闻顶部效果
//
//  Created by iCodeWoods on 16/7/7.
//  Copyright © 2016年 iCodeWoods. All rights reserved.
//

#import "ViewController.h"
#import "NEModel.h"
#import "NETableViewCell.h"
#import "NETopView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

static NSString *const kContentOffset = @"contentOffset";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NETopView *topView;
@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView addObserver:self forKeyPath:kContentOffset options:0 context:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.tableView removeObserver:self forKeyPath:kContentOffset];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:kContentOffset]) { // 监听的是contentOffset的变化
        [self.tableView removeObserver:self forKeyPath:kContentOffset]; // 这里需要先移除监听，否则会导致死循环
        
        CGFloat newY = self.tableView.contentOffset.y; // 获取划动的contentOffset的y值
        CGFloat topY = CGRectGetHeight(self.topView.frame); // topView的高度
        NSLog(@"newY = %f, topY = %f", newY, topY);
        
        if (newY <= 0) { // topView在底部，此时只有tableView动
            NSLog(@"-------------------------------111");
            self.tableView.frame = CGRectMake(0, topY, ScreenWidth, ScreenHeight-topY);
        } else if (newY > 0 && newY < topY-64) { // topView在中间，两者都动
            NSLog(@"-------------------------------222");
            self.tableView.frame = CGRectMake(0, topY-newY, ScreenWidth, ScreenHeight-(topY-newY));
            self.topView.frame = CGRectMake(0, -newY, ScreenWidth, topY);
        } else if (newY >= topY-64) { // topView在顶部，此时只有tableView动
            NSLog(@"-------------------------------333");
            self.tableView.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight-64);
        }

        [self.tableView addObserver:self forKeyPath:kContentOffset options:0 context:nil]; // 结束后再添加监听
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NETableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ideNETableViewCellReuseId forIndexPath:indexPath];
    cell.model = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - getter && setter
- (NETopView *)topView {
    if (!_topView) {
        _topView = [[NETopView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    }
    return _topView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), self.view.frame.size.width, self.view.frame.size.height - self.topView.frame.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[NETableViewCell class] forCellReuseIdentifier:ideNETableViewCellReuseId];
    }
    return _tableView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        /**
         *  假数据
         */
        for (int i = 0; i < 10; i++) {
            NEModel *model = [[NEModel alloc] init];
            model.imgPath = [NSString stringWithFormat:@"%d", 0];
            model.nickname = @"随心所欲w";
            model.content = [NSString stringWithFormat:@"这是第 %d 条评论", i];
            [_dataArray addObject:model];
        }
    }
    return _dataArray;
}

@end

