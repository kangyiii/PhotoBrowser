//
//  ImageCell.m
//  MJPhotoBrowser改进版
//
//  Created by 康义 on 2017/12/19.
//  Copyright © 2017年 康义. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageView.contentMode = 2;
}

@end
