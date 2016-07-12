//
//  SSCarrierInfo.m
//  SystemService
//
//  Created by Loc Nguyen on 7/12/16.
//  Copyright © 2016 Loc Nguyen. All rights reserved.
//

#import "SSCarrierInfo.h"

#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@implementation SSCarrierInfo

+ (NSString *)carrierName {
  
  @try {
    
    CTTelephonyNetworkInfo *TelephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *Carrier = [TelephonyInfo subscriberCellularProvider];
    
    NSString *CarrieName = [Carrier carrierName];
    
    if (CarrieName == nil || CarrieName.length <= 0) {
      
      return nil;
    }
    
    return CarrieName;
  } @catch (NSException *exception) {
    
    return nil;
  }
}

+ (NSString *)carrierCountry {
  
  // Get the carrier mobile country code
  @try {
    // Get the Telephony Network Info
    CTTelephonyNetworkInfo *TelephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    // Get the carrier
    CTCarrier *Carrier = [TelephonyInfo subscriberCellularProvider];
    // Get the carrier mobile country code
    NSString *CarrierCode = [Carrier mobileCountryCode];
    
    // Check to make sure it's valid
    if (CarrierCode == nil || CarrierCode.length <= 0) {
      // Return unknown
      return nil;
    }
    
    // Return the name
    return CarrierCode;
  }
  @catch (NSException *exception) {
    // Error finding the name
    return nil;
  }
}

+ (NSString *)carriedMobileCountryCode {
  
  @try {
    
    CTTelephonyNetworkInfo *TelephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *Carrier = [TelephonyInfo subscriberCellularProvider];
    
    NSString *CarrierCode = [Carrier mobileCountryCode];
    
    if (CarrierCode == nil || CarrierCode.length <= 0) {
      
      return nil;
    }
    
    return CarrierCode;
    
  } @catch (NSException *exception) {
    
    return nil;
  }
}

+ (NSString *)carriedMobileNetworkCode {
  
  @try {
    
    CTTelephonyNetworkInfo *TelephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *Carrier = [TelephonyInfo subscriberCellularProvider];
    
    NSString *CarrierCode = [Carrier mobileNetworkCode];
    
    if (CarrierCode == nil || CarrierCode.length <= 0) {
      
      return nil;
    }
    
    return CarrierCode;
  } @catch (NSException *exception) {
    
    return nil;
  }
}

+ (BOOL)carrierAllowsVOIP {
  
  @try {
    
    CTTelephonyNetworkInfo *TelephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *Carier = [TelephonyInfo subscriberCellularProvider];
    
    BOOL CarrierVOIP = [Carier allowsVOIP];
    
    return CarrierVOIP;
  } @catch (NSException *exception) {
    
    return false;
  }
}
@end
