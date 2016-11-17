// 掘金:http://gold.xitu.io/#/user/567bbee434f81a1d8790bd0c
// 简书"http://www.jianshu.com/p/1523c6bd3253
// github:https://github.com/Lafree317

#import "ZERootViewController.h"
#import "ZEHeader.h"
#import "ZETableViewController.h"
#import "ZEHeaderView.h"
#import "ZETopView.h"

@interface ZERootViewController ()<UIScrollViewDelegate,ZETableViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *tableViewArr;// 存放tableView的数组
@property (strong, nonatomic) UIScrollView *backgroundScrollView;// 底部scrollView
@property (assign, nonatomic) CGFloat scrollY;// 记录纵向偏移量
@property (assign, nonatomic) CGFloat scrollX;// 记录横向偏移量
@property (strong, nonatomic) NSString *navigationTitle;// 顶部标题

@property (strong, nonatomic) ZEHeaderView *headerView;// 顶部展示view

@end

@implementation ZERootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self layoutBackgroundScrollView];
}
- (void)layoutBackgroundScrollView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.backgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight)];
    self.backgroundScrollView.pagingEnabled = YES;
    self.backgroundScrollView.bounces = NO;
    self.backgroundScrollView.delegate = self;
    self.backgroundScrollView.contentSize = CGSizeMake(kScreenWidth * _tagsArr.count, kScreenHeight-64);
    self.tableViewArr = [NSMutableArray array];
    for (int i = 0; i < _tagsArr.count; i++) {
        ZETableViewController *tableViewVC = [[ZETableViewController alloc] initWithStyle:(UITableViewStyleGrouped)];
        tableViewVC.view.frame = CGRectMake(i*kScreenWidth, 0, kScreenWidth, kScreenHeight);
        tableViewVC.tableView.contentInset = UIEdgeInsetsMake(kScrollHorizY, 0, 0, 0);
        tableViewVC.delegate = self;
        tableViewVC.tags = _tagsArr[i];
        [self addChildViewController:tableViewVC];
        [self.tableViewArr addObject:tableViewVC];
        
    }
    [self.backgroundScrollView addSubview:[self.tableViewArr[0] view]];
    [self.view addSubview:self.backgroundScrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_scrollX == scrollView.contentOffset.x) {
        return;
    }
    if (_scrollX >= (-kZEMenuHight - kNavigationHight)) {
        _scrollX = -kZEMenuHight - kNavigationHight;
    }
    for (ZETableViewController *tableVC in _tableViewArr) {
        tableVC.tableView.contentOffset = CGPointMake(0, _scrollY);
    }
    float rate = scrollView.contentOffset.x/kScreenWidth;
    int index = rate + 0.7;
    ZETableViewController *tableVC = self.tableViewArr[index];
    [_backgroundScrollView addSubview:tableVC.view];
    _scrollX = scrollView.contentOffset.x;
}
- (void)tableViewDidScrollPassY:(CGFloat)tableViewScrollY{
    CGFloat seleOffSetY = tableViewScrollY - _scrollY;
    _scrollY = tableViewScrollY;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
