//
//  TLExpressionItemCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionItemCell.h"
#import <SDWebImage/UIImage+GIF.h>
#import "UIImage+Color.h"

@interface TLExpressionItemCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TLExpressionItemCell

+ (CGSize)viewSizeByDataModel:(id)dataModel
{
    return CGSizeMake(EXP_DETAIL_CELL_WIDTH, EXP_DETAIL_CELL_WIDTH);
}

- (void)setViewDataModel:(id)dataModel
{
    [self setEmoji:dataModel];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        
        [self p_addMasonry];
    }
    return self;
}

- (void)setEmoji:(TLExpressionModel *)emoji
{
    _emoji = emoji;
    UIImage *image = [UIImage imageNamed:emoji.path];
    if (image) {
        [self.imageView setImage:image];
    }
    else {
        [self.imageView tt_setImageWithURL:TLURL(emoji.url)];
    }
}

#pragma mark - # Private Methods
- (void)p_addMasonry
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}

#pragma mark - # Getter
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        [_imageView.layer setMasksToBounds:YES];
        [_imageView.layer setCornerRadius:3.0f];
    }
    return _imageView;
}

@end
