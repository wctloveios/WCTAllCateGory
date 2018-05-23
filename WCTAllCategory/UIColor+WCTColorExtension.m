//
//  UIColor+WCTColorExtension.m
//  TestWCTAllCategory
//
//  Created by mac on 2018/5/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "UIColor+WCTColorExtension.h"

static NSMutableDictionary *cache;

static NSString* const kSystemMaticKey = @"SystemMatic";
static NSString* const kNegativeKey = @"Negative";
static NSString* const kTitleKey = @"Title";
static NSString* const kAccessaryKey = @"Accessary";
static NSString* const kAccessorialKey = @"Accessorial";
static NSString* const kMarginalKey = @"Marginal";
static NSString* const kBackgroundKey = @"Background";
static NSString* const kFillKey = @"Fill";

static NSUInteger const kSystemMaticColor = 0x00C989;
static NSUInteger const kNegativeColor = 0xFF352F;
static NSUInteger const kTitleColor = 0x333333;
static NSUInteger const kAccessaryColor = 0x999999;
static NSUInteger const kAccessorialColor = 0xAFB8BD;
static NSUInteger const kMarginalColor = 0xEDEDED;
static NSUInteger const kBackgroundColor = 0xF6F6F6;
static NSUInteger const kFillColor = 0xFFFFFF;

@implementation UIColor (WCTColorExtension)

#pragma mark - LifeCircle

+ (void)load {
    [self configDefaultColorsWithPlist:@{kSystemMaticKey:@(kSystemMaticColor),
                                         kNegativeKey:@(kNegativeColor),
                                         kTitleKey:@(kTitleColor),
                                         kAccessaryKey:@(kAccessaryColor),
                                         kAccessorialKey:@(kAccessorialColor),
                                         kMarginalKey:@(kMarginalColor),
                                         kBackgroundKey:@(kBackgroundColor),
                                         kFillKey:@(kFillColor)
                                         }];
}

#pragma mark - InitMethod
+ (nullable UIColor *)WCT_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    return [UIColor WCT_colorWithRed:red green:green blue:blue alpha:1.0f];
}

+ (nullable UIColor *)WCT_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((red) / 255.0) green:((green) / 255.0) blue:((blue) / 255.0) alpha:(alpha)];
}

+ (nullable UIColor *)WCT_colorWithHexRGB:(NSUInteger)hexRGB {
    
    return [UIColor WCT_colorWithHexRGB:hexRGB alpha:1.0f];
}

+ (nullable UIColor *)WCT_colorWithHexRGB:(NSUInteger)hexRGB alpha:(CGFloat)alpha {
    return [UIColor WCT_colorWithRed:((float)((hexRGB & 0xFF0000) >> 16)) green:((float)((hexRGB & 0xFF00) >> 8)) blue:((float)(hexRGB & 0xFF)) alpha:alpha];
}

#pragma mark - CacheColor
+ (nullable UIColor *)WCT_systemMaticColor {
    return [self WCT_colorWithCacheKey:kSystemMaticKey];
}

+ (nullable UIColor *)WCT_negativeColor {
    return [self WCT_colorWithCacheKey:kNegativeKey];
}

+ (nullable UIColor *)WCT_titleColor {
    return [self WCT_colorWithCacheKey:kTitleKey];
}

+ (nullable UIColor *)WCT_accessaryColor {
    return [self WCT_colorWithCacheKey:kAccessaryKey];
}

+ (nullable UIColor *)WCT_accessorialColor {
    return [self WCT_colorWithCacheKey:kAccessorialKey];
}

+ (nullable UIColor *)WCT_marginalColor {
    return [self WCT_colorWithCacheKey:kMarginalKey];
}

+ (nullable UIColor *)WCT_backgroundColor {
    return [self WCT_colorWithCacheKey:kBackgroundKey];
}

+ (nullable UIColor *)WCT_fillColor {
    return [self WCT_colorWithCacheKey:kFillKey];
}

+ (nullable UIColor *)WCT_colorWithCacheKey:(NSString *)key {
    NSNumber *number = [cache valueForKey:key];
    if (number == nil || ![number isKindOfClass:[NSNumber class]]) {
        return nil;
    }
    NSUInteger value = [number unsignedIntegerValue];
    if (isnan(value) || isinf(value)) {
        return nil;
    }
    
    return [UIColor WCT_colorWithHexRGB:value];
}

+ (void)configDefaultColorsWithPlist:(NSDictionary *)plist {
    static NSArray *keys = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[NSMutableDictionary alloc] initWithCapacity:8];
        keys = @[kSystemMaticKey,kNegativeKey,kTitleKey,
                 kAccessaryKey,kAccessorialKey,kMarginalKey,
                 kBackgroundKey,kFillKey];
    });
    if (plist != nil) {
        [cache removeAllObjects];
        [plist enumerateKeysAndObjectsUsingBlock:^(NSString *colorName, NSNumber  *colorValue, BOOL * _Nonnull stop) {
            [keys enumerateObjectsUsingBlock:^(id  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([colorName isEqualToString:key]) {
                    [cache setValue:colorValue forKey:key];
                }
            }];
        }];
    }
}

@end
