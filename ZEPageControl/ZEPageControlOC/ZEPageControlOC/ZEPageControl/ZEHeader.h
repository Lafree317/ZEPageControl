// 掘金:http://gold.xitu.io/#/user/567bbee434f81a1d8790bd0c
// 简书"http://www.jianshu.com/p/1523c6bd3253
// github:https://github.com/Lafree317

#ifndef Header_h
#define Header_h

/** 屏幕宽度 */
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kZEHeaderHight 200
#define kZEMenuHight 40
#define kScrollHorizY kZEHeaderHight + kZEMenuHight
#define kNavigationHight  64
//默认时候普通字体颜色124 129 138
#define  kNomalColor [UIColor colorWithRed:124/255.0 green:129/255.0 blue:138/255.0 alpha:1]
//默认时候选中字体颜色 0 127 255
#define kSelectedColor  [UIColor colorWithRed:0/255.0 green:127/255.0 blue:255/255.0 alpha:1]

#endif /* Header_h */
