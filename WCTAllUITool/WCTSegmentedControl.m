//
//  WCTSegmentedControl.m
//  TestWCTAllCategory
//
//  Created by mac on 2018/5/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "WCTSegmentedControl.h"

static inline CGSize bridgeSize() {
    return CGSizeMake(8, 8);
};

@interface WCTSegmentedControl ()
@property (strong, nonatomic) UIView *redView;
@property (strong, nonatomic) NSMutableArray<UIView *> *bridgeViews;
@end

@implementation WCTSegmentedControl

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self configUI];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
        
    }
    return self;
}

- (instancetype)initWithItems:(NSArray *)items {
    if (self = [super initWithItems:items]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:12.0f]} forState:UIControlStateNormal];
    [self setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:12.0f]} forState:UIControlStateSelected];
    
    UIColor *tipColor = [UIColor colorWithRed:1.00 green:0.21 blue:0.18 alpha:1.00];
    
    for (int i = 0; i < self.numberOfSegments; i++) {
        UIView *redView = [[UIView alloc] init];
        redView.backgroundColor = tipColor;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, bridgeSize().width, bridgeSize().height) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(bridgeSize().width / 2, bridgeSize().height / 2)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.path = maskPath.CGPath;
        maskLayer.frame = CGRectMake(0, 0, bridgeSize().width, bridgeSize().height);
        redView.layer.mask = maskLayer;
        [self addSubview:redView];
        [self.bridgeViews addObject:redView];
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = self.bounds.size.height / 2;
    self.layer.borderColor = self.tintColor.CGColor;
    self.layer.borderWidth = 1.0f;
    self.layer.masksToBounds = YES;
    
    [self.bridgeViews enumerateObjectsUsingBlock:^(UIView * _Nonnull bridgeView, NSUInteger index, BOOL * _Nonnull stop) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(segmentedControShouldShowRedBridge:segmentedIndex:)]) {
            BOOL show = [self.delegate segmentedControShouldShowRedBridge:self segmentedIndex:index];
            if (show) {
                NSString *title =  [self titleForSegmentAtIndex:index];
                CGRect textRect = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Semibold" size:12.0f]} context:nil];
                CGFloat singleSegmentedWidth = self.bounds.size.width / self.numberOfSegments;
                CGFloat x = singleSegmentedWidth / 2 + (index * singleSegmentedWidth) + textRect.size.width / 2 + 3;
                CGRect frame = CGRectMake(x, CGRectGetMidY(self.bounds) - textRect.size.height / 2 - 3, bridgeSize().width, bridgeSize().height);
                
                bridgeView.frame = frame;
                bridgeView.hidden = NO;
                [self bringSubviewToFront:bridgeView];
            } else {
                bridgeView.hidden = YES;
            }
        }
    }];
}

- (void)reloadBridge {
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (NSMutableArray<UIView *> *)bridgeViews {
    if (!_bridgeViews) {
        _bridgeViews = [[NSMutableArray alloc] init];
    }
    return _bridgeViews;
}

@end

