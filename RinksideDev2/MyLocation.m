//
//  MyLocation.m
//  RinksideDev2
//
//  Created by Dave Fearon on 11-11-02.
//  Copyright (c) 2011 In-touch Survey Inc. All rights reserved.
//

#import "MyLocation.h"

@implementation MyLocation
@synthesize name = _name;
@synthesize address = _address;
@synthesize coordinate = _coordinate;

- (id)initWithName:(NSString *)name address:(NSString *)address coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        _name = [name copy];
        _address = [address copy];
        _coordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    return _name;
}

- (NSString *)subtitle {
    return _address;
}

- (void)dealloc {
    //[_name release];
    _name = nil;
    //[_address release];
    _address = nil;
    //[super dealloc];
}

@end
