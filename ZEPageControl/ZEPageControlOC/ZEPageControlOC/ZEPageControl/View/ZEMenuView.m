//
//  ZEUserMenuView.m
//  个人主页2
//
//  Created by huchunyuan on 16/2/22.
//  Copyright © 2016年 Lafree. All rights reserved.
//

#import "ZEMenuView.h"
#import "ZEButton.h"
#import "ZEHeader.h"
#import "UIView+Extension.h"

@interface ZEMenuView ()
@property (strong, nonatomic) NSMutableArray *buttonArr;
@end

@implementation ZEMenuView

- (UIView *)initWithArray:(NSArray *)arr frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
    
    // button
    CGFloat buttonW = frame.size.width/arr.count;
    CGFloat buttonH = frame.size.height;
    // 创建Button
    for (int i = 0; i < arr.count; i++) {
        NSDictionary *dic = arr[i];
        ZEButton *button = [ZEButton buttonWithType:(UIButtonTypeCustom)];
        
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        if ([dic.allKeys[0] isEqualToString:@"动态"]) {
            [self changeStateButton:button Select:NO];
        }else{
            NSString *titile = [NSString stringWithFormat:@"%@\n%@",dic.allValues[0],dic.allKeys[0]];
            [button setTitle:titile forState:(UIControlStateNormal)];
        }
        button.titleLabel.numberOfLines = 2;
        [button setTitleColor:kNomalColor forState:(UIControlStateNormal)];
        if (i == 0) {
             [self changeStateButton:button Select:YES];
        }
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.frame = CGRectMake(i*buttonW +10 ,0,buttonW-20, buttonH);
        button.index = i;
        [button addTarget:self action:@selector(buttonclick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:button];
        [self.buttonArr addObject:button];
    }
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-0.5, kScreenWidth, 0.5)];
    buttonView.backgroundColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:0.5]
;
    [self addSubview:buttonView];
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0+10, self.bounds.size.height-2, buttonW-20, 2)];
    self.lineView.backgroundColor = kSelectedColor;
    [self addSubview:_lineView];
    return self;
}

- (void)changeStateButton:(ZEButton *)button
                   Select:(BOOL)isSelect{
    if (isSelect) {
        [button setImage:[UIImage imageNamed:@"feedNewsSelected"] forState:(UIControlStateNormal)];
    }else{
        [button setImage:[UIImage imageNamed:@"feedNews"] forState:(UIControlStateNormal)];
    }
}
- (void)SelectedBtnMoveToCenterWithIndex:(int)index WithRate:(CGFloat)Pagerate
{
    // 计算偏移量
    CGFloat rate = Pagerate - index;
    
    int count = (int)self.buttonArr.count;
    if (Pagerate < 0) return;
    if (index == count-1 || index >= count -1) return;
    if ( rate == 0)    return;
    ZEButton *currentBt = self.buttonArr[index];
    self.lineView.x = currentBt.x + (currentBt.width + 20)*rate;
    
    int page  = (int)(Pagerate +0.5);
    [self changeSelectButtonWithIndex:page];

}
- (void)changeSelectButtonWithIndex:(NSUInteger)index{
    for (ZEButton *button in self.buttonArr) {
        
        if (button != self.buttonArr[index]) {
            if (button.index == 0) {
                [self changeStateButton:button Select:NO];
            }else{
                [button setTitleColor:kNomalColor forState:(UIControlStateNormal)];
            }
            
        }else{
            if (button.index == 0) {
                 [self changeStateButton:button Select:YES];
            }else{
            
                [button setTitleColor:kSelectedColor forState:(UIControlStateNormal)];
            }
        }
    }
}
- (void)buttonclick:(ZEButton *)button{
    // 代理事件
    [_delegate MenuClikcButtonPassIndex:button.index];
    // 改变按钮状态
    [self changeSelectButtonWithIndex:button.index];
    // 下划线偏移
    [UIView animateWithDuration:0.3 animations:^{
        ZEButton *currentBt = button;
        self.lineView.x = currentBt.x;
    }];
}
- (NSMutableArray *)buttonArr{
    if (!_buttonArr) {
        _buttonArr = [NSMutableArray array];
    }
    return _buttonArr;
}

#pragma mark - 蹦过

- (void)changeTitleWithArr:(NSArray *)arr refresh:(BOOL)refresh{
    for (int i = 0; i < self.buttonArr.count; i++) {
        ZEButton *button = self.buttonArr[i];
     
        NSDictionary *dic = arr[i];
        
        if ([dic.allKeys[0] isEqualToString:@"动态"]) {
            
            
        }else{
            
            NSString *titile = [NSString stringWithFormat:@"%@\n%@",dic.allValues[0],dic.allKeys[0]];
            if (![titile isEqualToString:button.titleLabel.text]) {
                if (refresh) {
                    [_delegate refreshWithIndex:i];
                }
            }
            [button setTitle:titile forState:(UIControlStateNormal)];
        }

    }
}
@end
