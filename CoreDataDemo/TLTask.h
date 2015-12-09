//
//  TLTask.h
//  CoreDataDemo
//
//  Created by alejandro henao on 12/8/15.
//  Copyright (c) 2015 HenServer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TLTaskList;

@interface TLTask : NSManagedObject

@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) TLTaskList *list;

@end
