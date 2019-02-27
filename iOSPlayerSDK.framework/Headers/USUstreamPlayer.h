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
#import <UIKit/UIKit.h>
#import "USToolbar.h"
#import "USSubtitle.h"
#import "USMediaDescriptor.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const USUstreamPlayerErrorDomain;

/**
 Ad placement will be passed automatically in IMA ad request as a custom parameter under this key. (@"placement")
 */
extern NSString *const USUstreamPlayerAdPlacementKey;

/**
 Possible values associated to `USUstreamPlayerAdPlacementKey`:
 	USUstreamPlayerAdPlacementValuePreroll = @"preroll" - The ad requested will be used as a pre-roll ad.
 	USUstreamPlayerAdPlacementValueMidroll = @"midroll" - The ad requested will be used as a mid-roll ad.
 */
extern NSString *const USUstreamPlayerAdPlacementValuePreroll;
extern NSString *const USUstreamPlayerAdPlacementValueMidroll;

typedef NS_ENUM(NSUInteger, USPlayerErrorCode) {
	USPlayerErrorCode_Unknown,
	USPlayerErrorCode_LoadingFailed,			// could not load the media, mostly it is caused by network issues
	USPlayerErrorCode_PlaybackFailed,			// playing the content failed
	USPlayerErrorCode_Offline,					// the channel is offline
	USPlayerErrorCode_Unpalyable,				// there is no playable source fitting to the current platform
	USPlayerErrorCode_RemovedByOwner,			// the video was removed by the user
	USPlayerErrorCode_Inexistent,				// no such channel/video
	USPlayerErrorCode_Forbidden,				// the connection was forbidden by the Ustream server
	USPlayerErrorCode_ApiKey,					// wrong API key
	USPlayerErrorCode_AgeNotConfirmed,			 
	USPlayerErrorCode_AgeVerificationCancelled,
};

/**
 Player states reported by `USPlayerDelegate`.
 */
typedef NS_ENUM(NSUInteger, USPlayerState) {
	USPlayerStateStopped,
	USPlayerStateLoading,
	USPlayerStateWaiting,
	USPlayerStateReadyToPlay,
	USPlayerStatePlaying,
	USPlayerStatePaused,
	USPlayerStateFailed
};

/**
 Available player control styles.
 */
typedef NS_ENUM(NSUInteger, USPlayerControlStyle) {
	USPlayerControlStyleNone,		///< No control presented, it's the users responsibility to attach controls to the player.
	USPlayerControlStyleToolbar,	///< Ustream's default toolbar-based controls are presented. The user can reconfigure the controls using the `USToolbar` extension of the player.
	USPlayerControlStyleDefault,
};

@protocol USPlayerDelegate;

@interface USUstreamPlayer : NSObject

@property(nonatomic, weak) id<USPlayerDelegate> delegate;
@property(nonatomic, assign, readonly) USPlayerState playerState;
@property(nonatomic, weak) UIViewController *presentingViewController;

/// It's set and valid only if `playerState` is USPlayerStateFailed. In this case it indicates the reason of the fail.
@property(nonatomic, strong, readonly, nullable) NSError *error;

/// Timeout for loading, by default it is set to 10 seconds
@property(nonatomic, assign) NSTimeInterval loadingTimeout;

/// Player control style, defaults to `USPlayerControlStyleDefault`
@property(nonatomic, assign) USPlayerControlStyle playerControlStyle;

/// Indicates whether the player controls are visible.
@property(nonatomic, assign, readonly) BOOL controlsVisible;

/// Present player controls with a time interval after which it will be hidden.
- (void)showControls:(BOOL)show animated:(BOOL)animated timeout:(NSTimeInterval)timeInterval;

/// Present player controls with default hiding timeout.
- (void)showControls:(BOOL)show animated:(BOOL)animated;

/// A view containing the media and controls if `playerControlStyle` is not set to `USPlayerControlStyleNone`
@property(nonatomic, strong, readonly) UIView *view;

/// Configure `USUstreamPlayer` with your Ustream-provided apiKey before any play command.
+ (void)configureWithApiKey:(NSString *)apiKey;

@property(nonatomic, assign, readonly) BOOL pictureInPictureAvailable __TVOS_PROHIBITED;
@property(nonatomic, assign, readonly) BOOL pictureInPictureActive __TVOS_PROHIBITED;
- (void)startPictureInPicture __TVOS_PROHIBITED API_AVAILABLE(ios(9.0));
- (void)stopPictureInPicture __TVOS_PROHIBITED API_AVAILABLE(ios(9.0));

/// Array of available subtitles.
@property(nonatomic, strong, readonly, nullable) NSArray<USSubtitle *> *subtitles DEPRECATED_MSG_ATTRIBUTE("Use legibleMediaSelectionOptions instead.");

/// Default subtitle.
@property(nonatomic, strong, readonly, nullable) USSubtitle *defaultSubtitle DEPRECATED_MSG_ATTRIBUTE("Use defaultLegibleMediaSelectionOption instead.");

/// Select one of the items returned from `subtitles` to show it over the player. To hide the subtitles, pass in `nil`.
- (void)selectSubtitle:(nullable USSubtitle *)subtitle DEPRECATED_MSG_ATTRIBUTE("Use selectLegibleMediaSelectionOption instead.");

/// Selected subtitle.
@property(nonatomic, strong, readonly, nullable) USSubtitle *selectedSubtitle DEPRECATED_MSG_ATTRIBUTE("Use selectedLegibleMediaSelectionOption instead.");

/// Array of available legible media options.
@property(nonatomic, strong, readonly, nullable) NSArray<USMediaSelectionOption *> *legibleMediaSelectionOptions;

/// Default legible media option.
@property(nonatomic, strong, readonly, nullable) USMediaSelectionOption *defaultLegibleMediaSelectionOption;

/// Select one of the items returned from `legibleMediaSelectionOptions` to show it over the player. To hide the currently selected item, pass in `nil`.
- (void)selectLegibleMediaSelectionOption:(nullable USMediaSelectionOption *)legibleMediaSelectionOption;

/// Selected legible media option.
@property(nonatomic, strong, readonly, nullable) USMediaSelectionOption *selectedLegibleMediaSelectionOption;

/// Array of available audible media options.
@property(nonatomic, strong, readonly, nullable) NSArray<USMediaSelectionOption *> *audibleMediaSelectionOptions;

/// Default audible media option.
@property(nonatomic, strong, readonly, nullable) USMediaSelectionOption *defaultAudibleMediaSelectionOption;

/// Select one of the items returned from `audibleMediaSelectionOptions`.
- (void)selectAudibleMediaSelectionOption:(nullable USMediaSelectionOption *)audibleMediaSelectionOption;

/// Selected audible media option.
@property(nonatomic, strong, readonly, nullable) USMediaSelectionOption *selectedAudibleMediaSelectionOption;

/** 
 Suspends the player, it will continue the playback upon `resume` if possible.
 Should be called if your app is suspanded, and may be called when the player is covered by an other view controller.
*/
- (void)suspend;

/**
 Resumes the playback from the state it was befor `suspend` was called. Should be called upon your application resumes.
 */
- (void)resume;

@property(nonatomic, readonly) BOOL isPlayingLiveStream DEPRECATED_MSG_ATTRIBUTE("Use mediaDescriptor.isChannel instead.");
@property(nonatomic, readonly) BOOL isLive;
@property(nonatomic, readonly) NSTimeInterval duration;
@property(nonatomic, readonly) NSTimeInterval playbackTime;
@property(nonatomic, readonly) NSInteger viewerCount;
@property(nonatomic, readonly, nullable) NSDate *broadcastStartDate;
@property(nonatomic, readwrite) BOOL muted;
@property(nonatomic, copy, readonly, nullable) NSString *contentId;
@property(nonatomic, copy, readonly, nullable) NSString *contentTitle;

/// If set this player won't pause the video when the app goes to background mode. Note: Audio background mode capability has to be enabled for the host app. Also providing media controls and Now Playing Info for the Lock Screen widget is a host app responsibility.
@property(nonatomic, readwrite) BOOL continuePlaybackInBackground;

- (void)play;
- (void)pause;
- (void)seekTo:(NSTimeInterval)time;

@property(nonatomic, strong, readonly, nullable) USMediaDescriptor *mediaDescriptor;
- (void)playMedia:(USMediaDescriptor *)mediaDescriptor;

/// Start playing live stream from a Ustream channel
- (void)playChannel:(NSString *)channelId DEPRECATED_MSG_ATTRIBUTE("Use playMedia: instead.");

/// Start playing a Ustream recorded content.
- (void)playRecorded:(NSString *)recordedId DEPRECATED_MSG_ATTRIBUTE("Use playMedia: instead.");

/// Continue the playback after a password lock was signaled on `USPlayerDelegate`.
- (void)continueWithPassword:(NSString *)password;

/// Continue the playback after an age lock was signaled on `USPlayerDelegate`.
- (void)continueWithAgeConfirmed DEPRECATED_MSG_ATTRIBUTE("This type of age confirmation is deprecated.");

/// Continue the playback after a birthdate lock was signaled on `USPlayerDelegate`.
- (void)continueWithBirthdate:(NSDate *)birthdate;

/// Continue the playback after a viewer authentication hash lock was signaled on `USPlayerDelegate`.
- (void)continueWithHash:(NSString *)hash;

/// Disable ad playing. Setting it to `YES` will block starting a new ad but does not remove a running ad.
@property(nonatomic, readwrite) BOOL adsDisabled;

/// Indicates if the player is just playing an ad.
@property(nonatomic, assign, readonly) BOOL playingAd;

/**
 Configures the ad service.
 @param googleIMATag - A tag URL generated on the DFP dashboard https://www.google.com/dfp under Inventory/units.
 @param customMetadata - User-defined key-value pairs allowing flexible targeting. May be `nil`.
 @param minAdFreeTimeInterval - Ad will be played periodically with `minAdFreeTimeInterval` seconds between subsequent ads.
 @param allowPreroll - If set to `YES` the playback will start with a preroll ad.
 */
- (void)configureAdServiceWithGoogleIMATag:(NSString *)googleIMATag customMetadata:(nullable NSDictionary<NSString *, NSString *> *)customMetadata minAdFreeTimeInterval:(NSTimeInterval)minAdFreeTimeInterval allowPreroll:(BOOL)allowPreroll;

/**
 Configures the ad service.
 @param googleIMATag - A tag URL generated on the DFP dashboard https://www.google.com/dfp under Inventory/units
 @param customMetadata - User-defined key-value pairs allowing flexible targeting. May be `nil`.
 @param cuePoints - The exact position of the ad breaks in seconds. It is based on mediaTime for recorded content and on the amount of watched content in case of live stream.
 @param allowPreroll - If set to `YES` the playback will start with a preroll ad.
 */
- (void)configureAdServiceWithGoogleIMATag:(NSString *)googleIMATag customMetadata:(nullable NSDictionary<NSString *, NSString *> *)customMetadata cuePoints:(nullable NSArray<NSNumber *> *)cuePoints allowPreroll:(BOOL)allowPreroll;

@end

@interface USUstreamPlayer (USToolbar)

- (USToolbar *)topToolbar;
- (USToolbar *)bottomToolbar;

/// A play/pause button.
- (USToolbarItem *)playButtonItem;

/// A slider reflecting the playback time of a recorded content.
- (USToolbarItem *)sliderItem;

/// A label presnting the current playback time.
- (USToolbarItem *)timeLabelItem;

/// A label presenting the playing content duration.
- (USToolbarItem *)durationLabelItem;

/// A label presenting both playback time and duration in a form of playbackTime/duration.
- (USToolbarItem *)timePerDurationLabelItem;

/// A label presenting the number of online viewers in the case of a live stream.
- (USToolbarItem *)viewerCountLabelItem;

/// A label presenting the time ellapsed since the stream is live,
- (USToolbarItem *)startedDateLabelItem;

/// A label presenting the current content's title (channel or video title)
- (USToolbarItem *)titleLabelItem;

/// A button presenting the airplay icon whenever an external player is available.
- (USToolbarItem *)airplayButtonItem;

/// A button activating/deactivating the picture in picture mode whenever it is available
- (USToolbarItem *)pictureInPictureButtonItem __TVOS_PROHIBITED;

/// A button presenting an action sheet with the available subtitles if any.
- (USToolbarItem *)subtitlesButtonItem;

/// A button presenting an action sheet with the available audio tracks if there are multiple options.
- (USToolbarItem *)audioTracksButtonItem;

/// A static image wrapped into a toolbar item designated to be presented on live content.
- (USToolbarItem *)liveBadgeItem;

@end

/**
	A delegate used to report an `USUstreamPlayer`'s state changes and locks.
 */
@protocol USPlayerDelegate <NSObject>
@optional

- (void)playerStateDidChange:(USUstreamPlayer *)player;

/**
	Password lock happened, one should ask the user for the password and then call `USUstreamPlayer`'s `continueWithPassword:`
	in order to check the password and continue playing the content.
 */
- (void)playerRequiresPassword:(USUstreamPlayer *)player;

/**
	The content is age restricted, the user should confirm that he/she is older than `age` provided as parameter.
	If the user confirms it the playback could be continued by calling `USUstreamPlayer`'s `continueWithAgeConfirmed`
 */
- (void)playerRequiresAgeConfirmation:(USUstreamPlayer *)player ageRequired:(NSUInteger)age DEPRECATED_MSG_ATTRIBUTE("This type of age confirmation is deprecated.");

/**
	The content is age restricted. The user should provide his/her birthdate in order to confirm he/she is old enough
	to watch it.
	The playback can be continued with `USUstreamPlayer`'s `continueWithBirthdate`.
 */
- (void)playerRequiresBirthdate:(USUstreamPlayer *)player;

/**
	The content requires viewer authentication. The user should authenticate against your server that generates a valid hash according to the Viewer Authentication API: http://developers.ustream.tv/channel-api/viewer-authentication-api.html
	The playback can be continued with `USUstreamPlayer`'s `continueWithHash`.
 */
- (void)playerRequiresHash:(USUstreamPlayer *)player;

/**
	Broadcast start date property has changed its value. This will be called only in case of live broadcasts.
 */
- (void)playerBroadcastStartDateDidChange:(USUstreamPlayer *)player;

/**
	 The player will present the controls.
 */
- (void)player:(USUstreamPlayer *)player willPresentControlsAnimated:(BOOL)animated animationDuration:(NSTimeInterval)animationDuration;

/**
	 The player will hide the controls.
 */
- (void)player:(USUstreamPlayer *)player willHideControlsAnimated:(BOOL)animated animationDuration:(NSTimeInterval)animationDuration;

/**
	 The player wants to present a view controller, e.g. an action sheet listing the available subtitle options when the subtitles toolbar item gets tapped.
	 Return YES if request handled. If not implemented or returns NO, then viewController will be presented on `presentingViewController`.
 */
- (BOOL)player:(USUstreamPlayer *)player requestsPresentingViewController:(UIViewController *)viewController;

/**
	 If `player`'s `isLive` property is changed this delegate method is called. Useful for indicating that the player is playing a channel with live content in it.
 */
- (void)playerLiveStateDidChange:(USUstreamPlayer *)player;

/**
 	Called when the player is trying to load an ad.
 	User may change the custom parameters by constructing and returning a dictionary with the new values.
 	If `nil` is returned then no custom parameters will be passed in the ad request.
 */
- (NSDictionary *)player:(USUstreamPlayer *)player willLoadAdWithCustomParameters:(nullable NSDictionary<NSString *, NSString *> *)customParameters;

/**
 	Called when player is starting an ad playback.
 */
- (void)playerStartingAd:(USUstreamPlayer *)player;

/**
 	Called when an ad playback is finished.
 */
- (void)playerDidFinishPlayingAd:(USUstreamPlayer *)player;

/**
 	Called when player is failing to load or play an ad.
 	The passes `error` object is mapped from an `IMAAdError` object, see `IMAErrorCode` for the possible error codes.
 */
- (void)player:(USUstreamPlayer *)player receivedAdError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
