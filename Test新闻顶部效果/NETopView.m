//
//  NETopView.m
//  Test新闻顶部效果
//
//  Created by iCodeWoods on 16/7/7.
//  Copyright © 2016年 iCodeWoods. All rights reserved.
//

#import "NETopView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

static NSString *const kFrame = @"frame";

@interface NETopView ()
@property (nonatomic, strong) UIImageView *backView;
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation NETopView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blueColor];
        [self addSubview:self.backView];
        [self addSubview:self.avatar];
        [self addSubview:self.nameLabel];
        [self addObserver:self forKeyPath:kFrame options:0 context:nil];
    }
    return self;
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:kFrame];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:kFrame]) {
        CGFloat originY = -self.frame.origin.y;
        NSLog(@"^^^^^ originY = %f", originY);
        
        CGFloat alpha = originY / ((CGRectGetHeight(self.frame)-64)/2);
        self.avatar.alpha = 1 - alpha;
        if (alpha >= 1.0) {
            self.nameLabel.center = CGPointMake(ScreenWidth/2, CGRectGetHeight(self.frame)-CGRectGetHeight(self.nameLabel.frame)/2-10);
            self.nameLabel.alpha = alpha - 1;
        } else {
            self.nameLabel.center = CGPointMake(ScreenWidth/2, CGRectGetMaxY(self.avatar.frame)+20);
            self.nameLabel.alpha = 1 - alpha;
        }
    }
}

#pragma mark - getter && setter
- (UIImageView *)avatar {
    if (!_avatar) {
        _avatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _avatar.center = CGPointMake(ScreenWidth/2, self.frame.size.height/2);
        _avatar.image = [UIImage imageNamed:@"0"];
    }
    return _avatar;
}

- (UIImageView *)backView {
    if (!_backView) {
        _backView = [[UIImageView alloc] initWithFrame:self.bounds];
        _backView.image = [UIImage imageNamed:@"cover"];
    }
    return _backView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
        _nameLabel.text = @"随心所欲w";
        [_nameLabel sizeToFit];
        _nameLabel.center = CGPointMake(ScreenWidth/2, CGRectGetMaxY(self.avatar.frame)+20);
    }
    return _nameLabel;
}

@end
