//
//  LZImgCell.m
//  无限分页
//
//  Created by lzing on 16/1/10.
//  Copyright © 2016年 lzing. All rights reserved.
//

#import "LZCycleCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@interface LZCycleCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LZCycleCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupCell];
    }
    return self;
}

- (void)setupCell {
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)setImagePath:(NSString *)imagePath {
    _imagePath = imagePath;
    if ([imagePath isKindOfClass:[NSString class]]) {
        if ([imagePath hasPrefix:@"http"]) {
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:nil];
        } else {
            UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
//            UIImage *image = [UIImage imageNamed:imagePath];
            if (image == nil) {
                image = [UIImage imageNamed:imagePath];
//                [UIImage imageWithContentsOfFile:imagePath];
            }
            self.imageView.image = image;
        }
    } else if ([imagePath isKindOfClass:[UIImage class]]) {
        self.imageView.image = (UIImage *)imagePath;
    }
}

- (UIImageView *)imageView {
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

@end
