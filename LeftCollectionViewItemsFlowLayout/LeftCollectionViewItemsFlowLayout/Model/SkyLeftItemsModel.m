//
//  SkyLeftItemsModel.m
//  LeftCollectionViewItemsFlowLayout
//
//  Created by fangd@silviscene.com on 2017/5/8.
//  Copyright © 2017年 skm. All rights reserved.
//

#import "SkyLeftItemsModel.h"
@interface SkyLeftItemsModel()
@property (nonatomic,strong)NSMutableDictionary *dataDictionary;
@end
@class SkyNameModel;
@implementation SkyLeftItemsModel
- (NSMutableDictionary *)dataDictionary
{
    if (_dataDictionary == nil) {
        _dataDictionary = [NSMutableDictionary dictionary];
    }
    return _dataDictionary;
}
+(void)dealDataWithSucess:(SucessBlock)sucessBlock FailureBlock:(FailureBlock)failureBlock
{
    //热门
    __block SkyLeftItemsModel *skyLeftItemsModel = [[SkyLeftItemsModel alloc]init];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[skyLeftItemsModel dictionaryForName] options:0 error:NULL];
    [skyLeftItemsModel dealWithResponseObject:jsonData WithModel:@"SkyNameModel"];
    sucessBlock(skyLeftItemsModel.dataDictionary);
}
- (NSDictionary *)dictionaryForName
{
    NSDictionary *dic = @{@"List":@[
                                  @{@"NAME":@"一二三四五六七八九"},
                                  @{@"NAME":@"一二三"},
                                  @{@"NAME":@"一二三四五六七"},
                                  @{@"NAME":@"一二三四"},
                                  @{@"NAME":@"一二三四五六七八"},
                                  @{@"NAME":@"一二三四五六"},
                                  @{@"NAME":@"一二三"},
                                  @{@"NAME":@"一二三四五六"},
                                  @{@"NAME":@"一二三四"},
                                  @{@"NAME":@"一二三四五"},
                                  @{@"NAME":@"一二三"},
                                  @{@"NAME":@"一二三"}
                                  ]};
    
    return dic;
}
- (void)dealWithResponseObject:(NSData *)data WithModel:(NSString *)model
{
    NSDictionary*arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *modelArray = [NSMutableArray array];
    
    if ([model isEqualToString:@"SkyNameModel"]) {
        [modelArray addObjectsFromArray:[SkyNameModel mj_objectArrayWithKeyValuesArray:arr[@"List"]]];
    }
    self.dataDictionary[model] = modelArray;
}
@end
@implementation SkyNameModel
- (void)setNAME:(NSString *)NAME
{
    if (_NAME != NAME) {
        _NAME = NAME;
        [self eachRouteWithNAME:NAME];
    }
}
//计算NAME需要的宽度
- (void)eachRouteWithNAME:(NSString *)NAME
{
    CGSize widthSize = CGSizeMake(MAXFLOAT,44);
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:16.f ]};
//    CGRect baseRect = [@"基准" boundingRectWithSize:widthSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    CGRect DESTIDRect = [NAME boundingRectWithSize:widthSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    self.widthCount = DESTIDRect.size.width;
}
@end
