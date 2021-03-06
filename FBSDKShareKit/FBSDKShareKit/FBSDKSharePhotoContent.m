// Copyright (c) 2014-present, Facebook, Inc. All rights reserved.
//
// You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
// copy, modify, and distribute this software in source code or binary form for use
// in connection with the web services and APIs provided by Facebook.
//
// As with any software that integrates with the Facebook platform, your use of
// this software is subject to the Facebook Developer Principles and Policies
// [http://developers.facebook.com/policy/]. This copyright notice shall be
// included in all copies or substantial portions of the software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "FBSDKSharePhotoContent.h"

#import "FBSDKCoreKit+Internal.h"
#import "FBSDKSharePhoto.h"
#import "FBSDKShareUtility.h"

#define FBSDK_SHARE_PHOTO_CONTENT_CONTENT_URL_KEY @"contentURL"
#define FBSDK_SHARE_PHOTO_CONTENT_PEOPLE_IDS_KEY @"peopleIDs"
#define FBSDK_SHARE_PHOTO_CONTENT_PHOTOS_KEY @"photos"
#define FBSDK_SHARE_PHOTO_CONTENT_PLACE_ID_KEY @"placeID"
#define FBSDK_SHARE_PHOTO_CONTENT_REF_KEY @"ref"

@implementation FBSDKSharePhotoContent

#pragma mark - Properties

@synthesize contentURL = _contentURL;
@synthesize peopleIDs = _peopleIDs;
@synthesize placeID = _placeID;
@synthesize ref = _ref;

- (void)setPeopleIDs:(NSArray *)peopleIDs
{
  [FBSDKShareUtility assertCollection:peopleIDs ofClass:[NSString class] name:@"peopleIDs"];
  if (![FBSDKInternalUtility object:_peopleIDs isEqualToObject:peopleIDs]) {
    _peopleIDs = [peopleIDs copy];
  }
}

- (void)setPhotos:(NSArray *)photos
{
  [FBSDKShareUtility assertCollection:photos ofClass:[FBSDKSharePhoto class] name:@"photos"];
  if (![FBSDKInternalUtility object:_photos isEqualToObject:photos]) {
    _photos = [photos copy];
  }
}

#pragma mark - Equality

- (NSUInteger)hash
{
  NSUInteger subhashes[] = {
    [_contentURL hash],
    [_peopleIDs hash],
    [_photos hash],
    [_placeID hash],
    [_ref hash],
  };
  return [FBSDKMath hashWithIntegerArray:subhashes count:sizeof(subhashes) / sizeof(subhashes[0])];
}

- (BOOL)isEqual:(id)object
{
  if (self == object) {
    return YES;
  }
  if (![object isKindOfClass:[FBSDKSharePhotoContent class]]) {
    return NO;
  }
  return [self isEqualToSharePhotoContent:(FBSDKSharePhotoContent *)object];
}

- (BOOL)isEqualToSharePhotoContent:(FBSDKSharePhotoContent *)content
{
  return (content &&
          [FBSDKInternalUtility object:_contentURL isEqualToObject:content.contentURL] &&
          [FBSDKInternalUtility object:_peopleIDs isEqualToObject:content.peopleIDs] &&
          [FBSDKInternalUtility object:_photos isEqualToObject:content.photos] &&
          [FBSDKInternalUtility object:_placeID isEqualToObject:content.placeID] &&
          [FBSDKInternalUtility object:_ref isEqualToObject:content.ref]);
}

#pragma mark - NSCoding

+ (BOOL)supportsSecureCoding
{
  return YES;
}

- (id)initWithCoder:(NSCoder *)decoder
{
  if ((self = [self init])) {
    _contentURL = [decoder decodeObjectOfClass:[NSURL class] forKey:FBSDK_SHARE_PHOTO_CONTENT_CONTENT_URL_KEY];
    _peopleIDs = [decoder decodeObjectOfClass:[NSArray class] forKey:FBSDK_SHARE_PHOTO_CONTENT_PEOPLE_IDS_KEY];
    NSSet *classes = [NSSet setWithObjects:[NSArray class], [FBSDKSharePhoto class], nil];
    _photos = [decoder decodeObjectOfClasses:classes forKey:FBSDK_SHARE_PHOTO_CONTENT_PHOTOS_KEY];
    _placeID = [decoder decodeObjectOfClass:[NSString class] forKey:FBSDK_SHARE_PHOTO_CONTENT_PLACE_ID_KEY];
    _ref = [decoder decodeObjectOfClass:[NSString class] forKey:FBSDK_SHARE_PHOTO_CONTENT_REF_KEY];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
  [encoder encodeObject:_contentURL forKey:FBSDK_SHARE_PHOTO_CONTENT_CONTENT_URL_KEY];
  [encoder encodeObject:_peopleIDs forKey:FBSDK_SHARE_PHOTO_CONTENT_PEOPLE_IDS_KEY];
  [encoder encodeObject:_photos forKey:FBSDK_SHARE_PHOTO_CONTENT_PHOTOS_KEY];
  [encoder encodeObject:_placeID forKey:FBSDK_SHARE_PHOTO_CONTENT_PLACE_ID_KEY];
  [encoder encodeObject:_ref forKey:FBSDK_SHARE_PHOTO_CONTENT_REF_KEY];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
  FBSDKSharePhotoContent *copy = [[FBSDKSharePhotoContent alloc] init];
  copy->_contentURL = [_contentURL copy];
  copy->_peopleIDs = [_peopleIDs copy];
  copy->_photos = [_photos copy];
  copy->_placeID = [_placeID copy];
  copy->_ref = [_ref copy];
  return copy;
}

@end
