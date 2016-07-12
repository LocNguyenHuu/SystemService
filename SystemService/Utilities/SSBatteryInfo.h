//
//  SSBatteryInfo.h
//  SystemService
//
//  Created by Loc Nguyen on 7/12/16.
//  Copyright © 2016 Loc Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSBatteryInfo : NSObject

+ (float)batteryLevel;

+ (BOOL)charging;

+ (BOOL)fullyCharged;

@end
