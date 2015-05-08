//
//  Entry.m
//  DayX
//
//  Created by Michael Sacks on 5/6/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "Entry.h"
#import "EntryController.h"

static NSString * const titleKey = @"title";
static NSString * const bodyTextKey = @"bodyText";
static NSString * const dateKey = @"date";


@implementation Entry

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.title = dict[titleKey];
        self.bodyText = dict[bodyTextKey];
        self.timestamp = [NSDate date];
    }
    return self;
}

-(NSDictionary *)dictionaryRepresentation{
    NSMutableDictionary *mutable = [NSMutableDictionary new];
    
    if (self.title) {
        mutable[titleKey] = self.title;
    }
    if (self.bodyText) {
        mutable[bodyTextKey] = self.bodyText;
    }
    if (self.timestamp) {
        mutable[dateKey] = self.timestamp;
    }
    return mutable;
}


@end
