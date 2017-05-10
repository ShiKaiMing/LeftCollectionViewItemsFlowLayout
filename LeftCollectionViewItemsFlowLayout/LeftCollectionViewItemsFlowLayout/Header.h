//
//  Header.h
//  Cell'sNotToReuse
//
//  Created by fangd@silviscene.com on 2017/5/5.
//  Copyright © 2017年 skm. All rights reserved.
//

#ifndef Header_h
#define Header_h
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
//防止循环引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
//解决xcode8输出问题
#ifdef DEBUG
#define SLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define SLog(format, ...)
#endif

//颜色
#define kRGBColor(r, g, b)    [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define kColorWithHex(rgbValue) \
  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
  green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 \
  blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]



#import "MJExtension.h"
#import "Masonry.h"
#endif /* Header_h */
