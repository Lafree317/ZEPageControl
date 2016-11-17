//
//  ZEUserMenuView.h
//  个人主页2
//
//  Created by huchunyuan on 16/2/22.
//  Copyright © 2016年 Lafree. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol ZEMenuViewDelegate <NSObject>

- (void)MenuClikcButtonPassIndex:(NSInteger)index;
- (void)refreshWithIndex:(NSInteger)index;
@end


@interface ZEMenuView : UIView
/** 下划线 */
@property (strong, nonatomic) UIView *lineView;
@property (assign, nonatomic) id<ZEMenuViewDelegate> delegate;

- (UIView *)initWithArray:(NSArray *)arr
                    frame:(CGRect)frame;
/** 下划线移动方法 */
- (void)SelectedBtnMoveToCenterWithIndex:(int)index WithRate:(CGFloat)Pagerate;
- (void)changeTitleWithArr:(NSArray *)arr refresh:(BOOL)refresh;
@end
