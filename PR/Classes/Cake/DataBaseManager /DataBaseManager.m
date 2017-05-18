//
//  DataBaseManager.m
//  PR
//
//  Created by 黄小雪 on 27/02/2017.
//  Copyright © 2017 黄小雪. All rights reserved.
//

#import "DataBaseManager.h"
#import "FMDatabase.h"

static DataBaseManager *manager = nil;

@interface DataBaseManager()
@property (strong,nonatomic) FMDatabase *db;

@end
@implementation DataBaseManager

+(instancetype)sharedDataBaseManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataBaseManager alloc]init];
        [manager createDataBase];
        [manager createTable];
    });
    return manager;
}

#pragma mark private method
//创建数据库
-(void)createDataBase
{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES)firstObject];
    NSString *filePath = [doc stringByAppendingPathComponent:@"cartshop.sqlite"];
    //创建数据库
    self.db  = [FMDatabase databaseWithPath:filePath];
}

//创建表
-(void)createTable{
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_cartshop (pid text,shopid text ,num integer,selectstate integer)"];
        if (result) {
            PRLOG(@"创建成功");
        }else{
            PRLOG(@"创建失败");
        }
        [self.db close];
    }else{
        PRLOG(@"数据库打开失败");
    }
}


-(CartShopDataBaseModel *)cartShopInResultSet:(FMResultSet *)set
{
    NSInteger num = [set intForColumn:@"num"];
    NSString *pid = [set stringForColumn:@"pid"];
    NSString *shopid = [set stringForColumn:@"shopid"];
    BOOL     selectstate = [set boolForColumn:@"selectstate"];
    NSDictionary *dic = @{kNumKey:@(num),kPidKey:pid?:@"",kShopIdKey:shopid?:@"",kIsSelectedKey:@(selectstate)};
    CartShopDataBaseModel *cartShop = [CartShopDataBaseModel modelFromDictionary:dic];
    return cartShop;
}
#pragma mark public method
//增
-(BOOL)insertCartShopDataBaseModel:(CartShopDataBaseModel *)cartShop
{
    BOOL result = NO;
    if ([self.db open]) {
        NSInteger isSelected = cartShop.isSelected?1:0;
         result = [self.db executeUpdate:@"INSERT INTO t_cartshop (pid,shopid,num,selectstate) VALUES (?,?,?,?)",cartShop.cid,cartShop.shopId,@(cartShop.num),@(isSelected)];
        if (result) {
            PRLOG(@"添加数据库商品成功");
        }else{
            PRLOG(@"添加数据库商品失败");
        }
        [self.db close];
    }else{
        PRLOG(@"数据库打开失败");
        
    }
    return result;
}

//删除
-(BOOL)deleteCartShopDataBaseModel:(CartShopDataBaseModel *)cartShop
{
    BOOL result = NO;
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"delete from t_cartshop where pid = ? & shopid = ?",cartShop.cid,cartShop.shopId];
        if (result) {
            PRLOG(@"删除成功");
        }else{
            PRLOG(@"删除失败");
        }
        [self.db close];
    }else{
        PRLOG(@"数据库打开失败");
    }
    return result;
}

- (BOOL)deleteAllProducts
{
    BOOL result = NO;
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"delete from t_cartshop"];
        if (result) {
            PRLOG(@"删除成功");
        }else{
            PRLOG(@"删除失败");
        }
        [self.db close];
    }else{
        PRLOG(@"数据库打开失败");
    }
    return result;
}
//更新
-(BOOL)updateCartShopDataBaseModel:(CartShopDataBaseModel *)cartShop
{
    BOOL result = NO;
    if ([self.db open]) {
        NSInteger isSelected = cartShop.isSelected?1:0;
        result = [self.db executeUpdate:@"update t_cartshop set num = ?,selectstate = ? where pid = ? and shopid = ?"
                  ,@(cartShop.num),@(isSelected),cartShop.cid,cartShop.shopId];
        if(result){
            PRLOG(@"更新成功");
        }else{
            PRLOG(@"更新失败");
        }
        [self.db close];
    }
    return result;
}

-(CartShopDataBaseModel *)queryCartShopDataBaseModel:(CartShopDataBaseModel *)cartShop
{
    if ([self.db open]) {
        FMResultSet *set = [self.db executeQuery:@"select * from t_cartshop where pid = ? and shopid = ?",cartShop.cid,cartShop.shopId];
        if ([set next]) {
           return [self cartShopInResultSet:set];
        }
        [self.db close];
    }
    return nil;
}

-(NSArray *)queryCartShop{
    NSMutableArray *array = [NSMutableArray array];
    if ([self.db open]) {
        FMResultSet *set = [self.db executeQuery:@"select * from t_cartshop"];
        while ([set next]) {
            CartShopDataBaseModel *cartShop = [self cartShopInResultSet:set];
            [array safeAddObject:cartShop];
        }
        [self.db close];
    }
    return array;
}
@end
