//
//  SSAccessoryInfo.h
//  SystemService
//
//  Created by Loc Nguyen on 7/11/16.
//  Copyright © 2016 Loc Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface SSAccessoryInfo : NSObject

+ (BOOL)accessoriesAttached;

+ (BOOL)headphoneAttached;

+ (NSInteger)numberAttachedAccessories;

+ (nullable NSString *)nameAttachedAccessories;

@end
