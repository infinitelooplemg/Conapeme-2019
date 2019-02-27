//
// © Copyright IBM Corp. 2018
//
// All Rights Reserved.
//
// This software is the confidential and proprietary information
// of the IBM Corporation. (‘Confidential Information’). Redistribution
// of the source code or binary form is not permitted without prior authorization
// from the IBM Corporation.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface USMediaDescriptor : NSObject<NSCopying>

@property(nonatomic, copy, readonly) NSString *mediaID;
@property(nonatomic, assign, readonly) BOOL isLive DEPRECATED_MSG_ATTRIBUTE("Use isChannel instead.");
@property(nonatomic, assign, readonly) BOOL isChannel;

@property(nullable, nonatomic, copy) NSString *password; // Set password when trying to play a password-protected content and password is known prior loading.
@property(nullable, nonatomic, copy) NSString *hashCode; // Set hash when trying to play a protected content and the hash is known prior loading.

+ (instancetype)recordedDescriptorWithID:(NSString * )recordedID;
+ (instancetype)liveDescriptorWithID:(NSString *)channelID DEPRECATED_MSG_ATTRIBUTE("Use channelDescriptorWithID: instead.");
+ (instancetype)channelDescriptorWithID:(NSString *)channelID;

NS_ASSUME_NONNULL_END

@end
