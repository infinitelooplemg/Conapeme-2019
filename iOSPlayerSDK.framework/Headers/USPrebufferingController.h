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
#import "USUstreamPlayer.h"
#import "USMediaDescriptor.h"

NS_ASSUME_NONNULL_BEGIN

@protocol USPrebufferingDelegate;

/**
	This class is responsible to coordinate a set of USUstreamPlayers by initiating prebuffering for faster playback start.
 */
@interface USPrebufferingController : NSObject

@property(nullable, nonatomic, weak) id<USPrebufferingDelegate> delegate;

@property(nonatomic, assign) USPlayerControlStyle playerControlStyle; // USPlayerControlStyleNone by default


/**
	Accepts an array of media descriptors in priority order.

	The first ones will be prepared by fetching the needed information from Ustream servers then prebuffered for a fast playback start.
	A larger set will be prepared by fetching the needed information from Ustream servers but no buffering initiated yet.
	The size of this two sets is not specified and may change in future releases but neither of them will be smaller than 3.
	
 */
- (void)enqueueForPlaybackPreparation:(NSArray<USMediaDescriptor *> *)mediaArray;

/**
	All preparations and buffering will be cancelled.
 */
- (void)cancelPlaybackPreparations;

/**
	Returns a `USUstreamPlayer` for this media descriptor.
 
	If the media was enqueued for playback preparation earlier then a ready-to-play player is returned if possible.
	A cold player will be returned otherwise.
 */
- (USUstreamPlayer *)playerForMedia:(USMediaDescriptor *)media;

/**
 Continues prebuffering if the content is password protected.
 */
- (void)continueWithPassword:(NSString *)password forMedia:(USMediaDescriptor *)media;

/**
 Continues prebuffering if the content is age restricted and playback is allowed based on the passed birthdate.
 If the viewer is too young loading will be cancelled and error reported on `prebufferingController:reportsLoadingError:forMedia:`.
 */
- (void)continueWithBirthdate:(NSDate *)birthdate forMedia:(USMediaDescriptor *)media;

/**
 Continues prebuffering for a protected content. If the passed hash is invalid loading will be cancelled and error reported on `prebufferingController:reportsLoadingError:forMedia:`.
 */
 - (void)continueWithHash:(NSString *)hash forMedia:(USMediaDescriptor *)media;

@end

@protocol USPrebufferingDelegate <NSObject>
@optional

/**
 Loading error happened during the prebuffering.
 */
- (BOOL)prebufferingController:(USPrebufferingController *)prebufferingController reportsLoadingError:(NSError *)error forMedia:(USMediaDescriptor *)media;

/**
 Password lock happened, one should ask the user for the password and then call `USPrebufferingController`'s `continueWithPassword:forMedia:`
 in order to check the password and continue buffering the content.
 */
- (void)prebufferingController:(USPrebufferingController *)prebufferingController requiresPasswordForMedia:(USMediaDescriptor *)media;

/**
 The content is age restricted. The user should provide his/her birthdate in order to confirm he/she is old enough to watch it.
 The buffering can be continued with `USPrebufferingController`'s `continueWithBirthdate:forMedia:`.
 */
- (void)prebufferingController:(USPrebufferingController *)prebufferingController requiresBirthdateForMedia:(USMediaDescriptor *)media;

/**
 The content requires viewer authentication. The user should authenticate against your server that generates a valid hash according to the Viewer Authentication API: https://developers.video.ibm.com/channel-api/getting-started.html
 The buffering can be continued with `USPrebufferingController`'s `continueWithHash:forMedia:`.
 */
- (void)prebufferingController:(USPrebufferingController *)prebufferingController requiresHashForMedia:(USMediaDescriptor *)media;

@end

NS_ASSUME_NONNULL_END
