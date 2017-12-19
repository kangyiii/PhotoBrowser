//
//  MJPhotoLoadingView.m
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MJPhotoLoadingView.h"
#import "MJPhotoBrowser.h"
#import <QuartzCore/QuartzCore.h>
#import "MJPhotoProgressView.h"

@interface MJPhotoLoadingView ()
{
    MJPhotoProgressView *_progressView;
}

@end

@implementation MJPhotoLoadingView

- (void)setFrame:(CGRect)frame
{
    [super setFrame:[UIScreen mainScreen].bounds];
}

- (void)showFailure
{
    [_progressView removeFromSuperview];
    
    if (self.failureLabel == nil) {
        self.failureLabel = [[UILabel alloc] init];
        self.failureLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, 44);
        self.failureLabel.textAlignment = NSTextAlignmentCenter;
        self.failureLabel.center = self.center;
        self.failureLabel.text = @"网络不给力，图片下载失败";
        self.failureLabel.font = [UIFont boldSystemFontOfSize:20];
        self.failureLabel.textColor = [UIColor whiteColor];
        self.failureLabel.backgroundColor = [UIColor clearColor];
        self.failureLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    }
    [self addSubview:self.failureLabel];
}

- (void)showLoading
{
    [self.failureLabel removeFromSuperview];
    
    if (_progressView == nil) {
        _progressView = [[MJPhotoProgressView alloc] init];
        _progressView.bounds = CGRectMake( 0, 0, 60, 60);
        _progressView.center = self.center;
    }
    _progressView.progress = kMinProgress;
    [self addSubview:_progressView];
}

#pragma mark - customlize method
- (void)setProgress:(float)progress
{
    _progress = progress;
    _progressView.progress = progress;
    if (progress >= 1.0) {
        [_progressView removeFromSuperview];
    }
}
@end
