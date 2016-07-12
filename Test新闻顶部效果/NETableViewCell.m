//
//  NETableViewCell.m
//  Test新闻顶部效果
//
//  Created by iCodeWoods on 16/7/7.
//  Copyright © 2016年 iCodeWoods. All rights reserved.
//

#import "NETableViewCell.h"
#import "NEModel.h"

@interface NETableViewCell ()
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@end

@implementation NETableViewCell

#pragma mark - init
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.avatar];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.contentLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.avatar.frame = CGRectMake(10, 10, 35, 35);
    self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.avatar.frame)+10, self.avatar.frame.origin.y, 200, 30);
    self.contentLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, CGRectGetMaxY(self.nameLabel.frame)+20, 300, 40);
}

#pragma mark - getter && setter
- (void)setModel:(NEModel *)model {
    _model = model;
    _avatar.image = [UIImage imageNamed:model.imgPath];
    _nameLabel.text = model.nickname;
    _contentLabel.text = model.content;
}

- (UIImageView *)avatar {
    if (!_avatar) {
        _avatar = [[UIImageView alloc] init];
    }
    return _avatar;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
    }
    return _nameLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
    }
    return _contentLabel;
}

@end
