//
//  utilities.m
//  cex
//
//  Created by taufiq on 10/24/13.
//
//

#import "utilities.h"

@implementation utilities



static sqlite3 *contactDB = nil;




+(BOOL)makeDBCopy:(NSString *)path
{
    BOOL success;
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
	
    success = [fileManager fileExistsAtPath:path];
    if (success) return YES;
    
    if (!success) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"branch_new.sqlite"];
        success = [fileManager copyItemAtPath:defaultDBPath toPath:path error:&error];
        if (!success) {
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
            return NO;
        }
        
        defaultDBPath = Nil;
    }
    
	fileManager = Nil;
    error = Nil;
    return YES;
}


+(BOOL)addColumnTable:(NSString *)table column:(NSString *)columnName type:(NSString *)columnType dbpath:(NSString *)path
{
    sqlite3_stmt *statement;
    if (sqlite3_open([path UTF8String], &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:@"ALTER TABLE %@ ADD COLUMN %@ %@",table,columnName,columnType];
        
        if (sqlite3_prepare_v2(contactDB, [querySQL UTF8String], -1, &statement, NULL) != SQLITE_OK) {
            return NO;
        }
        
        sqlite3_exec(contactDB, [querySQL UTF8String], NULL, NULL, NULL);
        return YES;
        sqlite3_close(contactDB);
    }
    return YES;
}




@end
