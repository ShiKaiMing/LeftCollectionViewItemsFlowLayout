//
//  SkyLeftItemsModel.h
//  LeftCollectionViewItemsFlowLayout
//
//  Created by fangd@silviscene.com on 2017/5/8.
//  Copyright © 2017年 skm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"
typedef void (^SucessBlock) (NSMutableArray *dataArray);
typedef void (^FailureBlock) (NSError *error);
@interface SkyLeftItemsModel : NSObject
//请求
@property (nonatomic,strong)SucessBlock sucessBlock;
@property (nonatomic,strong)FailureBlock failureBlock;

+(void)dealDataWithSucess:(SucessBlock)sucessBlock FailureBlock:(FailureBlock)failureBlock;
@end

@interface SkyNameModel : NSObject
@property (nonatomic,strong)NSString *NAME;
@property (nonatomic,assign)CGFloat widthCount;
@end
