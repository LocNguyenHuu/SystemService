//
//  SSApplicationInfo.h
//  SystemService
//
//  Created by Loc Nguyen on 7/11/16.
//  Copyright © 2016 Loc Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSApplicationInfo : NSObject

// Application Version
+ (nullable NSString *)applicationVersion;

// Clipboard Content
+ (nullable NSString *)clipboardContent;

// Application CPU Usage
+ (float)cpuUsage;

@end
