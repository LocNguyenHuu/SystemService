//
//  SSCarrierInfo.h
//  SystemService
//
//  Created by Loc Nguyen on 7/12/16.
//  Copyright © 2016 Loc Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSCarrierInfo : NSObject

+ (nullable NSString *)carrierName;

+ (nullable NSString *)carrierCountry;

+ (nullable NSString *)carriedMobileCountryCode;

+ (nullable NSString *)carriedISOCountryCode;

+ (nullable NSString *)carriedMobileNetworkCode;

+ (BOOL)carrierAllowsVOIP;
@end
