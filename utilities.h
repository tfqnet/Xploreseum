//
//  utilities.h
//  cex
//
//  Created by taufiq on 10/24/13.
//
//


/*
 ###########################usage################
 
 
 
 appdelegate.m
 
 NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
 NSString *docsDir = [dirPaths objectAtIndex:0];
 databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent: @"branch_new.sqlite"]];
 
 [utilities makeDBCopy:databasePath];
 [utilities addColumnTable:@"Agent_Profile" column:@"AgentICNo" type:@"INTEGER" dbpath:databasePath];
 [utilities addColumnTable:@"rss_detail" column:@"priority" type:@"INTEGER" dbpath:databasePath];
 
 
 */



#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface utilities : NSObject

+(BOOL)makeDBCopy:(NSString *)path;
+(BOOL)addColumnTable:(NSString *)table column:(NSString *)columnName type:(NSString *)columnType dbpath:(NSString *)path;

@end
