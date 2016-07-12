//
//  SSAccessoryInfo.m
//  SystemService
//
//  Created by Loc Nguyen on 7/11/16.
//  Copyright © 2016 Loc Nguyen. All rights reserved.
//

#import "SSAccessoryInfo.h"

#import <ExternalAccessory/ExternalAccessory.h>

#import <AVFoundation/AVFoundation.h>

@implementation SSAccessoryInfo

+ (BOOL)accessoriesAttached {
  @try {
    EAAccessoryManager *AccessoryManager = [EAAccessoryManager sharedAccessoryManager];
    
    int NumberOfAccessoriesConnected = (int)[AccessoryManager.connectedAccessories count];
    
    if (NumberOfAccessoriesConnected > 0) {
      
      return true;
    } else {
    
      return false;
    }
  } @catch (NSException *exception) {
   
    return false;
  }
}

+ (BOOL)headphoneAttached {
  
  @try {
    
    AVAudioSessionRouteDescription *route = [[AVAudioSession sharedInstance] currentRoute];
    
    for (AVAudioSessionPortDescription *desc in [route outputs]) {
      
      if ([[desc portType] isEqualToString:AVAudioSessionPortHeadphones]) {
        
        return YES;
      }
      
      return NO;
    }
  } @catch (NSException *exception) {
    return false;
  }
}

+ (NSInteger)numberAttachedAccessories {
  
  @try {
    
    EAAccessoryManager *AccessoryManager = [EAAccessoryManager sharedAccessoryManager];
    
    int NumberOfAccessoriesConnected = (int)[AccessoryManager.connectedAccessories count];
    
    return NumberOfAccessoriesConnected;
  } @catch (NSException *exception) {
   
    return false;
  }
}

+ (NSString *)nameAttachedAccessories {
  
  @try {
    
    EAAccessoryManager *AccessoryManager = [EAAccessoryManager sharedAccessoryManager];
    
    EAAccessory *Accessory;
    
    int NumberOfAccessoriesConnected = (int)[AccessoryManager.connectedAccessories count];
    
    if (NumberOfAccessoriesConnected > 0) {
      
      NSString *AllAccessoryNames = @"";
      
      NSString *AccessoryName;
      
      NSArray *AccessoryArray = AccessoryManager.connectedAccessories;
      
      for (int x = 0; x < NumberOfAccessoriesConnected; x++) {
        
        Accessory = [AccessoryArray objectAtIndex:x];
        
        AccessoryName = [Accessory name];
        
        if (AccessoryName == nil || AccessoryName.length == 0) {
          
          AccessoryName = [Accessory manufacturer];
          
        }
        
        if (AccessoryName == nil || AccessoryName.length == 0) {
          AccessoryName = @"Unknow";
        }
        
        AllAccessoryNames = [AllAccessoryNames stringByAppendingFormat:@"%@", AccessoryName];
        
        if (x < NumberOfAccessoriesConnected - 1) {
          
          AllAccessoryNames = [AllAccessoryNames stringByAppendingString:@", "];
        }
      }
      
      return AllAccessoryNames;
    }
  } @catch (NSException *exception) {
    
    return nil;
  }
  
}
@end
