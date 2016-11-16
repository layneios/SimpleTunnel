//
//  Util.h
//  SimpleTunnel
//
//  Created by Layne on 16/11/16.
//  Copyright © 2016年 Layne. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <netinet6/in6.h>
//#import <CoreFoundation/CoreFoundation.h>
//#include <netinet6/in6.h>
//#include <netinet/in.h>

typedef NS_ENUM(NSUInteger, SimpleTunnelError) {
    SimpleTunnelBadConfiguration,
    SimpleTunnelBadConnection,
    SimpleTunnelInternalError,
};

@interface Util : NSObject

@end

@interface SavedData : NSObject

@property (nonatomic, assign) BOOL isEmpty;
@property (nonatomic, copy) NSArray<NSDictionary<NSString *, id> *> *chain;

@end

@interface SocketAddress6 : NSObject

@property (nonatomic, assign) struct sockaddr_in6 sin6;
@property (nonatomic, copy) NSString *stringValue;

@end

@interface SocketAddress : NSObject

@property (nonatomic, assign) struct sockaddr_in sin;
@property (nonatomic, copy) NSString *stringValue;

@end
