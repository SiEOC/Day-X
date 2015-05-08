//
//  EntryController.m
//  DayX
//
//  Created by Michael Sacks on 5/6/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "EntryController.h"

static NSString * const allEntriesKey = @"allEntries";

@interface EntryController ()

@property (strong, nonatomic) NSArray *allEntries;

@end

@implementation EntryController

+ (EntryController *)sharedInstance{
    static EntryController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [EntryController new];
        [sharedInstance loadFromPersistentStorage];
    });
    
    return sharedInstance;
}

- (void)addEntry:(Entry *)entry{
    NSMutableArray *mutable = [self.allEntries mutableCopy];
    [mutable addObject:entry];
    self.allEntries = mutable;
    [self saveToPersistentStorage];
}

- (void)removeEntry:(Entry *)entry{
    NSMutableArray *mutable = [self.allEntries mutableCopy];
    [mutable removeObject:entry];
    self.allEntries = mutable;
    [self saveToPersistentStorage];
}

- (Entry *)createEntryWithTitle:(NSString *)title withBodyText:(NSString *)bodyText{
    Entry *entry = [Entry new];
    entry.title = title;
    entry.bodyText = bodyText;
    entry.timestamp = [NSDate date];
    
    [self addEntry:entry];
    return entry;
}

-(void)saveToPersistentStorage{
    
    NSMutableArray *mutable = [NSMutableArray new];
    
    for (Entry *entry in self.allEntries) {
        [mutable addObject:[entry dictionaryRepresentation]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:mutable forKey:allEntriesKey];
    
}

-(void)save{
    [self saveToPersistentStorage];
}

-(void)loadFromPersistentStorage{
    NSArray *entryDictionaries = [[NSUserDefaults standardUserDefaults] objectForKey:allEntriesKey];
    self.allEntries = entryDictionaries;
    
    NSMutableArray *mutable = [NSMutableArray new];
    for (NSDictionary *entry in entryDictionaries) {
        [mutable addObject:[[Entry alloc]initWithDictionary:entry]];
    }
    
    self.allEntries = mutable;
}



@end
