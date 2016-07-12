//
//  SSAccelerometerInfo.h
//  SystemService
//
//  Created by Loc Nguyen on 7/10/16.
//  Copyright © 2016 Loc Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface SSAccelerometerInfo : NSObject {
  CMMotionManager *motionManager;
  
  NSOperationQueue *deviceMotionQueue;
  NSOperationQueue *accelQueue;
  NSOperationQueue *gyroQueue;
}

+ (UIInterfaceOrientation)deviceOrientation;

// Attitude
@property (nonatomic, readonly, nullable) NSString *attitudeString;

// Gravity
@property (nonatomic, readonly, nullable) NSString *gravityString;

// Magnetic Field
@property (nonatomic, readonly, nullable) NSString *magneticFieldString;

// Rotation Rate
@property (nonatomic, readonly, nullable) NSString *rotationRateString;

// User Acceleration
@property (nonatomic, readonly, nullable) NSString *userAccelerationString;

// Raw
@property (nonatomic, readonly, nullable) NSString *rawGyroscopeString;

// Raw Accelerometer
@property (nonatomic, readonly, nullable) NSString *rawAccelerometerString;

- (void)startLoggingMotionData;

- (void)stopLoggingMotionData;
@end
