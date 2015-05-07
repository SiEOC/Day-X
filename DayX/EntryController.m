//
//  EntryController.m
//  DayX
//
//  Created by Michael Sacks on 5/6/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "EntryController.h"
@interface EntryController ()

@property (strong, nonatomic) NSArray *allEntries;

@end

@implementation EntryController

+ (EntryController *)sharedInstance{
    static EntryController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [EntryController new];
        sharedInstance.allEntries = [NSArray new];
    });
    
    return sharedInstance;
}

- (void)addEntry:(Entry *)entry{
    NSMutableArray *mutable = [self.allEntries mutableCopy];
    [mutable addObject:entry];
    self.allEntries = mutable;
}

- (void)removeEntry:(Entry *)entry{
    NSMutableArray *mutable = [self.allEntries mutableCopy];
    [mutable removeObject:entry];
    self.allEntries = mutable;
}

- (Entry *)createEntryWithTitle:(NSString *)title withBodyText:(NSString *)bodyText{
    Entry *entry = [Entry new];
    entry.title = title;
    entry.bodyText = bodyText;
    entry.timestamp = [NSDate date];
    
    [self addEntry:entry];
    return entry;
}


@end
