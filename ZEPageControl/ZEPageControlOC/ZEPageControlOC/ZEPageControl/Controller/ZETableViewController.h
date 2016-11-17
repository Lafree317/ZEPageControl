// 掘金:http://gold.xitu.io/#/user/567bbee434f81a1d8790bd0c
// 简书"http://www.jianshu.com/p/1523c6bd3253
// github:https://github.com/Lafree317

#import <UIKit/UIKit.h>

@protocol ZETableViewControllerDelegate <NSObject>

- (void)tableViewDidScrollPassY:(CGFloat)tableViewScrollY;

@end

@interface ZETableViewController : UITableViewController
@property (strong, nonatomic) NSString *tags;
@property (assign, nonatomic) id<ZETableViewControllerDelegate> delegate;
@end
