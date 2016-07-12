//
//  SSAccelerometerInfo.m
//  SystemService
//
//  Created by Loc Nguyen on 7/10/16.
//  Copyright © 2016 Loc Nguyen. All rights reserved.
//

#import "SSAccelerometerInfo.h"
// Private
@interface SSAccelerometerInfo ()

- (void)processMotion:(CMDeviceMotion *)motion withError:(NSError *)error;

- (void)processAccel:(CMAccelerometerData*)accelData withError:(NSError*)error;

- (void)processGyro:(CMGyroData*)gyroData withError:(NSError*)error;

@end
// Implementation
@implementation SSAccelerometerInfo

@synthesize attitudeString, gravityString, magneticFieldString, rotationRateString, userAccelerationString, rawGyroscopeString, rawAccelerometerString;
// Device Orientation
+ (UIInterfaceOrientation)deviceOrientation {
  @try {
    // Device orientation
    UIInterfaceOrientation Orientation = [[UIApplication sharedApplication] statusBarOrientation];
    // Successful
    return Orientation;
  
  } @catch (NSException *exception) {
    // Error
    return -1;
  }
}

- (void)startLoggingMotionData {
  motionManager = [[CMMotionManager alloc] init];
  motionManager.deviceMotionUpdateInterval = 0.01;
  motionManager.accelerometerUpdateInterval = 0.01;
  motionManager.gyroUpdateInterval = 0.01;
  
  deviceMotionQueue = [[NSOperationQueue alloc] init];
  [deviceMotionQueue setMaxConcurrentOperationCount:1];
  
  accelQueue = [[NSOperationQueue alloc] init];
  [accelQueue setMaxConcurrentOperationCount:1];
  
  gyroQueue = [[NSOperationQueue alloc] init];
  [gyroQueue setMaxConcurrentOperationCount:1];
  
  CMDeviceMotionHandler motionHandler = ^(CMDeviceMotion *motion, NSError *error) {
    [self processMotion:motion withError:error];
  };
  
  CMGyroHandler gyroHandler = ^(CMGyroData *gyroData, NSError *error) {
    [self processGyro:gyroData withError:error];
  };
  
  CMAccelerometerHandler accelHandler = ^(CMAccelerometerData *accellerometerData, NSError *error) {
    [self processAccel:accellerometerData withError:error];
  };
  
  [motionManager startDeviceMotionUpdatesToQueue:deviceMotionQueue withHandler:motionHandler];
  
  [motionManager startGyroUpdatesToQueue:gyroQueue withHandler:gyroHandler];
  
  [motionManager startAccelerometerUpdatesToQueue:accelQueue withHandler:accelHandler];
}

- (void)stopLoggingMotionData {
  
  [motionManager stopDeviceMotionUpdates];
  [deviceMotionQueue waitUntilAllOperationsAreFinished];
  
  [motionManager stopAccelerometerUpdates];
  [accelQueue waitUntilAllOperationsAreFinished];
  
  [motionManager stopGyroUpdates];
  [gyroQueue waitUntilAllOperationsAreFinished];
}

- (void)processAccel:(CMAccelerometerData *)accelData withError:(NSError *)error {
  rawAccelerometerString = [NSString stringWithFormat:@"%f, %f, %f, %f\n", accelData.timestamp,
                              accelData.acceleration.x,
                              accelData.acceleration.y,
                              accelData.acceleration.z,
                              nil];
}

- (void)processGyro:(CMGyroData *)gyroData withError:(NSError *)error {
  
  rawGyroscopeString = [NSString stringWithFormat:@"%f, %f, %f, %f\n", gyroData.timestamp,
                            gyroData.rotationRate.x,
                            gyroData.rotationRate.y,
                            gyroData.rotationRate.z,
                            nil];
}

- (void)processMotion:(CMDeviceMotion *)motion withError:(NSError *)error {
  attitudeString = [NSString stringWithFormat:@"%f, %f, %f, %f\n", motion.timestamp,
                            motion.gravity.x,
                            motion.gravity.y,
                            motion.gravity.z,
                            nil];
  
  gravityString = [NSString stringWithFormat:@"%f, %f, %f, %f\n", motion.timestamp,
                            motion.gravity.x,
                            motion.gravity.y,
                            motion.gravity.z,
                   
                            nil];
  
  rotationRateString = [NSString stringWithFormat:@"%f, %f, %f, %f\n", motion.timestamp,
                            motion.rotationRate.x,
                            motion.rotationRate.y,
                            motion.rotationRate.z,
                            nil];
  
  magneticFieldString = [NSString stringWithFormat:@"%f, %f, %f, %f, %d\n", motion.timestamp,
                            motion.magneticField.field.x,
                            motion.magneticField.field.y,
                            motion.magneticField.field.z,
                            (int)motion.magneticField.accuracy,
                            nil];
  
  userAccelerationString = [NSString stringWithFormat:@"%f, %f, %f, %f\n", motion.timestamp,
                            motion.userAcceleration.x,
                            motion.userAcceleration.y,
                            motion.userAcceleration.z,
                            nil];
}

@end
