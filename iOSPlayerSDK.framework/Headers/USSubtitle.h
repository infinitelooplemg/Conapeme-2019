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

NS_ASSUME_NONNULL_BEGIN

@interface USSubtitle : NSObject
@property(nonatomic, strong, readonly) NSString *languageTag;
@property(nonatomic, strong, readonly) NSString *displayName;
@end

@interface USMediaSelectionOption : NSObject
@property(nonatomic, strong, readonly) NSString *languageTag;
@property(nonatomic, strong, readonly) NSString *title;
@end

NS_ASSUME_NONNULL_END
