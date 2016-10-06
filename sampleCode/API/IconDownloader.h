/*
 I am using code written by Apple for icon downloader for setting images on chat screen
 Copyright (C) 2015 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 Helper object for managing the downloading of a particular app's icon.
  It uses NSURLSession/NSURLSessionDataTask to download the app's icon in the background if it does not
  yet exist and works in conjunction with the RootViewController to manage which apps need their icon.
 */
//  updated by Sonia Parikh 

#import <Foundation/Foundation.h>

@class CellData;

@interface IconDownloader : NSObject

@property (nonatomic, strong) CellData *appRecord;
@property (nonatomic, copy) void (^completionHandler)(void);

- (void)startDownload;
- (void)cancelDownload;

@end
