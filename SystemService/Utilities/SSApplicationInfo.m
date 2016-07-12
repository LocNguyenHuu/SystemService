//
//  SSApplicationInfo.m
//  SystemService
//
//  Created by Loc Nguyen on 7/11/16.
//  Copyright © 2016 Loc Nguyen. All rights reserved.
//

#import "SSApplicationInfo.h"

#import <UIKit/UIKit.h>

#import <mach/mach.h>

@implementation SSApplicationInfo

+ (NSString *)applicationVersion {
  @try {
    
    // Query the plist for the version
    NSString *Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    if (Version == nil || Version.length <= 0) {
      
      return nil;
    }
    
    return Version;
  }
  @catch (NSException *exception) {
    
    return nil;
  }
}

+ (NSString *)clipboardContent {
  
  @try {
    
    UIPasteboard *PasteBoard = [UIPasteboard generalPasteboard];
    
    NSString *ClipboardContent = [PasteBoard string];
    
    if (ClipboardContent == nil || ClipboardContent.length <= 0) {
      
      return nil;
    }
    
    return ClipboardContent;
  } @catch (NSException *exception) {
    
    return nil;
  }
}

+ (float)cpuUsage {
  @try {
    
    kern_return_t kr;
    task_info_data_t tinfo;
    mach_msg_type_number_t task_info_count;
    
    task_info_count = TASK_INFO_MAX;
    kr = task_info(mach_task_self(), TASK_BASIC_INFO, (task_info_t)tinfo, &task_info_count);
    if (kr != KERN_SUCCESS) {
      return -1;
    }
    
    task_basic_info_t basic_info;
    thread_array_t thread_list;
    mach_msg_type_number_t thread_count;
    
    thread_info_data_t thinfo;
    mach_msg_type_number_t thread_info_count;
    
    thread_basic_info_t basic_info_th;
    uint32_t stat_thread = 0;
    
    basic_info = (task_basic_info_t)tinfo;
    
    // Get threads in the task
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if(kr != KERN_SUCCESS) {
      return -1;
    }
    if (thread_count > 0) {
      stat_thread += thread_count;
    }
    
    long tot_sec = 0;
    long tot_usec = 0;
    float tot_cpu = 0;
    int j;
    
    for (j = 0; j< thread_count; j++) {
      thread_info_count = THREAD_INFO_MAX;
      kr = thread_info(thread_list[j], THREAD_BASIC_INFO, (thread_info_t)thinfo, &thread_info_count);
      if (kr != KERN_SUCCESS) {
        return -1;
      }
      
      basic_info_th = (thread_basic_info_t)thinfo;
      
      if (!(basic_info_th->flags & TH_FLAGS_IDLE)) {
        tot_sec = tot_sec + basic_info_th->user_time.seconds + basic_info_th->system_time.seconds;
        tot_usec = tot_usec + basic_info_th->system_time.microseconds + basic_info_th->system_time.microseconds;
        tot_cpu = tot_cpu + basic_info_th->cpu_usage / (float)TH_USAGE_SCALE * 100.0;
      }
    }
    
    kr = vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    
    assert(kr == KERN_SUCCESS);
    
    return tot_cpu;
    
  } @catch (NSException *exception) {
    
    return -1;
  }
}
@end
