//
//  WCTSegmentedControl.h
//  TestWCTAllCategory
//
//  Created by mac on 2018/5/23.
//  Copyright © 2018年 mac. All rights reserved.
//  The author：FJH

#import <UIKit/UIKit.h>

@class WCTSegmentedControl;

@protocol WCTSegmentedControlDelegate<NSObject>

@optional

/**
 红点显示代理
 
 @param segmentedControl    控件本身
 @param segmentedIndex 按钮的index
 @return 是否显示红点
 */
- (BOOL)segmentedControShouldShowRedBridge:(WCTSegmentedControl *)segmentedControl
                            segmentedIndex:(NSUInteger)segmentedIndex;

@end

@interface WCTSegmentedControl : UISegmentedControl
@property (weak, nonatomic) id<WCTSegmentedControlDelegate> delegate;

/**
 刷新红点标记
 */
- (void)reloadBridge;

@end
