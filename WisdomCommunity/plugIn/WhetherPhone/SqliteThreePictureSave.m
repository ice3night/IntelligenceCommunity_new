//
//  SqliteThreePictureSave.m
//  WisdomCommunity
//
//  Created by bridge on 17/3/20.
//  Copyright © 2017年 bridge. All rights reserved.
//

#import "SqliteThreePictureSave.h"
#import <sqlite3.h> //导入sqlite3的头文件
@implementation SqliteThreePictureSave
//生成路径
+ (NSString *)path
{
    NSArray *documentArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [documentArr firstObject];//第一个数据，为空则设置为nil
    return path;
}
//创建数据库
+ (void)useSqlite
{
    NSString *path = [[self path] stringByAppendingPathComponent:@"PictureUrlSave.sqlite"];
    //判断是否已有了此路径
    if (![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        sqlite3 *database;
        //打开数据库，没有数据库时创建
        int databaseResult = sqlite3_open([path UTF8String], &database);
        if (databaseResult != SQLITE_OK){
            NSLog(@"创建／打开数据库失败,%d",databaseResult);
        }
        else
        {
            NSLog(@"创建数据库成功");
            char *error;
            //    建表格式: create table if not exists 表名 (列名 类型,....)    注: 如需生成默认增加的id: id integer primary key autoincrement
            const char *createSQL = "CREATE TABLE if not exists peopleInfo(peopleInfoID integer primary key, pictureUrl text);";
            
            int tableResult = sqlite3_exec(database, createSQL, NULL, NULL, &error);
            
            if (tableResult != SQLITE_OK) {
                
                NSLog(@"创建表失败:%s",error);
            }
            else
            {
                NSLog(@"创建表成功");
                //关闭数据库
                sqlite3_close(database);
            }
        }
    }
    else
    {
        NSLog(@"已有路径");
    }
}
//查看所有数据
+ (void) check:(NSString *) string
{
    
    //查询语句
    NSString *query = [NSString stringWithFormat:@"select %@ from peopleInfo",string];
    //创建sqlite3对象
    sqlite3 *sqlite3DatabaseUpdate;
    //设置数据库路径
    NSString *databasePath = [[SqliteThreePictureSave path] stringByAppendingPathComponent:@"PictureUrlSave.sqlite"];
    //打开数据库
    BOOL openDatabaseResult = sqlite3_open([databasePath UTF8String], &sqlite3DatabaseUpdate);
    //存放查询的总数据
    NSMutableArray *arrAllData = [[NSMutableArray alloc] init];
    //存放表头
    NSMutableArray *arrDataHead = [[NSMutableArray alloc] init];
    if (openDatabaseResult == SQLITE_OK)
    {
        //声明一个sqlite3对象，存储查询结果
        sqlite3_stmt *complitedStatement;
        //将所有的数据加载到内存
        BOOL perpareStatementResult = sqlite3_prepare_v2(sqlite3DatabaseUpdate, [query UTF8String], -1, &complitedStatement, NULL);
        if (perpareStatementResult == SQLITE_OK)
        {
            //保存每一行数据
            NSMutableArray *arrDataRow;
            //将结果一行行地添加到arrDataRow中
            while (sqlite3_step(complitedStatement) == SQLITE_ROW)
            {
                //初始化arrDataRow
                arrDataRow = [[NSMutableArray alloc] init];
                //获得列数
                int totalColumns = sqlite3_column_count(complitedStatement);
                //读取和保存每一行的数据
                for (int i = 0; i < totalColumns;  i ++)
                {
                    //将数据转为char
                    char *dbDataAdChars = (char *)sqlite3_column_text(complitedStatement, i);
                    //数据不为空时添加到arrDataRow中
                    if (dbDataAdChars != NULL) {
                        //将char装维string
                        [arrDataRow addObject:[NSString stringWithUTF8String:dbDataAdChars]];
                    }
                    //只保存前几条，即头部数据
                    if (arrDataHead.count != totalColumns) {
                        dbDataAdChars = (char *)sqlite3_column_name(complitedStatement, i);
                        [arrDataHead addObject:[NSString stringWithUTF8String:dbDataAdChars]];
                    }
                }
                //如果数据不为空，将此行数据保存下来
                if (arrDataRow.count > 0) {
                    [arrAllData addObject:arrDataRow];
                }
            }
        }
        //释放内存
        sqlite3_finalize(complitedStatement);
    }
    else
    {
        NSLog(@"打开失败");
    }
    //关闭数据库
    sqlite3_close(sqlite3DatabaseUpdate);
    NSLog(@"总数据 = %@,表头 = %@",arrAllData,arrDataHead);
}
//插入数据
+ (void) insert:(NSString *) pictureUrl
{
    NSString *query  = [NSString stringWithFormat:@"insert into peopleInfo values('%@')",pictureUrl];
    //创建一个sqlite3对象
    sqlite3 *sqlite3DatabaseInsert;
    //设置数据库路径
    NSString *databasePath = [[self path] stringByAppendingPathComponent:@"PictureUrlSave.sqlite"];
    //打开数据库
    BOOL openDatabaseResult = sqlite3_open([databasePath UTF8String], &sqlite3DatabaseInsert);
    if (openDatabaseResult == SQLITE_OK)
    {
        //声明一个对象
        sqlite3_stmt *compiledStatement;
        //存储
        BOOL prepareStatementResult = sqlite3_prepare_v2(sqlite3DatabaseInsert, [query UTF8String], -1, &compiledStatement, NULL);
        if (prepareStatementResult == SQLITE_OK)
        {
            if (sqlite3_step(compiledStatement) == SQLITE_DONE)
            {
                sqlite3_last_insert_rowid(sqlite3DatabaseInsert);
                NSLog(@"插入OK");
            }
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(sqlite3DatabaseInsert);
}



@end
