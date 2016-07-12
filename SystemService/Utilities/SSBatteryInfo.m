//
//  SSBatteryInfo.m
//  SystemService
//
//  Created by Loc Nguyen on 7/12/16.
//  Copyright © 2016 Loc Nguyen. All rights reserved.
//

#import "SSBatteryInfo.h"
#import <UIKit/UIKit.h>

@implementation SSBatteryInfo

+ (float)batteryLevel {
  
  @try {
    
    UIDevice *Device = [UIDevice currentDevice];
    
    Device.batteryMonitoringEnabled = YES;
    
    float BatteryLevel = 0.0;
    
    float BatteryCharge = [Device batteryLevel];
    
    if (BatteryCharge > 0.0f) {
      
      BatteryLevel = BatteryCharge * 100;
    } else {
      
      return -1;
    }
    
    return BatteryLevel;
    
  } @catch (NSException *exception) {
    return -1;
  }
}

+ (BOOL)charging {
  
  @try {
    
    UIDevice *Device = [UIDevice currentDevice];
    
    Device.batteryMonitoringEnabled = YES;
    
    if ([Device batteryState] == UIDeviceBatteryStateCharging || [Device batteryState] == UIDeviceBatteryStateFull) {
      
      return true;
    } else {
      
      return false;
    }
  } @catch (NSException *exception) {
    
    return false;
  }
}

+ (BOOL)fullyCharged {
  
  @try {
    
    UIDevice *Device = [UIDevice currentDevice];
    
    Device.batteryMonitoringEnabled = YES;
    
    if ([Device batteryState] == UIDeviceBatteryStateFull) {
      
      return true;
    } else {
      
      return false;
    }
  } @catch (NSException *exception) {
    
    return false;
  }
}
@end
