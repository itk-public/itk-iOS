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
    });
    return manager;
}


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
        BOOL result = [self.db executeUpdate:@"create table not exists t_cartshop (pid text not null,sellerid text not null,num integet not null,selectstate no null);"];
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

//增
-(BOOL)insertCartShopDataBaseModel:(CartShopDataBaseModel *)cartShop
{
    CONDITION_CHECK_RETURN_VAULE([cartShop isKindOfClass:[CartShopDataBaseModel class]], NO);
    CONDITION_CHECK_RETURN_VAULE([cartShop.pid length] || [cartShop.sellerid length], NO);
    BOOL result = NO;
    if ([self.db open]) {
         result = [self.db executeUpdate:@"insert into t_cartshop(pid,sellerid,num,selectstate) values(?,?,?,?);",cartShop.pid,cartShop.sellerid,cartShop.num,cartShop.selectstate];
        if (result) {
            PRLOG(@"创建成功");
        }else{
            PRLOG(@"创建失败");
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
    CONDITION_CHECK_RETURN_VAULE([cartShop isKindOfClass:[CartShopDataBaseModel class]], NO);
    CONDITION_CHECK_RETURN_VAULE([cartShop.pid length] || [cartShop.sellerid length], NO);
    BOOL result = NO;
    if ([self.db open]) {
        BOOL result = [self.db executeUpdate:@"delete from t_cartshop where pid = ? & sellerid = ?",cartShop.pid,cartShop.sellerid];
        if (result) {
            PRLOG(@"删除成功");
        }else{
            PRLOG(@"删除失败");
        }
    }else{
        PRLOG(@"数据库打开失败");
    }
    return result;
}

//更新
-(BOOL)updateCartShopDataBaseModel:(CartShopDataBaseModel *)cartShop
{
    CONDITION_CHECK_RETURN_VAULE([cartShop isKindOfClass:[CartShopDataBaseModel class]], NO);
    CONDITION_CHECK_RETURN_VAULE([cartShop.pid length] || [cartShop.sellerid length], NO);
    BOOL result = NO;
    if ([self.db open]) {
        result = [self.db executeUpdate:@"update t_cartshop set num = ?,selectstate = ? where pid = ? & sellerid = ?"
                  ,cartShop.num,cartShop.selectstate,cartShop.pid,cartShop.sellerid];
    }
    return result;
}

-(NSArray *)queryCartShop{
    NSMutableArray *array = [NSMutableArray array];
    if ([self.db open]) {
        FMResultSet *set = [self.db executeQuery:@"select * from t_cartshop"];
        while ([set next]) {
            NSInteger num = [set intForColumn:@"num"];
            NSString *pid = [set stringForColumn:@"pid"];
            NSString *sellerid = [set stringForColumn:@"sellerid"];
            BOOL     selectstate = [set boolForColumn:@"selectstate"];
            NSDictionary *dic = @{kNumKey:@(num),kPidKey:pid?:@"",kSelleridKey:sellerid?:@"",kSelectstateKey:@(selectstate)};
            CartShopDataBaseModel *cartShop = [CartShopDataBaseModel modelFromDictionary:dic];
            [array safeAddObject:cartShop];
        }
    }
    return array;
}
@end
